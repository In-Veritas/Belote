unit DeckStructure;


{$mode ObjFPC}{$H+}
interface




uses
  Classes, SysUtils,Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Unit3;
Type carte = record
                  id : string[2];  //[1] = Nom de la carte(V = Vallet, R = Roi, N = neuf(...)), [2] = Couleur de la carte (Piques: P, Coeurs: C. Trèfles: T, Carreaux: K)
                  atout: boolean;
                  rang : integer;
                  jouable: boolean;
                  pos: string[10]; //deck, Joueur(1..4), Centre, Pile(1..2)
                  id_image: integer;
                            end;
type

  tableau_deck = array [1..32] of carte; //Type permettant l'usage des foonctions
  tableau_mains = array of array of carte; //tableau multidimensionnel des mains de chaque joeur
  tableau_plie = array of carte;
  tableau_centre = array of carte;

var
  //Les positions
  basedeck: tableau_deck;
  deck: tableau_deck;
  main: tableau_mains;
  plie1: tableau_plie;
  plie2: tableau_plie;
  centre: tableau_centre;

  // Premier joueur/Joueur qui joue en premier
  focus_joueur: integer;
  preneur: integer;
  atout:string; //l'atout choisi
  score1: integer;
  score2: integer;
  etat:string;
  cartes_joues:integer;
  manche:integer;
  playcap:integer;
  joueurquiabelote:integer;



procedure evaluation_point_main (joueur:integer;
                                var P,C,T,K:boolean;
                                var max:string);
procedure prendre_IA (joueur,numeroduchoix:integer;
                     var pris:boolean);
procedure init_jeu;
procedure permuter (var X,Y:carte);
function premierchoixcouleur (toutcouleur:string):integer;
function changementcouleur (x:integer):integer;
procedure modificationmain (Joueur,Indice_carte_jouer:integer);
procedure distribution_4joueurs(Nombredecarte,PremierJoueur:integer;
                                var IndiceCarte:integer);
procedure miseajouratout ();
procedure cartes_jouables(joueur:integer);
procedure triecouleur (I,Maximum:integer;
                      couleur:string;
                      var C:integer);
procedure trieminmaxparcouleur (I,min,max:integer);
function melangertableau(N:integer):tableau_deck;
procedure debut_manche(joueur: integer);
procedure trieparcouleur (Maximum:integer);
procedure trierang(Maximum:integer);
procedure debut_jeu;
procedure premiere_distribution (PremierJoueur:integer);
procedure deuxieme_distribution (PremierJoueur:integer);
procedure choix_atout;
procedure fin_tour(centre_fintour : tableau_centre);
procedure fin_jeu(joueur_preneur:integer; dix_de_dern, belote:boolean);


{**FAIT etat choix d'aout

verifie focus joueur
variable pris: boolean
cartes de main visibles mais pas clickables
boucle 1-4
  joeurquiprend va etre focusjoueur
  if elif pour chaque cas de joueur
  si joueurquiprend depasse 4 il CHUTE a 1
  si pris break
si not pris
   boucle 1-4
         changer les possibilitês de choix
         joeurquiprend va etre focusjoueur
        if elif pour chaque cas de joueur}

{**FAIT etat debut

        verifie focus joueur
        faire boucle 1-8
        	boucle 1-4
        		joeurquijoue va etre focusjoueur
        		if elif pour chaque cas de joueur
        		si joueurquijoue depasse 4 il CHUTE a 1
        	il appelle fintour
                rajouter 10 de dern
        change letat du jeu pour fin    }
{etat fin
Ouvre le form3 et compte le plie de lequipe qui a pris
      obs. belote, points de l²aout
      on verifie les cas >81 <81 =162
      on affiche qui a gagne
      on demande au joueur humain si il veut continuer
      si oui
         On reinitialize tout (c chian)
      sinon
      APPLICATION TERMINATE!!!!!!!!!!!!!!!!!!!

}

implementation

USES Unit2, unit4, unit5, unit6;

procedure evaluation_point_main (joueur:integer;
                                var P,C,T,K:boolean;
                                var max:string);
VAR
  CompteurP,CompteurC,CompteurT,CompteurK,maximum,J:integer;

