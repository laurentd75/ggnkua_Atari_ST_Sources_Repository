
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ext.h>
#include <math.h>
#include "patch.h"
#include "types.h"

#define NO_SAMPS (10)

PATCH_HEADER header;
INSTRUMENT_DATA ins;
LAYER_DATA layer;
PATCHDATA sample[NO_SAMPS];
int no_samples;
short patchdata[NO_SAMPS][250000l];
short thispatch[250000l];

NEW_PATCH_MAIN_HEADER new_patch;
NEW_SAMPLE_HEADER new_sample[128];
alloc16 new_patchdata[128];

/*
 *	Allocate memory on a 16 byte boundary.
 */
 
void *malloc16(long l,alloc16 *a)
{		if	(a != NULL)
		{	if ((a->allocd = calloc(1l,l+16l)) != NULL)
			{	a->ptr = ((long) (a->allocd)+15) & 0xfffffff0;
				return (a->ptr);
			}
		}
		return NULL;
}

/*
 *	Free a memory block on a 16 byte boundary.
 */

void free16(alloc16 *a)
{	if (a->allocd != NULL)
	{	free(a->allocd);
		a->allocd = NULL;
		a->ptr = NULL;
	}
}


/*
 * Find least common multiple of the two sample rates.
 * Construct the signal at the LCM by interpolating successive
 * input samples as straight lines.  Pull output samples from
 * this line at output rate.
 *
 * Of course, actually calculate only the output samples.
 *
 * LCM must be 32 bits or less.  Two prime number sample rates
 * between 32768 and 65535 will yield a 32-bit LCM, so this is 
 * stretching it.
 *
 *  Generate a master sample clock from the LCM of the two rates.
 *  Interpolate linearly along it.  Count up input and output skips.
 *
 *  Input:   |inskip |       |       |       |       |
 *
 *  LCM:     |   |   |   |   |   |   |   |   |   |   |
 *
 *  Output:  |  outskip  |           |           | 
 *                                                                      
 */


long gcd(long a, long b) 
{	if (b == 0)
		return a;
	else
		return gcd(b, a % b);
}

long lcm(long a, long b) 
{	return (a * b) / gcd(a, b);
}

typedef struct  {
	unsigned long lcmrate;		
	unsigned long inskip, outskip;	
	unsigned long intot, outtot;	
	long	lastsamp;
} ratestuff;

ratestuff rate;



/*
 * Processed signed long samples from ibuf to obuf.
 * Return number of samples processed.
 */

long lcm_freq_shifter(short *ibuf, short*obuf, long isamp, long osamp,long in__rate,long out_rate)
{	long len, done;
	short *istart = ibuf;
	short last;
	rate.lcmrate = lcm((long)in__rate, (long)out_rate);
	rate.inskip =  rate.lcmrate / in__rate;
	rate.outskip = rate.lcmrate / out_rate; 
	rate.intot = rate.outtot = 0;
	last = *obuf++ = *ibuf++;
	rate.outtot += rate.outskip;
	while ((rate.intot + rate.inskip) <= rate.outtot){
		last = *ibuf++;
		rate.intot += rate.inskip;
	}
	len = (isamp*rate.inskip)/rate.outskip;
	if (len > osamp)
		len = osamp;
	for(done=1; done < len; done++) {
		*obuf = last;
		*obuf += ((double)((*ibuf)-last)*((double)rate.outtot-rate.intot))/rate.inskip;
		obuf++;
		rate.outtot += rate.outskip;
		while ((rate.intot + rate.inskip) <= rate.outtot){
			last = *ibuf++;
			rate.intot += rate.inskip;
			if (ibuf - istart == isamp)
				return done;
		}
		if (rate.outtot == rate.intot)
			rate.outtot = rate.intot = 0;
	}
	return done;
}

