PMF$  #��"example.h" #��<gemlib.h>  �
main() { �OBJECT*�adr_dial;; ���object_no;; ���finished;; 	�	 load resource file  	�$(!�(�example.rsc)) 	{ � check if error  �/(�Fatal error...\n);; ��(�_);; 	}  	�	 Address of form called DIAL  	�adr_dial��A(�
DIAL);;  	�	 draw the dialog box  	�X(�adr_dial);; 	��(�
M_ON,�_);;  	�restart: 	�finished��_;;  	�	  clear the editable text field  	��(�C(�adr_dial,�
TEXT),�);; 	�8 	{ � give the user control  �object_no���(�adr_dial,�
TEXT);;  �, de-select the button that caused the exit  �`(�adr_dial,�object_no);; �_(�adr_dial,�object_no);;  � act depending on exit button  �)(�object_no) { �=�DRIVEA: � put A:\*.* in the text field  ��(�C(�adr_dial,�
TEXT),�A:\\*.*);; � display the new text  �_(�adr_dial,�
TEXT);;  �V;; �=�DRIVEB: ��(�C(�adr_dial,�
TEXT),�B:\\*.*);; �_(�adr_dial,�
TEXT);; �V;; �=�OK: �finished��W;; �V;; �=�CANCEL: �finished��W;; �V;; } 	} 	��(!�finished);;  	�	+ if you click on OK, ask for confirmation  	�$(�finished��W) �$(�Q(�ALERT)��W) ��restart;;  	�	' remove the form & restore the screen  	�R();;  	��(�M_OFF,�_);;  	�	 display the result  	��(�Folder selected : %s\n,�C(�adr_dial,�
TEXT));; 	�$(�d(�adr_dial,�CHOICE1)) ��(�Choice 1 and );; 	�~ ��(�Choice 2 and );; 	�$(�d(�adr_dial,�CHOICE3)) ��(�	Choice 3);; 	�~ ��(�	Choice 4);; 	��(� have been selected\n);;  	�	( Free memory used by the resource file  	�();; } 