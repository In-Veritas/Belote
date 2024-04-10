unit DeckStructure;

{$mode ObjFPC}{$H+}

interface

unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

Type carte = record
                     id : string[2];  //[1] = Nom de la carte(V = Vallet, R = Roi, N = neuf(...)), [2] = Couleur de la carte (Piques: P, Coeurs: C. Trèfles: T, Carreaux: K)
                     atout: boolean;
                     rang : integer;
                     pos: string[10]; //Deck, Joeur(1..4), Centre, Pile(1..2)
                               end;
implementation
procedure Init_Cartes(deck: array[1..32] of carte);
begin
     deck[1].id:='7P'; //7 de Piques
     deck[1].atout:=False;
     deck[1].rang:=9; //0 = Vallet d'atout, 1 = 9 d'atout, 2 = As, 3 = Dix, 4 = Roi, 5 = Dame, 6 = Vallet, 7 = neuf, 8 = huit, 9 = sept
     deck[1].pos:='deck';
     //******************
     deck[2].id:='7C';
     deck[2].atout:=False;
     deck[2].rang:=9;
     deck[2].pos:='deck';
     //******************
     deck[3].id:='7T';
     deck[3].atout:=False;
     deck[3].rang:=9;
     deck[3].pos:='deck';
     //******************
     deck[4].id:='7K';
     deck[4].atout:=False;
     deck[4].rang:=9;
     deck[4].pos:='deck';
     //******************
     deck[5].id:='8P';
     deck[5].atout:=False;
     deck[5].rang:=8;
     deck[5].pos:='deck';
     //******************
     deck[6].id:='8C';
     deck[6].atout:=False;
     deck[6].rang:=8;
     deck[6].pos:='deck';
     //******************
     deck[7].id:='8T';
     deck[7].atout:=False;
     deck[7].rang:=8;
     deck[7].pos:='deck';
     //******************
     deck[8].id:='8K';
     deck[8].atout:=False;
     deck[8].rang:=8;
     deck[8].pos:='deck';
     //******************
     deck[9].id:='9P';
     deck[9].atout:=False;
     deck[9].rang:=7;
     deck[9].pos:='deck';
     //******************
     //******************
     deck[9].id:='9C';
     deck[9].atout:=False;
     deck[9].rang:=7;
     deck[9].pos:='deck';
     //******************
     deck[10].id:='9T';
     deck[10].atout:=False;
     deck[10].rang:=7;
     deck[10].pos:='deck';
     //******************
     deck[11].id:='9K';
     deck[11].atout:=False;
     deck[11].rang:=7;
     deck[11].pos:='deck';
     //******************
     deck[12].id:='XP';   //Le ID de 10 est décrit comme X pour respecter la taille du array
     deck[12].atout:=False;
     deck[12].rang:=3;
     deck[12].pos:='deck';
     //******************
     deck[13].id:='XC';
     deck[13].atout:=False;
     deck[13].rang:=3;
     deck[13].pos:='deck';
     //******************
     deck[14].id:='XT';
     deck[14].atout:=False;
     deck[14].rang:=3;
     deck[14].pos:='deck';
     //******************
     deck[15].id:='XK';
     deck[15].atout:=False;
     deck[15].rang:=3;
     deck[15].pos:='deck';
     //******************
     deck[16].id:='VP';
     deck[16].atout:=False;
     deck[16].rang:=6;
     deck[16].pos:='deck';
     //******************
     deck[17].id:='VC';
     deck[17].atout:=False;
     deck[17].rang:=6;
     deck[17].pos:='deck';
     //******************
     deck[18].id:='VT';
     deck[18].atout:=False;
     deck[18].rang:=6;
     deck[18].pos:='deck';
     //******************
     deck[19].id:='VK';
     deck[19].atout:=False;
     deck[19].rang:=6;
     deck[19].pos:='deck';
     //******************
     deck[20].id:='DP';
     deck[20].atout:=False;
     deck[20].rang:=5;
     deck[20].pos:='deck';
     //******************
     deck[21].id:='DC';
     deck[21].atout:=False;
     deck[21].rang:=5;
     deck[21].pos:='deck';
     //******************
     deck[22].id:='DT';
     deck[22].atout:=False;
     deck[22].rang:=5;
     deck[22].pos:='deck';
     //******************
     deck[23].id:='DK';
     deck[23].atout:=False;
     deck[23].rang:=5;
     deck[23].pos:='deck';
     //******************
     deck[24].id:='RP';
     deck[24].atout:=False;
     deck[24].rang:=4;
     deck[24].pos:='deck';
     //******************
     deck[25].id:='RC';
     deck[25].atout:=False;
     deck[25].rang:=4;
     deck[25].pos:='deck';
     //******************
     deck[26].id:='RT';
     deck[26].atout:=False;
     deck[26].rang:=4;
     deck[26].pos:='deck';
     //******************
     deck[27].id:='RK';
     deck[27].atout:=False;
     deck[27].rang:=4;
     deck[27].pos:='deck';
     //******************
     deck[28].id:='AP';
     deck[28].atout:=False;
     deck[28].rang:=3;
     deck[28].pos:='deck';
     //******************
     deck[29].id:='AC';
     deck[29].atout:=False;
     deck[29].rang:=3;
     deck[29].pos:='deck';
     //******************
     deck[30].id:='AT';
     deck[30].atout:=False;
     deck[30].rang:=3;
     deck[30].pos:='deck';
     //******************
     deck[31].id:='AK';
     deck[31].atout:=False;
     deck[31].rang:=3;
     deck[31].pos:='deck';
     //******************
end;

end.