int match_sample_patch(long freq)
{	int i,j=-1;
	long k,min = 0x7fffffff;
	for ( i = 0; i < layer.samples; i++ )
	{	if ((freq >= sample[i].low_frequency) && (freq <= sample[i].high_frequency))
			return i;
		k = freq-(sample[i].root_frequency);
		if ( k < 0)
			k = -k;
		
		if ( k < min )
		{	min = k;
			j = i;
		}
	}
	return j;
}


void conv_patch(char *patch,int n)
{	int i,m,l=0,match;
    FILE *fil;
	long j = sizeof(NEW_PATCH_MAIN_HEADER),mnote;
	long div_midi_note = 16; 
	mnote = 32;
    for ( i = 0; i < n; i++ )
	{		double ratio,freq;
			long new_len;
			NEW_SAMPLE_HEADER *new = &(new_sample[i]);
			mnote += div_midi_note;
			match = match_sample_patch(round(freq));
			freq = ( (double) 6.875*1000.0*pow(2.0,((double)mnote/12.0)));
 			ratio = ( (double) sample[match].sample_rate/32780.0) * 
 					( freq / (double) sample[match].root_frequency);
			for (m=l ; m < mnote ; m++)
			{		double this_freq = ( (double) 6.875*1000.0*pow(2.0,((double)m)/12.0) );
					new_patch.sample_offsets[m] = j;
					new_patch.sample_freqshs[m] = round(this_freq/freq*65536.0*256.0) ;
			}
			new->wave_size = ((long) ( (double) sample[match].wave_size / ratio)) & 0xfffffffe;
			new->start_loop = ((long) ( (double) sample[match].start_loop / ratio)) & 0xfffffffe;
			new->end_loop = ((long) ( (double) sample[match].end_loop / ratio)) & 0xfffffffe;
			new->tune = sample[match].tune;
			new->scale_frequency = sample[match].scale_frequency;
			new->scale_factor = sample[match].scale_factor;
			new->sample_rate = sample[match].sample_rate;
			memcpy (&(new->envelope_rate[0]),&(sample[match].envelope_rate[0]),ENVELOPES);
			memcpy (&(new->envelope_offset[0]),&(sample[match].envelope_offset[0]),ENVELOPES);
			new->balance = sample[match].balance;
			new->modes = sample[match].modes;

			if (malloc16(new->wave_size+1024,&(new_patchdata[i])) == NULL)
			{	printf("\nOUT OF MEMORY\n");
				exit (-2);
			}	
			

			new_len= lcm_freq_shifter(
 							&patchdata[match][0],
 							new_patchdata[i].ptr,
 							sample[match].wave_size >> 1,
 							new->wave_size >> 1,
 							(long) 16384,
 							(long) (16384.0/ratio));
			new->wave_size = new_len << 1;
			printf("%d %ld %2.2f ",match,new->wave_size,ratio);
 							
 			if (new_sample[i].start_loop > new->wave_size)
	 			new_sample[i].start_loop = new->wave_size;

 			if (new_sample[i].end_loop > new->wave_size)
	 			new_sample[i].end_loop = new->wave_size;
 						
			j += sizeof(NEW_SAMPLE_HEADER)+new->wave_size;
			l = mnote;
	}

	if ( (fil = fopen( patch, "wb" )) != NULL )
	{
 	   fwrite( &new_patch, sizeof(NEW_PATCH_MAIN_HEADER), 1l, fil );
	   for ( i = 0; i < new_patch.num_samples; i++ )
	   { 	fwrite( &(new_sample[i]), sizeof(NEW_SAMPLE_HEADER), 1l, fil );
	  		fwrite( new_patchdata[i].ptr, new_sample[i].wave_size, 1l, fil );
			free16(&(new_patchdata[i]));
	   }
	   fclose(fil);
	} else
	    printf( "Couldn't open file for writing.\n" );
}


/* reads and Ldisplays information from the .PAT file */

