unit DeckStructure;


{$mode ObjFPC}{$H+}
interface
uses
  Classes, SysUtils;

type
  typeentier=integer; //Type afin de facilité l'usage de la procedure permuter
  typetableau= array [1..32] of integer; //Type permettant l'usage des foonctions 

implementation


begin

procedure permuter (var X,Y:typeentier); //procedure qui échange deux tèrmes
VAR
  Z:typeentier;
begin
  Z:=X;
  X:=Y;
  Y:=Z;
end;


function creertableau():typetableau; //procédure qui crée un tableau trier
VAR
  T:typetableau;
  I:integer;

begin
  for I:=1 to 32 do
    begin
      T[I]:=I;
    end;

  creertableau:=T;
end;

function melangertableau(N:integer):typetableau; //procédure qui mélange un taableau, N sert à selon si la personne mélange beaucoup ou pas
VAR
  T:typetableau;
  I,X,Y:integer;

begin
  T:=creertableau(); //on commence par initier le tableau, peut être le faire qu'au début et après on le reremplit avec les plies fait, ça fera plus "vivant"

  for I:=1 to N do //dépend du nombre de mélange
    begin
      X:=random(31)+1;
      Y:=random(31)+1;

      permuter(T[X],T[Y]); 
    end;

  melangertableau:=T;
end;

end.

