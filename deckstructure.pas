unit DeckStructure;


{$mode ObjFPC}{$H+}
interface
uses
  Classes, SysUtils;

implementation

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
basedeck[1].id:='7P'; //7 de Piques
basedeck[1].atout:=False;
basedeck[1].rang:=9; //0 = Vallet d'atout, 1 = 9 d'atout, 2 = As, 3 = Dix, 4 = Roi, 5 = Dame, 6 = Vallet, 7 = neuf, 8 = huit, 9 = sept
basedeck[1].pos:='basedeck';
//******************
basedeck[2].id:='7C';
basedeck[2].atout:=False;
basedeck[2].rang:=9;
basedeck[2].pos:='basedeck';
//******************
basedeck[3].id:='7T';
basedeck[3].atout:=False;
basedeck[3].rang:=9;
basedeck[3].pos:='basedeck';
//******************
basedeck[4].id:='7K';
basedeck[4].atout:=False;
basedeck[4].rang:=9;
basedeck[4].pos:='basedeck';
//******************
basedeck[5].id:='8P';
basedeck[5].atout:=False;
basedeck[5].rang:=8;
basedeck[5].pos:='basedeck';
//******************
basedeck[6].id:='8C';
basedeck[6].atout:=False;
basedeck[6].rang:=8;
basedeck[6].pos:='basedeck';
//******************
basedeck[7].id:='8T';
basedeck[7].atout:=False;
basedeck[7].rang:=8;
basedeck[7].pos:='basedeck';
//******************
basedeck[8].id:='8K';
basedeck[8].atout:=False;
basedeck[8].rang:=8;
basedeck[8].pos:='basedeck';
//******************
basedeck[9].id:='9P';
basedeck[9].atout:=False;
basedeck[9].rang:=7;
basedeck[9].pos:='basedeck';
//******************
//******************
basedeck[9].id:='9C';
basedeck[9].atout:=False;
basedeck[9].rang:=7;
basedeck[9].pos:='basedeck';
//******************
basedeck[10].id:='9T';
basedeck[10].atout:=False;
basedeck[10].rang:=7;
basedeck[10].pos:='basedeck';
//******************
basedeck[11].id:='9K';
basedeck[11].atout:=False;
basedeck[11].rang:=7;
basedeck[11].pos:='basedeck';
//******************
basedeck[12].id:='XP';   //Le ID de 10 est décrit comme X pour respecter la taille du array
basedeck[12].atout:=False;
basedeck[12].rang:=3;
basedeck[12].pos:='basedeck';
//******************
basedeck[13].id:='XC';
basedeck[13].atout:=False;
basedeck[13].rang:=3;
basedeck[13].pos:='basedeck';
//******************
basedeck[14].id:='XT';
basedeck[14].atout:=False;
basedeck[14].rang:=3;
basedeck[14].pos:='basedeck';
//******************
basedeck[15].id:='XK';
basedeck[15].atout:=False;
basedeck[15].rang:=3;
basedeck[15].pos:='basedeck';
//******************
basedeck[16].id:='VP';
basedeck[16].atout:=False;
basedeck[16].rang:=6;
basedeck[16].pos:='basedeck';
//******************
basedeck[17].id:='VC';
basedeck[17].atout:=False;
basedeck[17].rang:=6;
basedeck[17].pos:='basedeck';
//******************
basedeck[18].id:='VT';
basedeck[18].atout:=False;
basedeck[18].rang:=6;
basedeck[18].pos:='basedeck';
//******************
basedeck[19].id:='VK';
basedeck[19].atout:=False;
basedeck[19].rang:=6;
basedeck[19].pos:='basedeck';
//******************
basedeck[20].id:='DP';
basedeck[20].atout:=False;
basedeck[20].rang:=5;
basedeck[20].pos:='basedeck';
//******************
basedeck[21].id:='DC';
basedeck[21].atout:=False;
basedeck[21].rang:=5;
basedeck[21].pos:='basedeck';
//******************
basedeck[22].id:='DT';
basedeck[22].atout:=False;
basedeck[22].rang:=5;
basedeck[22].pos:='basedeck';
//******************
basedeck[23].id:='DK';
basedeck[23].atout:=False;
basedeck[23].rang:=5;
basedeck[23].pos:='basedeck';
//******************
basedeck[24].id:='RP';
basedeck[24].atout:=False;
basedeck[24].rang:=4;
basedeck[24].pos:='basedeck';
//******************
basedeck[25].id:='RC';
basedeck[25].atout:=False;
basedeck[25].rang:=4;
basedeck[25].pos:='basedeck';
//******************
basedeck[26].id:='RT';
basedeck[26].atout:=False;
basedeck[26].rang:=4;
basedeck[26].pos:='basedeck';
//******************
basedeck[27].id:='RK';
basedeck[27].atout:=False;
basedeck[27].rang:=4;
basedeck[27].pos:='basedeck';
//******************
basedeck[28].id:='AP';
basedeck[28].atout:=False;
basedeck[28].rang:=3;
basedeck[28].pos:='basedeck';
//******************
basedeck[29].id:='AC';
basedeck[29].atout:=False;
basedeck[29].rang:=3;
basedeck[29].pos:='basedeck';
//******************
basedeck[30].id:='AT';
basedeck[30].atout:=False;
basedeck[30].rang:=3;
basedeck[30].pos:='basedeck';
//******************
basedeck[31].id:='AK';
basedeck[31].atout:=False;
basedeck[31].rang:=3;
basedeck[31].pos:='basedeck';
//******************

end.