void read_patch(char *patch )
{ FILE *fil;
  int i,j;
 
  if ( (fil = fopen( patch, "rb" )) != NULL )
  {
    /* Unix based routines, assume big-endian machine */
    /* read header */
    fread( &header.header, sizeof(header.header), 1, fil );
    fread( &header.gravis_id, sizeof(header.gravis_id), 1, fil );
    fread( &header.description, sizeof(header.description), 1, fil );
    fread( &header.instruments, sizeof(header.instruments), 1, fil );
    fread( &header.voices, sizeof(header.voices), 1, fil );
    fread( &header.channels, sizeof(header.channels), 1, fil );
    fread( &header.wave_forms, sizeof(header.wave_forms), 1, fil );
    fread( &header.master_volume, sizeof(header.master_volume), 1, fil );
    fread( &header.data_size, sizeof(header.data_size), 1, fil );
    fread( &header.reserved, sizeof(header.reserved), 1, fil );
    header.wave_forms = swapi( header.wave_forms );
    header.master_volume = swapi( header.master_volume );
    header.data_size = swapl( header.data_size );
    /* read instrument header */
    fread( &ins.instrument, sizeof(ins.instrument), 1, fil );
    fread( &ins.instrument_name, sizeof(ins.instrument_name), 1, fil );
    fread( &ins.instrument_size, sizeof(ins.instrument_size), 1, fil );
    fread( &ins.layers, sizeof(ins.layers), 1, fil );
    fread( &ins.reserved, sizeof(ins.reserved), 1, fil );
    ins.instrument_size = swapl( ins.instrument_size );
    /* read layer header */
    fread( &layer.layer_duplicate, sizeof(layer.layer_duplicate), 1, fil );
    fread( &layer.layer, sizeof(layer.layer), 1, fil );
    fread( &layer.layer_size, sizeof(layer.layer_size), 1, fil );
    fread( &layer.samples, sizeof(layer.samples), 1, fil );
    fread( &layer.reserved, sizeof(layer.reserved), 1, fil );
    layer.layer_size = swapl( layer.layer_size );
 
    printf( "\n\n" );

    {
      printf( "%s\n", strupr( patch ) );
      printf( "Name: %s\n", ins.instrument_name );
      printf( "Description: %s\n", header.description );
      printf( "Number of samples: %u\n", header.wave_forms );
      printf( "Total patch size: %lu bytes\n", header.data_size );
	  no_samples = layer.samples;
 
      /* read sample information */
      for ( i = 0; i < layer.samples; i++ )
      {	
        fread( &sample[i].wave_name, sizeof(sample[i].wave_name), 1, fil );
        fread( &sample[i].fractions, sizeof(sample[i].fractions), 1, fil );
        fread( &sample[i].wave_size, sizeof(sample[i].wave_size), 1, fil );
        fread( &sample[i].start_loop, sizeof(sample[i].start_loop), 1, fil );
        fread( &sample[i].end_loop, sizeof(sample[i].end_loop), 1, fil );
        fread( &sample[i].sample_rate, sizeof(sample[i].sample_rate), 1, fil );
        fread( &sample[i].low_frequency, sizeof(sample[i].low_frequency), 1, fil );
        fread( &sample[i].high_frequency, sizeof(sample[i].high_frequency), 1, fil );
        fread( &sample[i].root_frequency, sizeof(sample[i].root_frequency), 1, fil );
        fread( &sample[i].tune, sizeof(sample[i].tune), 1, fil );
        fread( &sample[i].balance, sizeof(sample[i].balance), 1, fil );
        fread( &sample[i].envelope_rate, sizeof(sample[i].envelope_rate), 1, fil );
        fread( &sample[i].envelope_offset, sizeof(sample[i].envelope_offset), 1, fil );
        fread( &sample[i].tremolo_sweep, sizeof(sample[i].tremolo_sweep), 1, fil );
        fread( &sample[i].tremolo_rate, sizeof(sample[i].tremolo_rate), 1, fil );
        fread( &sample[i].tremolo_depth, sizeof(sample[i].tremolo_depth), 1, fil );
        fread( &sample[i].vibrato_sweep, sizeof(sample[i].vibrato_sweep), 1, fil );
        fread( &sample[i].vibrato_rate, sizeof(sample[i].vibrato_rate), 1, fil );
        fread( &sample[i].vibrato_depth, sizeof(sample[i].vibrato_depth), 1, fil );
        fread( &sample[i].modes, sizeof(sample[i].modes), 1, fil );
        fread( &sample[i].scale_frequency, sizeof(sample[i].scale_frequency), 1, fil );
        fread( &sample[i].scale_factor, sizeof(sample[i].scale_factor), 1, fil );
        fread( &sample[i].reserved, sizeof(sample[i].reserved), 1, fil );
        sample[i].wave_size = swapl( sample[i].wave_size );
        sample[i].start_loop = swapl( sample[i].start_loop );
        sample[i].end_loop = swapl( sample[i].end_loop );
        sample[i].sample_rate = swapi( sample[i].sample_rate );
		sample[i].low_frequency = swapl(sample[i].low_frequency);
		sample[i].high_frequency = swapl(sample[i].high_frequency);
		sample[i].root_frequency = swapl(sample[i].root_frequency);
		sample[i].tune = swapi(sample[i].tune);
		sample[i].scale_frequency = swapi(sample[i].scale_frequency);
        sample[i].scale_factor = swapi( sample[i].scale_factor );

        if ( sample[i].scale_factor == 0 ) printf( "Percussion " );
        printf( "Wave name: %s [%ld bytes]\n", sample[i].wave_name, sample[i].wave_size );
        printf( "  %s bit, %u Hz\n", (sample[i].modes & 1) ? "16" : "8", sample[i].sample_rate );
        if ( sample[i].modes & 32 ) printf( "  Sustained, " );
        else
          printf( "  " );
        if ( sample[i].modes & 64 ) printf( "Enveloped, " );
        if ( sample[i].modes & 4 == 0 ) printf( "Non-looping" );
        else
        if ( sample[i].modes & 8 ) printf( "Bidirectional-looping" );
        else
        if ( sample[i].modes & 16 ) printf( "Backward-looping" );
        else
        if ( sample[i].modes & 4 ) printf( "Looping" );

        if ( sample[i].tremolo_depth ) printf( ", Tremolo ON" );
        if ( sample[i].vibrato_depth ) printf( ", Vibrato ON" );

        fread( &thispatch[0], sample[i].wave_size, 1, fil );
		if (sample[i].modes & 1) 
		{	unsigned long l;
			short *src = &thispatch[0];
			short *dst = &patchdata[i][0];
			long len = (sample[i].wave_size >> 1);
			for (l = 0 ; l < len; l++ )
			{	short a = swapi(src[l]);
				if (sample[i].modes & 2)
					a ^= 0x8000;
				dst [l] = a;
			}
      	}  else
		{	unsigned long l;
			char *src = &thispatch[0];
			short *dst = &patchdata[i][0];
			long len = sample[i].wave_size;
			sample[i].wave_size *= 2;
			sample[i].start_loop *= 2;
			sample[i].end_loop *= 2;
			for (l = 0 ; l < len; l++ )
			{	unsigned short a = ((unsigned short) src[l]) << 8;
				if (sample[i].modes & 2)
					a ^= 0x8000;
				dst [l] = a;
			}
		} 			

		printf("\nlow:%lX high:%lX root:%lX scale:%X factor:%X tune:%X\n",
			sample[i].low_frequency,sample[i].high_frequency,sample[i].root_frequency,sample[i].scale_frequency,sample[i].scale_factor,sample[i].tune);
	
		for (j=0 ; j <= 5 ; j++)
			printf("%X %X ",sample[i].envelope_offset[j],sample[i].envelope_rate[j]);
        printf( "\n" );

      }
    }
    fclose( fil );
  }
  else
    printf( "Error accessing file!\n" );
}


