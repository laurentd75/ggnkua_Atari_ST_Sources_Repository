<?php
	error_reporting(E_ALL & ~E_NOTICE);
	ini_set('memory_limit','4096M');

	$nr_sprites = 268;
	$wavetab = file("wave268.txt");


	$generateClearData	= true;
	$makeColissionTable = false;
	$fullPass = false;
	$endless = true;
	$nrAttempts = 5000;
	if(!$fullPass){
		$nrAttempts *=25;
	}




	if($makeColissionTable){
		$allCollision = array();
	}
	else{
		$allCollision = json_decode(file_get_contents("framecollisions.json"),true);
	}



	// colors-index:
	// 	0;	black	(0,0,0)
	//	1;	red		(255,0,0)
	//	2;	green	(0,255,0)
	//	3;	blue		(0,0,255)
	//	4;	dark red over green	(68,127,0)			dark red = 1 plane		== taint
	//	5;  dark derd over blue	(68,0,127)			dark red = 1 plane, blue = 1 plane ==> good
	//	6;	dark red	(68,0,0)					1 plane clear
	//	7;	bright red over green (127,127,0)
	//	8;	bright red over blue	(127,0,127)
	//	9;	bright red (127,0,0)

//	$nr_sprites = 10000;
//	$wavetab = file("wave10000.txt");
	function	printColors($my_img){
		$nr_cols = imagecolorstotal($my_img);
		echo $nr_cols . "\n";
		for($i=0; $i<$nr_cols;$i++){
			print_r(imagecolorsforindex($my_img,$i));
		}

	}

	function	isBlockClear($image,$x_start,$y){
		$opt = $x_start+16;
		for($x=$x_start; $x<$opt; $x++){
			$color = imagecolorat($image, $x , $y);
			if( $color == 2 || $color == 3 || $color == 4 ){
				return false;
			}
		}
		return true;
	}

	function	blockApplicable($image,$x_start,$y){
		for($x=$x_start; $x<$x_start+16; $x++){
			$color = imagecolorat($image, $x , $y);
			if( $color >= 4 && $color <= 9){
				return true;
			}
		}
		return false;
	}

	// masked is a succesful clear saved
	function	blockMasked($image,$x_start,$y){
		$masked = false;
		for($x=$x_start; $x<$x_start+16; $x++){
			$color = imagecolorat($image, $x , $y);
			if( $color == 5 || $color == 7 || $color == 8){
				$masked = true;
			}
			if( $color == 4 || $color == 2 || $color == 3){
				return false;
			}
		}
		return $masked;
	}

	function	drawSprite($wavetab,$my_img,$image,$z,$nr_sprites){
		$count = 0;
		$frame = ($z)%360;
		$frame *= ($nr_sprites+1);
		$opt = $frame+$nr_sprites+1;
//		for($i=$frame+1; $i<($frame+$nr_sprites);$i++){
		for($i=$frame+1; $i<$opt;$i++){
			$tmp = explode(";",$wavetab[$i]);
			$x = $tmp[2];
			$y = $tmp[3];
			imagecopy($my_img, $image, $x,$y,0,0,16,16);
		}
	}



	function	drawSpriteClearOrdered($listOfMasks,$my_img,$clearList,$nr_sprites){
		$nr_moves = 0;
		foreach($listOfMasks as $key => $data){
			$x = $data['x'];
			$y = $data['y'];
			$selectedImage = $clearList[$x%16];
			$x = $x - $x%16;

			if(!hasCollision($my_img,$selectedImage,$x,$y)){
				imagecopymerge($my_img,$selectedImage,$x,$y,0,0,32,16,50);
				$nr_moves++;
			}
			else{
				echo "ERROR WITH MASK: " . $data['id'] . "\n";
//				imagecopymerge($my_img,$selectedImage,$x,$y,0,0,32,16,100);
			}

		}
		return $nr_moves;
	}

	function	makeListOfMasks($maxSolution,$wavetab,$z,$nr_sprites){
		$frame = ($z+2)%360;
		$frame *= ($nr_sprites+1);
		$frame++;

		$result = array();
		foreach($maxSolution as $key => $value){
			$lif = $frame+$value;
			$tmp = explode(";",$wavetab[$lif]);
			$x = $tmp[2];
			$y = $tmp[3];
			$result[] = array('x'=>$x, 'y'=>$y, 'id' => $value, 'lif'=>$lif);
		}	
		return $result;
	}


	function	hasCollision($image, $sprite, $x, $y){
		$res = false;
		for($yi=0;$yi<16;$yi++){
			for($xi=0;$xi<32;$xi++){
				$c = imagecolorat($sprite, $xi , $yi);
				if($c!=3){						// 3 is the background
					// if we dont hit background, we check for collision
					$xl = $xi+$x;
					$yl = $yi+$y;
					if(imagecolorat($image, $xl , $yl) > 3){
						$res = true;
					}
				}
//				echo $c;
			}
//			echo "\n";
		}
//		echo "\n";
		return $res;
	}




	function	createSpritesTable($wavetab,$my_img,$z,$nr_sprites,$clearList){
		$frame = ($z+2)%360;																	// frame + 2 for sprites
		$frame *= ($nr_sprites+1);
		$spriteList = array();
		$opt = $frame+$nr_sprites+1;
		for($i=$frame+1; $i<$opt;$i++){																// get all sprite values
			$tmp = explode(";",$wavetab[$i]);
			$x = $tmp[2];
			$y = $tmp[3];
			$spriteList[] = array('x'=>$x,'y'=>$y);
		}

		/**
		// now we analyse the number of 16 pxl blocks we need to clear
		$clearCountForFrame = 0;
		for($y = 0;$y<192; $y++){
			for($x=0; $x<20; $x++){
				if(!isBlockClear($my_img,$x*16,$y))
				{
					$clearCountForFrame++;
				}
			}
		}
		*/

		// now we have a list of all sprites, we go generate a map
		$spriteCollision = array();
		for($i=0;$i<$nr_sprites;$i++){
			$tmp = imagecreate( 320, 200 );								// canvas
			imagecolorallocate( $tmp, 0, 0, 0 );			// 0
			imagecolorallocate( $tmp, 255, 0, 0 );				// 1 red
			imagecolorallocate( $tmp, 0, 255, 0 );				// 2 green
			imagecolorallocate( $tmp, 0, 0, 255 );						// 3 blue
			imagecolorallocate( $tmp, 68,127,0);							// 4 dark red over green
			imagecolorallocate( $tmp, 68,0,127);							// 5 dark red over blue
			imagecolorallocate( $tmp, 68,0,0);							// 6 dark red 
			imagecolorallocate( $tmp, 127,127,0);						// 7 bright red over green
			imagecolorallocate( $tmp, 127,0,127);						// 8 bright red over blue
			imagecolorallocate( $tmp, 127,0,0);							// 6 bright red 
			imagecopy($tmp,$my_img,0,0,0,0,320,200);


			// get coordinates of current value
			$cX = $spriteList[$i]['x'];
			$cY = $spriteList[$i]['y'];
			// put image resource into canvas
			$cImage = $clearList[$cX%16];									// grab image resource
			$cXAligned = $cX-($cX%16);
			imagecopyMerge($tmp, $cImage, $cXAligned, $cY, 0, 0, 32, 16,50);				// copy into canvas for collision detection

			/**
			// now we analyse the number of 16 pxl blocks we need to clear
			$clearCountForSprite = 0;
			for($y = 0;$y<192; $y++){
				for($x=0; $x<20; $x++){
					if(!isBlockClear($tmp,$x*16,$y))
					{
						$clearCountForSprite++;
					}
				}
			}

			$spriteCollision[$i]['bS'] = $clearCountForFrame - $clearCountForSprite;
			*/


			// now do the same as clear


			// now count how many 16 pixel blocks are overlapped
			$masked = 0;
			$applicable = 0;
			for($ys=0;$ys < 16; $ys++){
				$useY = $ys+$cY;
				for($xs=0;$xs < 32; $xs+=16){
					if(blockMasked($tmp,($xs+$cXAligned),$useY)){
						$masked++;
					}
					if(blockApplicable($tmp,($xs+$cXAligned),$useY)){
						$applicable++;
					}
				}
			}

			$spriteCollision[$i]['bS'] = $masked;
			/**
			if($masked != $spriteCollision[$i]['bS']){
				echo "NOT OK!: masked: " .$masked . " count = " . $spriteCollision[$i]['bS'] .  "\n";
						imagepng( $tmp, "BUG.PNG" );
						exit();

			}
			*/




			for($j=$i;$j<$nr_sprites;$j++){
				if($j==$i){
						$spriteCollision[$j][$i] = 0;
				}
				else{
					$nX = $spriteList[$j]['x'];
					$nxAligned = $nX - ($nX%16);
					$nY = $spriteList[$j]['y'];
					if(abs($cXAligned-$nxAligned) > 32 && abs($cY-$nY) > 16){				// check if within bounds; if not within 32x16 space, then surely no collision
						$spriteCollision[$i][$j] = 0;
						$spriteCollision[$j][$i] = 0;
					}
//					else{													// here we need to make sure with detailed mask ifnormation
//							$spriteCollision[$i][$j] = 1;
//							$spriteCollision[$j][$i] = 1;
//					}
						// get mask from target
						$nImage = $clearList[$nX%16];
						if(hasCollision($tmp,$nImage,$nxAligned,$nY)){
							$spriteCollision[$i][$j] = 1;
							$spriteCollision[$j][$i] = 1;

						}
						else{
							$spriteCollision[$i][$j] = 0;
							$spriteCollision[$j][$i] = 0;
						}
					
//					}
				}
			}
			$nr_cols = 0;
			for($k=0;$k<$nr_sprites;$k++){
				if($spriteCollision[$i][$k]){
					$nr_cols++;
				}
			}
			$spriteCollision[$i]['cols'] = $nr_cols;
		}
		return $spriteCollision;

	}

	function	getConflicts($pick,$frameCollisions){
		$conflicts = array();
		$pickArray = $frameCollisions[$pick];
		foreach($pickArray as $key => $value){
			if($value){
				$conflicts[] = $key;
			}
		}
		return $conflicts;
	}

	function	getRandomSolution($frameCollisions, $nr_sprites){
		$conflicts = array();
		$solution = array();
		$candidates = array();
		// init candidates
		for($i=0;$i<$nr_sprites;$i++){
			$candidates[] = $i;
		}
		while(!empty($candidates)){
			// pick random element
			$pick = array_rand($candidates);
			// add pick to solution
			$solution[] = $pick;
			// get key:
//			$key = array_search($pick, $candidates);
			unset($candidates[$pick]);
			// remove all conflicting elements from this pick from array
			// get conflicts
			$conflicts = getConflicts($pick,$frameCollisions);
			$candidates = array_diff($candidates, $conflicts);
		}
		return $solution;
	}

	$maxtaint = 0;
	$maxtaint2 = 0;
	$maxtaint2frame = 0;
	$sprite_plane1 = imagecreatefromgif( "sprite_pl1.gif");					// sprite
	$sprite_plane2 = imagecreatefromgif( "sprite_pl2.gif");					// sprite
	$sprite2 = imagecreatefromgif( "sprite2.gif");					// sprite

	$clearList	= array();
	for($i=1;$i<17;$i++){
		$movesprite = "lmove_sprite" . $i . ".gif";
		$clearList[$i-1] = imagecreatefromgif($movesprite);
//		printColors($clearList[$i-1]);
	}	

	for($z=0;$z<360;$z++){
		$worst = 0;
		for($f=0;$f<360;$f++){
			$frameNumber = str_pad($f, 3, '0', STR_PAD_LEFT);
			$fileName= "results_". $frameNumber . ".json";
			$res = json_decode(file_get_contents($fileName),true);
			if($res['clearRemaining'] > $worst){
				$worst = $res['clearRemaining'];
				$fn = $fileName;
				$oldResults = $res;
				$framed = $f;
				if(!$fullPass){
					$z = $f;
				}
			}
		}
		if(!$fullPass){
			echo " worst frame: " . $framed . " " . $fn . " count: " . $worst . " saved: " . $oldResults['saved'].  "\n";
		}

		$frameNumber = str_pad($z, 3, '0', STR_PAD_LEFT);
		$fileName= "results_". $frameNumber . ".json";
		$oldResults = json_decode(file_get_contents($fileName),true);
		$prevBest = $oldResults['saved'];

		$my_img = imagecreate( 320, 200 );								// canvas
		$background = imagecolorallocate( $my_img, 0, 0, 0 );			// 0
		$text = imagecolorallocate( $my_img, 255, 0, 0 );				// 1 red
		$text2 = imagecolorallocate( $my_img, 0, 255, 0 );				// 2 green
		imagecolorallocate( $my_img, 0, 0, 255 );						// 3 blue
		imagecolorallocate( $my_img, 68,127,0);							// 4 dark red over green
		imagecolorallocate( $my_img, 68,0,127);							// 5 dark red over blue
		imagecolorallocate( $my_img, 68,0,0);							// 6 dark red 

		imagecolorallocate( $my_img, 127,127,0);						// 7 bright red over green
		imagecolorallocate( $my_img, 127,0,127);						// 8 bright red over blue
		imagecolorallocate( $my_img, 127,0,0);							// 6 bright red 


		drawSprite($wavetab,$my_img,$sprite_plane1,$z,$nr_sprites);							// this frame, so frame (no +2)
		drawSprite($wavetab,$my_img,$sprite_plane2,$z,$nr_sprites);

		if($makeColissionTable){
			$allCollision[$z] = createSpritesTable($wavetab,$my_img,$z,$nr_sprites,$clearList);					// collisions is for frame + 2
		}
		$frameCollisions = $allCollision[$z];

		$maxSolution = array();
		$maxSolutionCount = 0;
		$maxTotalSaved = 0;
		$times = 0;
		$execTimeStart = microtime(true);
		while($times < $nrAttempts){
			$solution = getRandomSolution($frameCollisions,$nr_sprites);

			// value solution
			$totalSaved = 0;
			foreach($solution as $value){
				$totalSaved += $frameCollisions[$value]['bS'];
			}
			if($totalSaved > $maxTotalSaved){
				$maxSolution = $solution;
				$maxSolutionCount = count($solution);
				$maxTotalSaved = $totalSaved;		
			}
			if($maxTotalSaved > $prevBest && $maxTotalSaved==$totalSaved){
				echo "f: " . $z . " found new high: " . $maxTotalSaved . " at attempt: " . $times . "\n";	

			}
			$times++;
		}
		$execTimeStop = microtime(true);
		$execTime = $execTimeStop - $execTimeStart;


		$solutionResult = array();
		sort($maxSolution);
		$solutionResult['sol'] = $maxSolution;
		$solutionResult['saved'] = $maxTotalSaved;
		$solutionResult['sprites'] = $maxSolutionCount;

		// save result
		if($maxTotalSaved > $prevBest){		
			echo '!f: ' . $z . ' old: ' . $prevBest . ' new: ' . $maxTotalSaved . " in " . number_format($execTime,3) . " seconds \n";
		}
		else{
			echo '-f: ' . $z . ' current: ' . $prevBest . " in " . number_format($execTime,3)  ." seconds \n";
			$maxSolution = $oldResults['sol'];
			$maxSolutionCount = $oldResults['sprites'];
			$maxTotalSaved = $oldResults['saved'];
		}


		// now we analyse the number of 16 pxl blocks we need to clear
		$clearCount = 0;
		for($y = 0;$y<192; $y++){
			for($x=0; $x<20; $x++){
				if(!isBlockClear($my_img,$x*16,$y))
				{
					$clearCount++;
				}
			}
		}

		$listOfMasks = makeListOfMasks($maxSolution,$wavetab,$z,$nr_sprites);
		$nr_moves = drawSpriteClearOrdered($listOfMasks,$my_img,$clearList,$nr_sprites);			// 1240

		// now we analyse the number of 16 pxl blocks we need to clear
		$clearCount2 = 0;
		for($y = 0;$y<192; $y++){
			for($x=0; $x<20; $x++){
				if(!isBlockClear($my_img,$x*16,$y))
				{
					$clearCount2++;
				}
			}
		}

		// save result
		if($maxTotalSaved > $prevBest){		
			if(($clearCount-$clearCount2) >= $prevBest){
				$solutionResult['clearRemaining'] = $clearCount2;
				$solutionResult['saved'] = $clearCount-$clearCount2;
				$solutionResult['masks'] = $listOfMasks;
 				file_put_contents($fileName,json_encode($solutionResult));
			}
			else{
				echo "MISMATCH: bef: " . $clearCount . "/aft: " . $clearCount2 . "= " . ($clearCount-$clearCount2) . " claimed: " . $maxTotalSaved . "\n";
				// here we should do analysis
			}
		}
		
		$fr = str_pad(($z+1), 3, '0', STR_PAD_LEFT);

		imagestring($my_img , 1 , 1   , 192, "move: " . $nr_moves . "/" . $nr_sprites, $text2);
		imagestring($my_img , 1 , 70 , 192, "before: " . $clearCount, $text);
		imagestring($my_img , 1 , 140 , 192, "after: " . $clearCount2, 3);
		imagestring($my_img , 1 , 203 , 192, "profit: " . ($clearCount-$clearCount2), $text2);
		imagestring($my_img , 1 , 265, 192,  "fm: " . $fr . "/360", 3);

		if($clearCount > $maxtaint){
			$maxtaint = $clearCount;
		}

		if($clearCount2 > $maxtaint2){
			$maxtaint2 = $clearCount2;
			$maxtaint2frame = $z;
		}

		$nr = str_pad($z, 3, '0', STR_PAD_LEFT);
		$filename = 'test' . $nr . '.png';
		imagepng( $my_img, $filename );

		if($endless && $fullPass && $z==359){
			$z=0;
		}
	}

	if($makeColissionTable){
		file_put_contents("framecollisions.json",json_encode($allCollision));
	}

	echo "max taint: " . $maxtaint . "\n";
	echo "max taint2: " . $maxtaint2 . " at frame: " . $maxtaint2frame . "\n";

	// output file


?>