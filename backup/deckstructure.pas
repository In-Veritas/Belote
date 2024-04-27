unit DeckStructure;


{$mode ObjFPC}{$H+}
interface
uses
  Classes, SysUtils;
Type carte = record
                  id : string[2];  //[1] = Nom de la carte(V = Vallet, R = Roi, N = neuf(...)), [2] = Couleur de la carte (Piques: P, Coeurs: C. Trèfles: T, Carreaux: K)
                  atout: boolean;
                  rang : integer;
<<<<<<< HEAD
                  pos: string[10]; //deck, Joueur(1..4), Centre, Pile(1..2)
=======
                  pos: string[10]; //deck, Joeur(1..4), Centre, Pile(1..2)
                  id_image: integer;
>>>>>>> 5bfd3d9... waedgvgv frdcsxvx
                            end;
type

  tableau_deck = array [1..32] of carte; //Type permettant l'usage des foonctions
  tableau_mains = array[1..4,1..8] of carte;
<<<<<<< HEAD
  tableau_plie = array[1..32,1..2] of carte;
=======
  tableau_plie = array of carte;
>>>>>>> 5bfd3d9... waedgvgv frdcsxvx
  tableau_centre = array[1..4] of carte;

var
  //Les positions
<<<<<<< HEAD
  deck: tableau_deck;
  main: tableau_mains;
  plie: tableau_plie;
=======
  basedeck: tableau_deck;
  deck: tableau_deck;
  main: tableau_mains;
  plie1: tableau_plie;
  plie2: tableau_plie;
>>>>>>> 5bfd3d9... waedgvgv frdcsxvx
  centre: tableau_centre;
  // Premier joueur/Joueur qui joue en premier
  focus_joueur: integer;
  preneur: integer;

<<<<<<< HEAD
=======





>>>>>>> 5bfd3d9... waedgvgv frdcsxvx

implementation
procedure fin_tour(centre_fintour : tableau_centre; focus_joueur: integer);//Procedure qui est appellé a la fin du tour pour calculer qui a gagné
var i,j: integer;
    atout_trouve: boolean;
    plus_fort: carte;
    demande: char;
    joueur_gagnant: integer;
begin
  atout_trouve:=false;
  //En cas d'atout
  for i:=1 to 4 do
    begin
      if centre_fintour[i].atout=true then
        begin

           atout_trouve:=true;
           joueur_gagnant:=i;

           for j:=i to 4 do
             begin
                   if (centre_fintour[i].atout=true)AND(centre_fintour[i].rang < plus_fort.rang) then
                      joueur_gagnant:=j
             end;
        end
    end;
  //Si il n'y a pas d'atout
  if atout_trouve=false then
    begin
       plus_fort:=centre_fintour[focus_joueur];
       for i:=1 to 4 do
         begin
           if (centre_fintour[i].rang < plus_fort.rang)AND(centre_fintour[i].id[2]=plus_fort.id[2])then
             joueur_gagnant:=i;
         end;
    end;
  //On envoie les cartes à la pile de l'équipe gagnante:
  if joueur_gagnant > 2 then
    begin
       for i:=1 to 4 do
         begin
              Insert(centre_fintour[i], plie2,length(plie2));
         end;
    end else
    begin
         for i:=1 to 4 do
         begin
              Insert(centre_fintour[i], plie1,length(plie1));
         end;
    end;
  focus_joueur:=joueur_gagnant;
  Delete(centre,1,4);
end;

//Vérifie quelles cartes dans la main sont jouables, et donne un array dynamique de booleans pour dire quels sont jouables
procedure cartes_jouables(joueur:integer; var jouables: array of boolean);
begin

end;