begin
  CompteurP:=0;
  CompteurC:=0;
  CompteurT:=0;
  CompteurK:=0;

  for J:=0 to 4 do
    begin
      if main[joueur,J].id[1]='V' then  //si vallet poids très important
       begin

         if main[joueur,J].id[2]='C' then CompteurC:=CompteurC+10;

         if main[joueur,J].id[2]='P' then CompteurP:=CompteurP+10;

         if main[joueur,J].id[2]='T' then CompteurT:=CompteurT+10;

         if main[joueur,J].id[2]='K' then CompteurK:=CompteurK+10;

       end;

      if main[joueur,J].id[1]='9' then  //si 9 poids important
       begin

        if main[joueur,J].id[2]='C' then CompteurC:=CompteurC+8;

        if main[joueur,J].id[2]='P' then CompteurP:=CompteurP+8;

        if main[joueur,J].id[2]='T' then CompteurT:=CompteurT+8;

        if main[joueur,J].id[2]='K' then CompteurK:=CompteurK+8;

       end;

      if main[joueur,J].id[1]='A' then   //si AS point important
       begin

        if main[joueur,J].id[2]='C' then CompteurC:=CompteurC+6;

        if main[joueur,J].id[2]='P' then CompteurP:=CompteurP+6;

        if main[joueur,J].id[2]='T' then CompteurT:=CompteurT+6;

        if main[joueur,J].id[2]='K' then CompteurK:=CompteurK+6;

       end;

      if main[joueur,J].id[1]='X' then  //si 10 point important
       begin

        if main[joueur,J].id[2]='C' then CompteurC:=CompteurC+5;

        if main[joueur,J].id[2]='P' then CompteurP:=CompteurP+5;

        if main[joueur,J].id[2]='T' then CompteurT:=CompteurT+5;

        if main[joueur,J].id[2]='K' then CompteurK:=CompteurK+5;

       end;

    end;

  //prise en compte de la carte du centre
  if deck[21].id[1]='V' then  //si vallet poids très important
       begin

         if deck[21].id[2]='C' then CompteurC:=CompteurC+10;

         if deck[21].id[2]='P' then CompteurP:=CompteurP+10;

         if deck[21].id[2]='T' then CompteurT:=CompteurT+10;

         if deck[21].id[2]='K' then CompteurK:=CompteurK+10;

       end;

      if deck[21].id[1]='9' then  //si 9 poids important
       begin

        if deck[21].id[2]='C' then CompteurC:=CompteurC+8;

        if deck[21].id[2]='P' then CompteurP:=CompteurP+8;

        if deck[21].id[2]='T' then CompteurT:=CompteurT+8;

        if deck[21].id[2]='K' then CompteurK:=CompteurK+8;

       end;

      if deck[21].id[1]='A' then   //si AS point important
       begin

        if deck[21].id[2]='C' then CompteurC:=CompteurC+6;

        if deck[21].id[2]='P' then CompteurP:=CompteurP+6;

        if deck[21].id[2]='T' then CompteurT:=CompteurT+6;

        if deck[21].id[2]='K' then CompteurK:=CompteurK+6;

       end;

      if deck[21].id[1]='X' then  //si 10 point important
       begin

        if deck[21].id[2]='C' then CompteurC:=CompteurC+5;

        if deck[21].id[2]='P' then CompteurP:=CompteurP+5;

        if deck[21].id[2]='T' then CompteurT:=CompteurT+5;

        if deck[21].id[2]='K' then CompteurK:=CompteurK+5;

       end;

  //si il a un point supérieur à 15 il veut prendre!!
  if CompteurK>15 then K:=true;

  if CompteurC>15 then C:=true;

  if CompteurT>15 then T:=true;

  if CompteurP>15 then P:=true;

  //prendre le meilleur score pour le 2ème choix d'atout
  maximum:=CompteurP;
  if P=true then
    begin
      max:='P'
    end;

  if maximum < CompteurK then
    begin
      maximum:=CompteurK;
      if K=true then
        begin
          max:='K';
        end;
    end;
  if maximum < CompteurT then
    begin
      maximum:=CompteurT;
      if T=true then
        begin
          max:='T';
        end;
    end;

  if maximum < CompteurC then
    begin
      maximum:=CompteurC;
      if C=true then
        begin
          max:='C';
        end;
    end;

end;

procedure prendre_IA (joueur,numeroduchoix:integer;
                     var pris:boolean);
VAR
  P,C,T,K:boolean;
  max,couleur:string;
begin
  //selon internet, faut compter le nb de point qu'on a, c'est cool donc!
  P:=false;
  C:=false;
  T:=false;
  K:=false;
  max:='';
  couleur:=deck[21].id[2];
  evaluation_point_main(joueur,P,C,T,K,max);

  if numeroduchoix=1 then
    begin
      if (couleur='C') and (C=true) and (max='C') then
        begin
          pris:=true;
          atout:='C';
        end;
      if (couleur='K') and (K=true) and (max='K') then
        begin
          pris:=true;
          atout:='K';
        end;
      if (couleur='P') and (P=true) and (max='P') then
        begin
          pris:=true;
          atout:='P';
        end;
      if (couleur='T') and (T=true) and (max='T') then
        begin
          pris:=true;
          atout:='T';
        end;
    end;

  if numeroduchoix=2 then
    begin
      if max<>'' then
        begin
          pris:=true;
          atout:=max;
        end;
    end;
