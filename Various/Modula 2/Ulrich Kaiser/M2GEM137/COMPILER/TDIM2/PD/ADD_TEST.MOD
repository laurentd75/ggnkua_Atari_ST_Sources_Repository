MODULE Test;
(* by RS.*)

(* Dieses kleine Progr�mmle st�rzt den Compiler in den arithmet. �ber-Flu�.*)
(* Hinweis auf einen Bug in GEMX.FSUB/FADD? Oder blo� im Parser? *)
(* Umgehung: r := - (123.0 + 0.123) .*)

VAR   r: REAL;

BEGIN r := - 123.0 - 0.123 END Test.