{




procedure permuter (var X,Y:carte); //procedure qui échange deux tèrmes
VAR
  Z:carte;
begin
  Z:=X;
  X:=Y;
  Y:=Z;
end;


function melangertableau(N:integer):tableau_deck; //procédure qui mélange un taableau, N sert à selon si la personne mélange beaucoup ou pas
VAR
  T:tableau_deck;
  I,X,Y:integer;

begin
  T:=deck;
  for I:=1 to N do //dépend du nombre de mélange
    begin
      X:=random(31)+1;
      Y:=random(31)+1;

      permuter(T[X],T[Y]); 
    end;

// <<<<<<< HEAD
  melangertableau:=T;  //la fonction renvois le tableau mélanger
end;

procedure afficher_carte (var Place_image:TImage;
                          var Carte:carte);
begin
  //fonction qui affiche l'image à tel place
end;

procedure distribution_4joueurs(Nombredecarte,PremierJoueur:integer;
                                var IndiceCarte,positioncartemain:integer);
VAR
  I,J,X:integer;
  Chaine: string;
begin
  for I:=1 to 4 do
    begin
      if preneur=PremierJoueur then
      begin
        X:=positioncartemain+1;
        for J:=1 to Nombredecarte-1 do
         begin
          main[PremierJoueur,X]:=deck[IndiceCarte];
          Chaine:='Joueur'+inttostr(PremierJoueur);
          deck[IndiceCarte].pos:=Chaine;
          IndiceCarte:=IndiceCarte+1;
          X:=X+1;
         end;
      end
                                else
      begin
        X:=positioncartemain;
        for J:=1 to Nombredecarte do
         begin
          main[PremierJoueur,X]:=deck[IndiceCarte];
          Chaine:='Joueur'+inttostr(PremierJoueur);
          deck[IndiceCarte].pos:=Chaine;
          IndiceCarte:=IndiceCarte+1;
          X:=X+1;
         end;
      end;

      positioncartemain:=positioncartemain+Nombredecarte;
      PremierJoueur:=PremierJoueur+1;
      If (PremierJoueur=5) then
        begin
          PremierJoueur:=1;
        end;

    end;
<<<<<<< HEAD
end;

procedure premiere_distribution (PremierJoueur:integer);

VAR
  IndiceCarte,positioncartemain:integer;
begin
  IndiceCarte:=1;
  positioncartemain:=1;
  distribution_4joueurs(3,PremierJoueur,IndiceCarte,positioncartemain);
  distribution_4joueurs(2,PremierJoueur,IndiceCarte,positioncartemain);
end;

procedure deuxieme_distribution (PremierJoueur:integer);
VAR
  IndiceCarte:integer;
begin
  main[6,preuneur]:=deck[IndiceCarte]
  IndiceCarte:=22;
  distribution_4joueurs(3,PremierJoueur,IndiceCarte);
  distribution_4joueurs(2,PremierJoueur,IndiceCarte);
end;

=======
  melangertableau:=T;  //la fonction renvois le tableau mélanger
end;

procedure afficher_carte (var Place_image:TImage;
                          var Carte:carte);
begin
  //fonction qui affiche l'image à tel place

end
}
>>>>>>> 5bfd3d9... waedgvgv frdcsxvx
begin
basedeck[1].id:='7P'; //7 de Piques
basedeck[1].atout:=False;
basedeck[1].rang:=9; //0 = Vallet d'atout, 1 = 9 d'atout, 2 = As, 3 = Dix, 4 = Roi, 5 = Dame, 6 = Vallet, 7 = neuf, 8 = huit, 9 = sept
basedeck[1].pos:='basedeck';
basedeck[1].id_image:=1;
//******************
basedeck[2].id:='7C';
basedeck[2].atout:=False;
basedeck[2].rang:=9;
basedeck[2].pos:='basedeck';
basedeck[2].id_image:=2;
//******************
basedeck[3].id:='7T';
basedeck[3].atout:=False;
basedeck[3].rang:=9;
basedeck[3].pos:='basedeck';
basedeck[3].id_image:=3;
//******************
basedeck[4].id:='7K';
basedeck[4].atout:=False;
basedeck[4].rang:=9;
basedeck[4].pos:='basedeck';
basedeck[4].id_image:=4;
//******************
basedeck[5].id:='8P';
basedeck[5].atout:=False;
basedeck[5].rang:=8;
basedeck[5].pos:='basedeck';
basedeck[5].id_image:=5;
//******************
basedeck[6].id:='8C';
basedeck[6].atout:=False;
basedeck[6].rang:=8;
basedeck[6].pos:='basedeck';
basedeck[6].id_image:=6;
//******************
basedeck[7].id:='8T';
basedeck[7].atout:=False;
basedeck[7].rang:=8;
basedeck[7].pos:='basedeck';
basedeck[7].id_image:=7;
//******************
basedeck[8].id:='8K';
basedeck[8].atout:=False;
basedeck[8].rang:=8;
basedeck[8].pos:='basedeck';
basedeck[8].id_image:=8;
//******************
basedeck[9].id:='9P';
basedeck[9].atout:=False;
basedeck[9].rang:=7;
basedeck[9].pos:='basedeck';
basedeck[9].id_image:=9;
//******************
//******************
//******************
basedeck[10].id:='9T';
basedeck[10].atout:=False;
basedeck[10].rang:=7;
basedeck[10].pos:='basedeck';
basedeck[10].id_image:=10;
//******************
basedeck[11].id:='9K';
basedeck[11].atout:=False;
basedeck[11].rang:=7;
basedeck[11].pos:='basedeck';
basedeck[11].id_image:=11;
//******************
basedeck[12].id:='XP';   //Le ID de 10 est décrit comme X pour respecter la taille du array
basedeck[12].atout:=False;
basedeck[12].rang:=3;
basedeck[12].pos:='basedeck';
basedeck[12].id_image:=12;
//******************
basedeck[13].id:='XC';
basedeck[13].atout:=False;
basedeck[13].rang:=3;
basedeck[13].pos:='basedeck';
basedeck[13].id_image:=13;
//******************
basedeck[14].id:='XT';
basedeck[14].atout:=False;
basedeck[14].rang:=3;
basedeck[14].pos:='basedeck';
basedeck[14].id_image:=14;
//******************
basedeck[15].id:='XK';
basedeck[15].atout:=False;
basedeck[15].rang:=3;
basedeck[15].pos:='basedeck';
basedeck[15].id_image:=15;
//******************
basedeck[16].id:='VP';
basedeck[16].atout:=False;
basedeck[16].rang:=6;
basedeck[16].pos:='basedeck';
basedeck[16].id_image:=16;
//******************
basedeck[17].id:='VC';
basedeck[17].atout:=False;
basedeck[17].rang:=6;
basedeck[17].pos:='basedeck';
basedeck[17].id_image:=17;
//******************
basedeck[18].id:='VT';
basedeck[18].atout:=False;
basedeck[18].rang:=6;
basedeck[18].pos:='basedeck';
basedeck[18].id_image:=18;
//******************
basedeck[19].id:='VK';
basedeck[19].atout:=False;
basedeck[19].rang:=6;
basedeck[19].pos:='basedeck';
basedeck[19].id_image:=19;
//******************
basedeck[20].id:='DP';
basedeck[20].atout:=False;
basedeck[20].rang:=5;
basedeck[20].pos:='basedeck';
basedeck[20].id_image:=20;
//******************
basedeck[21].id:='DC';
basedeck[21].atout:=False;
basedeck[21].rang:=5;
basedeck[21].pos:='basedeck';
basedeck[21].id_image:=21;
//******************
basedeck[22].id:='DT';
basedeck[22].atout:=False;
basedeck[22].rang:=5;
basedeck[22].pos:='basedeck';
basedeck[22].id_image:=22;
//******************
basedeck[23].id:='DK';
basedeck[23].atout:=False;
basedeck[23].rang:=5;
basedeck[23].pos:='basedeck';
basedeck[23].id_image:=23;
//******************
basedeck[24].id:='RP';
basedeck[24].atout:=False;
basedeck[24].rang:=4;
basedeck[24].pos:='basedeck';
basedeck[24].id_image:=24;
//******************
basedeck[25].id:='RC';
basedeck[25].atout:=False;
basedeck[25].rang:=4;
basedeck[25].pos:='basedeck';
basedeck[25].id_image:=25;
//******************
basedeck[26].id:='RT';
basedeck[26].atout:=False;
basedeck[26].rang:=4;
basedeck[26].pos:='basedeck';
basedeck[26].id_image:=26;
//******************
basedeck[27].id:='RK';
basedeck[27].atout:=False;
basedeck[27].rang:=4;
basedeck[27].pos:='basedeck';
basedeck[27].id_image:=27;
//******************
basedeck[28].id:='AP';
basedeck[28].atout:=False;
basedeck[28].rang:=3;
basedeck[28].pos:='basedeck';
basedeck[28].id_image:=28;
//******************
basedeck[29].id:='AC';
basedeck[29].atout:=False;
basedeck[29].rang:=3;
basedeck[29].pos:='basedeck';
basedeck[29].id_image:=29;
//******************
basedeck[30].id:='AT';
basedeck[30].atout:=False;
basedeck[30].rang:=3;
basedeck[30].pos:='basedeck';
basedeck[30].id_image:=30;
//******************
basedeck[31].id:='AK';
basedeck[31].atout:=False;
basedeck[31].rang:=3;
basedeck[31].pos:='basedeck';
basedeck[31].id_image:=31;
//******************
<<<<<<< HEAD
=======
basedeck[32].id:='9C';
basedeck[32].atout:=False;
basedeck[32].rang:=7;
basedeck[32].pos:='basedeck';
basedeck[32].id_image:=32;
>>>>>>> 5bfd3d9... waedgvgv frdcsxvx

end.