end;

procedure init_jeu;
var
  i: integer;
begin
for i:=1 to 32 do
 begin
  basedeck[i].jouable:=False;
 end;

cartes_joues:=0;
manche:=1;
atout:='0';

//******************
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
basedeck[32].id:='9C';
basedeck[32].atout:=False;
basedeck[32].rang:=7;
basedeck[32].pos:='basedeck';
basedeck[32].id_image:=10;
//******************
basedeck[10].id:='9T';
basedeck[10].atout:=False;
basedeck[10].rang:=7;
basedeck[10].pos:='basedeck';
basedeck[10].id_image:=11;
//******************
basedeck[11].id:='9K';
basedeck[11].atout:=False;
basedeck[11].rang:=7;
basedeck[11].pos:='basedeck';
basedeck[11].id_image:=12;
//******************
basedeck[12].id:='XP';   //Le ID de 10 est décrit comme X pour respecter la taille du array
basedeck[12].atout:=False;
basedeck[12].rang:=3;
basedeck[12].pos:='basedeck';
basedeck[12].id_image:=13;
//******************
basedeck[13].id:='XC';
basedeck[13].atout:=False;
basedeck[13].rang:=3;
basedeck[13].pos:='basedeck';
basedeck[13].id_image:=14;
//******************
basedeck[14].id:='XT';
basedeck[14].atout:=False;
basedeck[14].rang:=3;
basedeck[14].pos:='basedeck';
basedeck[14].id_image:=15;
//******************
basedeck[15].id:='XK';
basedeck[15].atout:=False;
basedeck[15].rang:=3;
basedeck[15].pos:='basedeck';
basedeck[15].id_image:=16;
//******************
basedeck[16].id:='VP';
basedeck[16].atout:=False;
basedeck[16].rang:=6;
basedeck[16].pos:='basedeck';
basedeck[16].id_image:=17;
//******************
basedeck[17].id:='VC';
basedeck[17].atout:=False;
basedeck[17].rang:=6;
basedeck[17].pos:='basedeck';
basedeck[17].id_image:=18;
//******************
basedeck[18].id:='VT';
basedeck[18].atout:=False;
basedeck[18].rang:=6;
basedeck[18].pos:='basedeck';
basedeck[18].id_image:=19;
//******************
basedeck[19].id:='VK';
basedeck[19].atout:=False;
basedeck[19].rang:=6;
basedeck[19].pos:='basedeck';
basedeck[19].id_image:=20;
//******************
basedeck[20].id:='DP';
basedeck[20].atout:=False;
basedeck[20].rang:=5;
basedeck[20].pos:='basedeck';
basedeck[20].id_image:=21;
//******************
basedeck[21].id:='DC';
basedeck[21].atout:=False;
basedeck[21].rang:=5;
basedeck[21].pos:='basedeck';
basedeck[21].id_image:=22;
//******************
basedeck[22].id:='DT';
basedeck[22].atout:=False;
basedeck[22].rang:=5;
basedeck[22].pos:='basedeck';
basedeck[22].id_image:=23;
//******************
basedeck[23].id:='DK';
basedeck[23].atout:=False;
basedeck[23].rang:=5;
basedeck[23].pos:='basedeck';
basedeck[23].id_image:=24;
//******************
basedeck[24].id:='RP';
basedeck[24].atout:=False;
basedeck[24].rang:=4;
basedeck[24].pos:='basedeck';
basedeck[24].id_image:=25;
//******************
basedeck[25].id:='RC';
basedeck[25].atout:=False;
basedeck[25].rang:=4;
basedeck[25].pos:='basedeck';
basedeck[25].id_image:=26;
//******************
basedeck[26].id:='RT';
basedeck[26].atout:=False;
basedeck[26].rang:=4;
basedeck[26].pos:='basedeck';
basedeck[26].id_image:=27;
//******************
basedeck[27].id:='RK';
basedeck[27].atout:=False;
basedeck[27].rang:=4;
basedeck[27].pos:='basedeck';
basedeck[27].id_image:=28;
//******************
basedeck[28].id:='AP';
basedeck[28].atout:=False;
basedeck[28].rang:=2;
basedeck[28].pos:='basedeck';
basedeck[28].id_image:=29;
//******************
basedeck[29].id:='AC';
basedeck[29].atout:=False;
basedeck[29].rang:=2;
basedeck[29].pos:='basedeck';
basedeck[29].id_image:=30;
//******************
basedeck[30].id:='AT';
basedeck[30].atout:=False;
basedeck[30].rang:=2;
basedeck[30].pos:='basedeck';
basedeck[30].id_image:=31;
//******************
basedeck[31].id:='AK';
basedeck[31].atout:=False;
basedeck[31].rang:=2;
basedeck[31].pos:='basedeck';
basedeck[31].id_image:=32;
//******************

