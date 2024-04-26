unit DeckStructure;


{$mode ObjFPC}{$H+}
interface
uses
  Classes, SysUtils;

type
  tableau_deck= array [1..32] of typeentier; //Type permettant l'usage des foonctions

implementation



procedure permuter(var X,Y:carte); //procedure qui échange deux tèrmes
VAR
  Z:carte;
begin
  Z:=X;
  X:=Y;
  Y:=Z;
end;


function melangertableau(N:integer;
                         T:tableau_deck):tableau_deck;
VAR
  I,X,Y:integer;

begin

  for I:=1 to N do //dépend du nombre de mélange
    begin
      X:=random(31)+1;
      Y:=random(31)+1;

      permuter(T[X],T[Y]); //le melange permute N fois 2 cartes choisit aléatoirement
    end;

  melangertableau:=T;  //la fonction renvois le tableau mélanger
end;

procedure afficher_carte (var Place:TImage;)
begin

end;

end.