void create_kit(char *path)
{	int i;
	long j = sizeof(NEW_PATCH_MAIN_HEADER),new_len;
	double ratio,freq;
	new_patch.num_samples = NO_PERCUSSION;
	for (i = 0 ; i < NO_PERCUSSION ; i++)
	{	NEW_SAMPLE_HEADER *new = &(new_sample[i]);
		read_patch(gm_percussion_fnames[i]);
		freq = ( (double) 6.875*1000.0*pow(2.0,((double)35+i-sample[0].scale_frequency)/12.0) );

		ratio = ( (double) sample[0].sample_rate/32780.0) * 
				( freq / (double) sample[0].root_frequency);
		new->wave_size = ((long) ( (double) sample[0].wave_size / ratio)) & 0xfffffffe;
		new->tune = sample[0].tune;
		new->scale_frequency = sample[0].scale_frequency;
		new->scale_factor = sample[0].scale_factor;
		new->sample_rate = sample[0].sample_rate;
		memcpy (&(new->envelope_rate[0]),&(sample[0].envelope_rate[0]),ENVELOPES);
		memcpy (&(new->envelope_offset[0]),&(sample[0].envelope_offset[0]),ENVELOPES);
		new->balance = sample[0].balance;
		new->modes = sample[0].modes;
		new_patch.sample_offsets[i] = j;
		new_patch.sample_freqshs[i] = (ratio*65536.0*256.0) ;
		new->start_loop = 0;
		new->end_loop = 0;

		if (malloc16(new->wave_size+1024,&(new_patchdata[i])) == NULL)
		{	printf("\nOUT OF MEMORY\n");
			exit (-2);
		}	
	/*	new_len= lcm_freq_shifter(
							&patchdata[0][0],
 							new_patchdata[i].ptr,
 							sample[0].wave_size >> 1,
 							new->wave_size >> 1,
 							(long) 16384,
 							(long) (16384.0/ratio));*/
		new->wave_size = new_len << 1;
		j += sizeof(NEW_SAMPLE_HEADER)+new->wave_size;
	}

	/*
	if ( (fil = fopen( patch, "wb" )) != NULL )
	{
 	   fwrite( &new_patch, sizeof(NEW_PATCH_MAIN_HEADER), 1l, fil );
	   for ( i = 0; i < NO_PERCUSSION; i++ )
	   { 	fwrite( &(new_sample[i]), sizeof(NEW_SAMPLE_HEADER), 1l, fil );
	  		fwrite( new_patchdata[i].ptr, new_sample[i].wave_size, 1l, fil );
			free16(&(new_patchdata[i]));
	   }
	   fclose(fil);
	} else
	    printf( "Couldn't open file for writing.\n" );
	*/
	
}	
 
/* main program */
void main( char argc, char **argv )
{	long	i;
	create_kit("g:\\gm2.set\\drumkit1.pat");	

/*	for (i = 0 ; i < NO_INSTRUMENT ; i++)
	{	read_patch(gm_instrument_fnames[i]);
		gm_instrument_fnames[i][0] = 'g';
		gm_instrument_fnames[i][5] = '2';
		new_patch.num_samples = 6;
		conv_patch(gm_instrument_fnames[i],new_patch.num_samples);
	} 
*/
	
/*		read_patch("f:\\gm1.set\\acpiano.pat");
		conv_patch("g:\\gm2.set\\acpiano.pat");
		read_patch("f:\\gm1.set\\halopad.pat");
		conv_patch("g:\\gm2.set\\halopad.pat");
		read_patch("f:\\gm1.set\\bowglass.pat");
		conv_patch("g:\\gm2.set\\bowglass.pat");
		*/
}