end;

procedure permuter (var X,Y:carte); //procedure qui échange deux tèrmes
VAR
  Z:carte;
begin
  Z:=X;
  X:=Y;
  Y:=Z;
end;

function premierchoixcouleur (toutcouleur:string):integer;
begin
  if atout='0' then
    begin
      premierchoixcouleur:=1;
    end
               else
    begin
      premierchoixcouleur:=Pos(atout,toutcouleur);
    end;
end;

function changementcouleur (x:integer):integer;
begin
  x:=x+1;
  if x>4 then
    begin
      x:=1;
    end;
  changementcouleur:=x;
end;

procedure modificationmain (Joueur,Indice_carte_jouer:integer);
VAR
  tableau_carte:array of carte;
  I,C,nombre_de_carte:integer;
  chaine:string;

begin
  C:=0;
  chaine:=inttostr(Joueur);

  for I:=0 to High(main[Joueur]) do
   begin
     chaine:=chaine+' '+main[Joueur,i].id
   end;

  showmessage(chaine);

  nombre_de_carte:=length(main[joueur])-1;
  for I:=Indice_carte_jouer+1 to High(main[Joueur]) do
    begin
      C:=C+1;
    end;
  SetLength(tableau_carte,C);
  C:=0;
  for I:=Indice_carte_jouer+1 to High(main[Joueur]) do
    begin
      tableau_carte[C]:=main[Joueur,I];
      C:=C+1;
    end;

  insert(tableau_carte,main[Joueur],Indice_carte_jouer-1);

  SetLength(main[Joueur],nombre_de_carte);

  chaine:=inttostr(Joueur);

  for I:=0 to High(main[Joueur]) do
   begin
     chaine:=chaine+' '+main[Joueur,i].id
   end;

  showmessage(chaine);

end;

procedure distribution_4joueurs(Nombredecarte,PremierJoueur:integer;
                                var IndiceCarte:integer);
//Nombredecarte => le nombre de carte à distribuer
//PremierJoueur => le premier joueur à recevoir les cartes (de 1 à 4)
//IndiceCarte => à quelle carte on en est dans la "pioche"


VAR
  I,J:integer;
  Chaine: string;
  distribue: array of carte;
begin
  for I:=1 to 4 do //distribue aux 4 joueurs
    begin
      setlength(distribue,nombredecarte); //on donne les dimensions du tableau alternatif
      If preneur<>PremierJoueur then  //si ce joueur n'est pas preneur
        begin
          for J:=1 to Nombredecarte do     //on distribue les carte normalement
            begin
              distribue[J-1]:= deck[IndiceCarte];  //J-1 car distibue commance à l'indice 0
              Chaine:='Joueur'+inttostr(PremierJoueur);
              deck[IndiceCarte].pos:=Chaine;            //on change l'état
              distribue[J-1].pos:=Chaine;
              IndiceCarte:=IndiceCarte+1;  //on augmente l'indice de la carte
            end;
        end
                               else   //SINON
        begin
          distribue[0]:=deck[21];    //la première carte qu'on lui donne c'est la 21ème toujours
          for J:=2 to Nombredecarte do         //on lui donne une carte de moins et on suit lamême logique
            begin
              distribue[J-1]:= deck[IndiceCarte];
              Chaine:='Joueur'+inttostr(PremierJoueur);
              deck[IndiceCarte].pos:=Chaine;
              distribue[J-1].pos:=Chaine;
              IndiceCarte:=IndiceCarte+1;
            end;
        end;
      insert(distribue,main[PremierJoueur],0);   //on 'insert' les carte distribuer dans la mains du joueur

      PremierJoueur:=PremierJoueur+1; //On change de joueur

      If (PremierJoueur>4) then    //on vérifie qu'il dépasse pas 4
        begin
          PremierJoueur:=1;
        end;

    end;

end;

procedure miseajouratout ();
VAR
  I,J:integer;
  couleurcarte:string;
begin
  for I:=1 to 4 do
    begin
      for J:=1 to 8 do
        begin
          couleurcarte:=copy(main[I,J].pos,2,1);
          if couleurcarte=atout then
            begin
              main[I,J].atout:=true;
            end;
        end;
    end;

end;

