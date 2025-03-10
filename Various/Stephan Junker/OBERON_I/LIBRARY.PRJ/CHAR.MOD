MODULE Char; (* SJ 26.11.94 *)

(*
 Module Character implements some procedures on type CHAR.
 *)



PROCEDURE Cap*(c: CHAR) : CHAR;
(*
 Answer the capital letter of c. German "Umlaute" are capitalized
 correctly.
 *)
 BEGIN
  CASE c OF
    "�", "�": RETURN "�"
  | "�", "�": RETURN "�"
  | "�", "�": RETURN "�"
    ELSE RETURN CAP(c);
  END;
 END Cap;


PROCEDURE IsVowel*(c: CHAR) : BOOLEAN;
(*
 Answer TRUE if c is a vowel. German "Umlaute" are recognized as vowels.
 *)
 BEGIN
  c := Cap(c);
  RETURN (c = "A") OR (c = "E") OR (c = "I") OR (c = "O") OR (c = "U")
         OR (c = "�") OR (c = "�") OR (c = "�")
 END IsVowel;


END Char.