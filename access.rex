/* REXX ------------------------------------------------------------- */
/* NAME   : ACCESS                                                    */
/* DATE   : 08/27/2021                                                */
/* CREATED: DANIEL CASTRO                                             */
/* PURPOSE: FINDING OUT WHAT ACCESS AUTHORITY YOU HAVE TO A DATA SET  */
/* PARAMS : NONE                                                      */
/* INPUT  : DATASETNAME                                               */
/* OUTPUT : ACCESS AUTHORITY                                          */
/* CALL BY: USER                                                      */
/* REMARKS: NONE                                                      */
/* ---- ------------------------------------------------------------- */
Say 'TYPE THE DATASET NAME TO CHECK YOUR ACCESS AUTHORITY:'
Pull DNAME                                 /* Read data set name.     */

If DNAME = '' Then                         /* Dataset name empty.     */
   Say 'NO INPUT RECEIVED!! RE-EXECUTE AND TRY AGAIN'
Else Do
   x = OUTTRAP('LINE.')                    /* Trap TSO command output.*/
   "LD DA('" || DNAME || "') G"            /* Get the access authority*/
   y = OUTTRAP('OFF')
   Do i = 1 to LINE.0                      /* Find authority access.  */
      Select
         When Pos('INVALID',LINE.I) > 0 Then Do
           Say 'DATASET NAME IS INVALID!!'
           Leave
         End
         When Pos('NO RACF DESCRIPTION',LINE.I) > 0 Then Do
           Say 'NO INFO FOUND FOR THIS DATASET!!'
           Leave
         End
         When Pos('NOT AUTHORIZED',LINE.I) > 0 Then Do
           Say 'YOU HAVE NO ACCESS TO THIS DATASET.'
           Leave
         End
         When Pos('YOUR ACCESS',LINE.I) > 0 Then Do
            j = i + 2
            access = LINE.J
            Say 'YOU HAVE' Word(access,1) 'ACCESS TO THIS DATASET.'
         End
         Otherwise Say 'UNKNOWN ERROR FOUND!!' LINE.1
      End
   End
End