procedure cartes_jouables(joueur:integer); //Vérifie quelles cartes dans la main sont jouables, et donne un array dynamique de booleans pour dire quels sont jouables
var
i,j: integer;
plus_fort: carte;
jouable_trouve:boolean;
anoncebelote:string;

begin
jouable_trouve:= false;
if playcap=4 then exit;
if cartes_joues = 0 then
  begin
    for i:=0 to High(main[joueur])-1 do
      begin
        main[joueur,i].jouable:= True;
      end;

  end else
  begin
    if centre[focus_joueur].atout=True then
      begin
         plus_fort:=centre[focus_joueur];

         for i:=1 to 4 do
           begin
             if (centre[i].rang < plus_fort.rang)AND(centre[i].atout = True) then
               begin
                 plus_fort:=centre[i];
               end;
           end;


         for i:=0 to High(main[joueur])do
         begin
           if (plus_fort.rang < main[joueur,i].rang) AND (main[joueur,i].atout) then
           begin
           main[joueur,i].jouable:=True;
           jouable_trouve:= True;
           end;
         end;
         if not(jouable_trouve) then
         begin
            for i:=0 to High(main[joueur])do
            begin
              if main[joueur,i].atout then
              begin
                jouable_trouve:= True;
                main[joueur,i].jouable:=true;
              end;
            end;
         end;
         if not(jouable_trouve) then
         begin
             for i:=0 to High(main[joueur]) do
              begin
                main[joueur,i].jouable:= True;
                jouable_trouve:= True;
              end;
         end;
      end else
    begin
      for i:=0 to High(main[joueur]) do
      begin
        if main[joueur,i].id[2] = centre[focus_joueur].id[2] then
          begin
            main[joueur,i].jouable:= True;
            jouable_trouve:= True;
          end;
      end;
      if not(jouable_trouve) then
        begin
          for i:=0 to High(main[joueur])do
          begin
            if main[joueur,i].atout then
            begin
              for j:=1 to length(centre) do
              begin
                if centre[j].atout then plus_fort:=centre[j];
                break;
              end;
              for j:=1 to length(centre) do
              begin
                if (centre[j].atout)AND(centre[j].rang < plus_fort.rang) then plus_fort:=centre[j];
              end;
              for j:=0 to High(main[joueur]) do
              begin
                if main[joueur,j].rang < plus_fort.rang then
                begin
                  main[joueur,j].jouable:=True;
                  jouable_trouve:=True;
                end;
              end;
              if not(jouable_trouve)then
              begin
              for j:=0 to High(main[joueur]) do
                  begin
                    if main[joueur,j].atout then
                    begin
                         main[joueur,j].jouable:=True;
                         jouable_trouve:=True;
                    end;
                    end;
              end;
              break;
              end;
            end;
          end;
        if not(jouable_trouve) then
         begin
             for i:=0 to High(main[joueur]) do
              begin
                main[joueur,i].jouable:= True;
                jouable_trouve:= True
              end;
         end;
        end;


    end;


    if joueur<>1 then
     begin
       //ici mettre procédure qui choisi la meilleur carte à jouer pour J artificiel
       for i:=0 to High(main[joueur]) do
       begin
         if main[joueur,i].jouable      then
         begin
          Form2.jouercarte(main[joueur,i],joueur);

          if (joueur=joueurquiabelote) and (main[joueur,i].atout=true) and ( (main[joueur,i].id[1]='R') OR (main[joueur,i].id[1]='D') ) then
            begin
              anoncebelote:='Belote du joueur '+inttostr(i);
              showmessage(anoncebelote);
            end;

          modificationmain (joueur,i); //procédure qui enlève la carte jouer du joueur
          break;
         end;
       end;
     end;
    end;

procedure triecouleur (I,Maximum:integer;
                      couleur:string;
                      var C:integer);
VAR
  couleurcarte:string;
  J,Min:integer;

begin
  Min:=C;
  for J:=Min to Maximum do
    begin
      couleurcarte:=main[I,J].id[2];
      if couleurcarte=couleur then
        begin
          permuter (main[I,J],main[I,C]);
          C:=C+1;
        end;
    end;
end;

procedure trieminmaxparcouleur (I,min,max:integer);
VAR
  J1,J2:integer;

begin
  For J1:=min to max-1 do
    begin
      for J2:=J1+1 to max do
        begin
          if (main[I,J1].rang>main[I,J2].rang) then
            begin
              permuter(main[I,J1],main[I,J2]);
            end;
        end;
    end;
end;

function melangertableau(N:integer):tableau_deck; //fonction qui mélange un tableau, N sert au nombre de mélange
VAR
  T:tableau_deck;
  I,X,Y:integer;

begin
  randomize;
  T:=deck;
  for I:=1 to N do //dépend du nombre de mélange
    begin
      X:=random(31)+1;
      Y:=random(31)+1;

      permuter(T[X],T[Y]);
    end;

  melangertableau:=T;  //la fonction renvois le tableau mélanger  (a un moment deck:=melangertableau(nombre de mélange);)
end;

procedure debut_manche(joueur: integer);
var I:integer;
begin
  for I:=1 to 4 do
    begin
       if joueur=1 then
       begin
         cartes_jouables(joueur);
       end         else
       begin
         cartes_jouables(joueur);
         //jouer_carte_ia();
       end;

       joueur:=joueur+1;
       if joueur=5 then joueur := 1;

    end;
end;

procedure trieparcouleur(Maximum:integer);
VAR
  toutcouleur:string;
  a,I,C,x:integer;
  couleur:string;

begin
  toutcouleur:='PCTK';
  for I:=1 to 4 do //pour faire sur les quatres joueur
    begin
      C:=0;
      x:=premierchoixcouleur(toutcouleur);
      couleur:=copy(toutcouleur,x,1);
      for a:=1 to 4 do
        begin
          triecouleur(I,Maximum,couleur,C);
          x:=changementcouleur(x);
          couleur:=copy(toutcouleur,x,1);
        end;
    end;
end;

procedure trierang(Maximum:integer);
VAR
  I,min,max:integer;
  couleur1,couleur2:string;

begin
  for I:=1 to 4 do
    begin
      min:=0;
      max:=0;
      while min<Maximum do
        begin
          couleur1:=copy(main[I,min].id,2,1);
          couleur2:=copy(main[I,max].id,2,1);
          while (couleur1=couleur2) and (max<Maximum) do
            begin
              max:=max+1;
              couleur2:=copy(main[I,max].id,2,1);
            end;
          if (couleur1<>couleur2) then
            begin
              max:=max-1;
            end;

          if min<>max then
            begin
              trieminmaxparcouleur(I,min,max);
            end;

          min:=max+1;
          max:=min;
        end;
    end;
end;

procedure debut_jeu;

var
i: integer;
begin
    form2.label3.caption:='Manche: ' + inttostr(manche);
    cartes_jouables(focus_joueur);

    Form2.image2.Enabled:=True;
    Form2.image3.Enabled:=True;
    Form2.image4.Enabled:=True;
    Form2.image5.Enabled:=True;
    Form2.image6.Enabled:=True;
    Form2.image7.Enabled:=True;
    Form2.image8.Enabled:=True;
    Form2.image9.Enabled:=True;
end;

procedure premiere_distribution (PremierJoueur:integer);//en variable globale peut être, si ou on a besoin de rien pour cette procedure

VAR
  IndiceCarte:integer;
begin
  etat:='choix';
  joueurquiabelote:=0;
  SetLength(main, 5, 0);  //j'alloue le tableau main
  preneur:=0;
  atout:='0';
  IndiceCarte:=1;
  deck:=melangertableau(3000);

  distribution_4joueurs(3,PremierJoueur,IndiceCarte);
  distribution_4joueurs(2,PremierJoueur,IndiceCarte);
  //faut faire les 2 distribution avant parce que vu qu'on utilise la fct insert ça pousse les image
  //et donc après c'est plus les bon indices

  trieparcouleur(4);  //5carte-1 car on commence à 0
  trierang(4);

  Form2.ImageList1.GetBitmap(main[1,0].id_image,Form2.Image2.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,1].id_image,Form2.Image3.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,2].id_image,Form2.Image4.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,3].id_image,Form2.Image5.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,4].id_image,Form2.Image6.Picture.Bitmap);
  Form2.Timer1.Enabled:=True;

  {trieparcouleur();//trie des cartes de chaques joueurs
  trierang();    }


  Form2.Image18.Visible:=True;
  Form2.ImageList1.GetBitmap(deck[21].id_image,Form2.Image18.Picture.Bitmap);
  Form2.Enabled:=True;

end;

procedure deuxieme_distribution (PremierJoueur:integer);//en variable globale peut être, si ou on a besoin de rien pour cette procedure
VAR
  IndiceCarte,i,j,belote:integer;
begin

  IndiceCarte:=22;
  distribution_4joueurs(3,PremierJoueur,IndiceCarte);

  {miseajouratout();
  trierang(); }

  //affiche les cartes du joueurs 1
  trieparcouleur(7);
  trierang(7);

  Form2.ImageList1.GetBitmap(main[1,0].id_image,Form2.Image2.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,1].id_image,Form2.Image3.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,2].id_image,Form2.Image4.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,3].id_image,Form2.Image5.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,4].id_image,Form2.Image6.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,5].id_image,Form2.Image7.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,6].id_image,Form2.Image8.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,7].id_image,Form2.Image9.Picture.Bitmap);
  Form2.Label8.caption:='Preneur: '+inttostr(preneur);


  for i:=1 to 4 do
    begin
      belote:=0;
      for j:=0 to 7 do
        begin
          if (main[i,j].atout=true) and ( (main[i,j].id[1]='R') or (main[i,j].id[1]='D') ) then
            begin
              belote:=belote+1;
            end;

          if belote=2 then
            begin
              joueurquiabelote:=i;
            end;
        end;
    end;

end;

procedure choix_atout;
var
  pris:boolean;
  joueurquiprend:integer;
  I,J,K:integer;
begin
  pris:=false;
  joueurquiprend:=focus_joueur;

  for I:=1 to 4 do
    begin
      if joueurquiprend=1 then
        begin
          form4.showmodal;
          if atout<>'0' then pris:=true;
        end

                          else
        begin
         prendre_IA (joueurquiprend,1,pris); //choix IA
        end;
      if pris then
      begin
           for j:=1 to 32 do
             begin
               if deck[j].id[2]=deck[21].id[2] then
               begin
                 deck[j].atout:=True;
                 if deck[j].rang=6 then deck[i].rang:=0;
                 if deck[j].rang=7 then deck[i].rang:=1;
               end;
             end;
           for j:=1 to 4 do
             begin
               for k:=0 to length(main[j])do
                   begin
                        if main[j,k].id[2]=deck[21].id[2] then
                        begin
                        main[j,k].atout:=True;
                        if main[j,k].rang=6 then main[j,k].rang:=0;
                        if main[j,k].rang=7 then main[j,k].rang:=1;
                        end;
                   end;
             end;


           deck[21].pos:='main';
           atout:=deck[21].id[2];
           Form2.label2.caption:='Atout: '+atout;
           preneur:=joueurquiprend;

           deuxieme_distribution(joueurquiprend);
           Form2.Image18.Visible:=False;
           etat:='debut';
           debut_jeu;
           break;

      end;

      joueurquiprend:=joueurquiprend+1;
      if joueurquiprend=5 then
        begin
          joueurquiprend:=1;
        end;

    end;
   //Deux

   if not(pris) then
   begin
     for I:=1 to 4 do
     begin
       if joueurquiprend=1 then
        begin
          form5.showmodal;
          if atout<>'0' then pris:=true;
        end

                          else
        begin
          prendre_IA (joueurquiprend,2,pris); //Choix de la IA 2
        end;
      if pris then
      begin
           for j:=1 to 32 do
             begin
               if deck[j].id[2]=atout then
               begin
                 deck[j].atout:=True;
                 if deck[j].rang=6 then deck[j].rang:=0;
                 if deck[j].rang=7 then deck[j].rang:=1;
               end;
             end;
           for j:=1 to 4 do
             begin
               for k:=0 to length(main[j])do
                   begin
                        if main[j,k].id[2]=atout then
                        begin
                          main[j,k].atout:=True;
                          if main[j,k].rang=6 then main[j,k].rang:=0;
                          if main[j,k].rang=7 then main[j,k].rang:=1;
                        end;
                   end;
             end;
           deck[21].pos:='main';
           preneur:=joueurquiprend;
           deuxieme_distribution(joueurquiprend);
           Form2.Image18.Visible:=False;
           etat:='debut';
           debut_jeu;
           break;
      end;


     joueurquiprend:=joueurquiprend+1;
      if joueurquiprend=5 then
        begin
          joueurquiprend:=1;
        end;
     end;

     if pris=false then  //FAIRE LE CAS OU PERSONNE PRENDS ET LES CARTES SONT REDISTRIBUÉS
       begin
         Form2.Hide;
         Form2.Show;
         showmessage('Personne n''a pris, début d''une nouvelle partie');
         Form2.Image10Click(Form2.Image10);
       end;
   end;

end;

procedure fin_jeu(joueur_preneur:integer; dix_de_dern, belote:boolean);
var
plie_a_compter: tableau_plie;
i, count, points: integer;


begin
  count:=0;
  if joueur_preneur < 3 then
  begin
    plie_a_compter:=plie1;
  end else
  begin
    plie_a_compter:=plie2;
  end;
  //travailler plus sur le cas ou length(plie a compter)=0
  for i:=0 to length(plie_a_compter) do
  begin
       if plie_a_compter[i].rang=0 then
       begin
         points:=20;
       end else if plie_a_compter[i].rang=1 then
       begin
           points:=14;
       end else if plie_a_compter[i].rang=2 then
       begin
             points:=11;
            end else if plie_a_compter[i].rang=3 then
       begin
                points:=10;
                 end else if plie_a_compter[i].rang=4 then
       begin
                   points:=4;
                      end else if plie_a_compter[i].rang=5 then
       begin
                       points:=3
                           end else if plie_a_compter[i].rang=6 then
       begin
                          points:=2;
       end else
       begin
         points:=0;
       end;


       count:=count+points;
       Form6.label1.caption:='Points: '+ inttostr(count);

  end;
  if dix_de_dern then count:=count+10;
  if belote then count:=count+20;
  if count >  81 then
  begin
    Form6.ImageList1.GetBitmap(1,Form6.Image1.Picture.Bitmap);
    Form6.label2.caption:='Vous avez gagné la partie!';
  end
  else
  begin
    Form6.ImageList1.GetBitmap(0,Form6.Image1.Picture.Bitmap);
    Form6.label2.caption:='Vous etes dedans!';
  end;
end;

procedure fin_tour(centre_fintour : tableau_centre);//Procedure qui est appellé a la fin du tour pour calculer qui a gagné
var i,j: integer;
    atout_trouve: boolean;
    plus_fort: carte;
    demande: char;
    joueur_gagnant: integer;
    dern:boolean;
    nom_joueur: string;
begin
  atout_trouve:=false;
  dern:=false;
  //En cas d'atout

  for i:=1 to 4 do
    begin
    if centre_fintour[i].atout then
      begin
         atout_trouve:=true;
         joueur_gagnant:=i;
         plus_fort:=centre_fintour[i];
      end;
    end;
   if atout_trouve then
   begin
     for i:=1 to 4 do
     begin
           if (centre_fintour[i].atout=true) AND (centre_fintour[i].rang < plus_fort.rang) then
             begin
              joueur_gagnant:=i;
              plus_fort:=centre_fintour[i];
             end;
     end;
   end else
    begin
       plus_fort:=centre_fintour[focus_joueur];
       for i:=1 to 4 do
         begin
           if (centre_fintour[i].rang < plus_fort.rang)AND(centre_fintour[i].id[2]=plus_fort.id[2])then
             begin
              joueur_gagnant:=i;
              plus_fort:=centre_fintour[i];
             end;
         end;
    end;
  //On envoie les cartes à la pile de l'équipe gagnante:
  if (joueur_gagnant = 2) or(joueur_gagnant = 4) then
    begin
       for i:=1 to 4 do
         begin
              Insert(centre_fintour[i], plie2,length(plie2));
              Form2.ImageList1.GetBitmap(0,Form2.Image19.Picture.Bitmap);
         end;
    end else
    begin
         for i:=1 to 4 do
         begin
              Insert(centre_fintour[i], plie1,length(plie1));
              Form2.ImageList1.GetBitmap(0,Form2.Image20.Picture.Bitmap);
         end;
    end;

  Delete(centre,1,4);

  if (joueur_gagnant=0) or (joueur_gagnant=1) then
  begin
     Showmessage('Vous avez gagné la manche!');
  end;

  if joueur_gagnant=2 then
  begin
     Showmessage('Giovanni a remporté la manche');
  end;

  if joueur_gagnant=3 then
  begin
     Showmessage('Paul a gagné la manche');
  end;

  if joueur_gagnant=4 then
  begin
    Showmessage('Martiniel a gagné la manche');
    end;
  if joueur_gagnant=5 then
  begin
    showmessage('fodeu');
  end;

  manche:=manche+1;
  cartes_joues:=0;
  playcap:=0;
  Form2.Image15.Visible:=False;
  Form2.Image16.Visible:=False;
  Form2.Image17.Visible:=False;
  Form2.Image14.Visible:=False;
  focus_joueur:=joueur_gagnant;

  if manche<=8 then
  begin
     debut_jeu;
  end
  else
  begin
    if joueur_gagnant=preneur then
    begin
       dern:=true;
    end;
    showmessage('Fin du jeu');
    form6.show;
    form2.hide;
    if ( (joueur_gagnant=1) OR (joueur_gagnant=3) ) AND  ( (joueurquiabelote=1) OR (joueurquiabelote=3) ) then
      begin
        fin_jeu(preneur, dern, true);
      end
                                     else
      begin
        if ( (joueur_gagnant=2) OR (joueur_gagnant=4) ) AND  ( (joueurquiabelote=2) OR (joueurquiabelote=4) ) then
          begin
            fin_jeu(preneur, dern, true);
          end
                                         else
          begin
           fin_jeu(preneur, dern, false);
          end;
      end;
  end;


end;



end.

