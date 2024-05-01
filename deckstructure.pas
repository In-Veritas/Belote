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


procedure init_jeu;
procedure choix_atout;
procedure fin_tour(centre_fintour : tableau_centre; focus_joueur: integer);
procedure cartes_jouables(joueur:integer);
procedure permuter (var X,Y:carte);

function premierchoixcouleur (toutcouleur:string):integer;
function changementcouleur (x:integer):integer;
procedure triecouleur (I:integer;
                      couleur:string;
                      var C:integer);

procedure trieparcouleur ();
procedure trieminmaxparcouleur (I,min,max:integer);
procedure trierang();


function melangertableau(N:integer):tableau_deck;
procedure distribution_4joueurs(Nombredecarte,PremierJoueur:integer;
                                var IndiceCarte:integer);
procedure premiere_distribution (PremierJoueur:integer);
procedure deuxieme_distribution (PremierJoueur:integer);
procedure debut_manche(joueur: integer);









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

{etat debut

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

USES Unit2, unit4, unit5;



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

procedure init_jeu;
var
  i: integer;
begin
for i:=1 to 32 do
begin
  basedeck[i].jouable:=false;
end;
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
basedeck[32].id:='9C';
basedeck[32].atout:=False;
basedeck[32].rang:=7;
basedeck[32].pos:='basedeck';
basedeck[32].id_image:=32;

end;

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
procedure cartes_jouables(joueur:integer);
var
i,j: integer;
plus_fort: carte;
jouable_trouve:boolean;
begin
jouable_trouve:= false;
if length(centre) = 0 then
  begin
    for i:=1 to length(main[joueur]) do
    begin
      main[joueur,i].jouable:= True;
    end;
  end
  else if centre[focus_joueur].atout=True then
    begin
       plus_fort:=centre[focus_joueur];
       for i:=i to length(centre) do
       begin
          if (centre[i].rang < plus_fort.rang)AND(centre[i].atout = True) then plus_fort:=centre[i];
       end;
       for i:=1 to length(main[joueur])do
       begin
         if plus_fort.rang > main[joueur,i].rang then main[joueur,i].jouable:=True;
         jouable_trouve:= True;
       end;
       if not(jouable_trouve) then
       begin
          for i:=1 to length(main[joueur])do
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
           for i:=1 to length(main[joueur]) do
            begin
              main[joueur,i].jouable:= True;
              jouable_trouve:= True;
            end;
       end;
    end else
    begin
      for i:=1 to length(main[joueur]) do
      begin
        if main[joueur,i].id[2] = centre[focus_joueur].id[2] then
          begin
            main[joueur,i].jouable:= True;
            jouable_trouve:= True;
          end;
      end;
      if not(jouable_trouve) then
        begin
          for i:=1 to length(main[joueur])do
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
              for j:=1 to length(main[joueur]) do
              begin
                if main[joueur,j].rang < plus_fort.rang then
                begin
                  main[joueur,j].jouable:=True;
                  jouable_trouve:=True;
                end;
              end;
              if not(jouable_trouve)then
              begin
              for j:=1 to length(main[joueur]) do
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
             for i:=1 to length(main[joueur]) do
              begin
                main[joueur,i].jouable:= True;
                jouable_trouve:= True
              end;
         end;
        end;
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


procedure triecouleur (I:integer;
                      couleur:string;
                      var C:integer);
VAR
  couleurcarte:string;
  J,Min:integer;

begin
  Min:=C;
  for J:=Min to 7 do
    begin
      couleurcarte:=copy(main[I,J-1].id,2,1);
      if couleurcarte=couleur then
        begin
          permuter (main[I,J-1],main[I,C]);
          C:=C+1;

        end;
    end;
end;

procedure trieparcouleur();
VAR
  toutcouleur:string;
  a,I,C,x:integer;
  couleur:string;

begin
  toutcouleur:='PCTK';
  for I:=1 to 4 do //pour faire sur les quatres joueur
    begin
      C:=1;
      x:=premierchoixcouleur(toutcouleur);
      couleur:=copy(toutcouleur,x,1);
      for a:=1 to 4 do //pour faire les 4 couleur
        begin
          triecouleur(I,couleur,C);
          x:=changementcouleur(x);
          couleur:=copy(toutcouleur,x,1);
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

procedure trierang();
VAR
  I,J,min,max:integer;
  couleur1,couleur2:string;

begin
  for I:=1 to 4 do
    begin
      min:=1;
      max:=1;
      while min<8 do
        begin
          couleur1:=copy(main[I,min].id,2,1);
          couleur2:=copy(main[I,max].id,2,1);
          while (couleur1=couleur2) and (max<8) do
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

procedure distribution_4joueurs(Nombredecarte,PremierJoueur:integer;
                                var IndiceCarte:integer);
//Nombredecarte => le nombre de carte à distribuer
//PremierJoueur => le premier joueur à recevoir les cartes (de 1 à 4)
//IndiceCarte => à quelle carte on en est dans la "pioche"

{
 quand joueur prend ba on rajoute la carte deck[21] comme premier truc!!!!
}

VAR
  I,J:integer;
  Chaine: string;
  distribue: array of carte;
begin
  for I:=1 to 4 do
    begin
      setlength(distribue,nombredecarte);
      for J:=1 to Nombredecarte do
        begin
          distribue[J-1]:= deck[IndiceCarte];
          Chaine:='Joueur'+inttostr(PremierJoueur);
          deck[IndiceCarte].pos:=Chaine;
          distribue[J-1].pos:=Chaine;
          IndiceCarte:=IndiceCarte+1;
          //showmessage(inttostr(distribue[J-1].id_image));
        end;
      insert(distribue,main[I],1);


      PremierJoueur:=PremierJoueur+1;

      If (PremierJoueur>4) then
        begin
          PremierJoueur:=1;
        end;
    end;












{
for I:=1 to 4 do

    begin
      showmessage(inttostr(PremierJoueur));
      {if preneur=PremierJoueur then
        begin
          for J:=1 to Nombredecarte-1 do
            begin

              SetLength(main[PremierJoueur], length(main[PremierJoueur])+1);
              main[PremierJoueur,length(main[PremierJoueur])]:=deck[IndiceCarte];
              Chaine:='Joueur'+inttostr(PremierJoueur);
              deck[IndiceCarte].pos:=Chaine;
              main[PremierJoueur,length(main[PremierJoueur])].pos:=Chaine;
              IndiceCarte:=IndiceCarte+1;
            end;
        end
                                else  }
      //begin
        for J:=1 to Nombredecarte do
         begin
           showmessage(inttostr(length(deck)));
           showmessage(inttostr(IndiceCarte));
           insert(deck[IndiceCarte],main[PremierJoueur],length(main[PremierJoueur])+1);
         // SetLength(main[PremierJoueur], length(main[PremierJoueur])+1);

          //main[PremierJoueur,length(main[PremierJoueur])]:=deck[IndiceCarte];
          Chaine:='Joueur'+inttostr(PremierJoueur);
          deck[IndiceCarte].pos:=Chaine;
          main[PremierJoueur,length(main[PremierJoueur])].pos:=Chaine;
          IndiceCarte:=IndiceCarte+1;
          {showmessage(inttostr(I));
          showmessage(inttostr(length(main[I])));}
        // end;
      end;

      PremierJoueur:=PremierJoueur+1;

      If (PremierJoueur>4) then
        begin
          PremierJoueur:=1;
        end;
      showmessage(inttostr(PremierJoueur));
    end;


      PremierJoueur:=PremierJoueur+1;

      If (PremierJoueur>4) then
        begin
          PremierJoueur:=1;
        end;
      showmessage(inttostr(PremierJoueur));   }

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

procedure premiere_distribution (PremierJoueur:integer);//en variable globale peut être, si ou on a besoin de rien pour cette procedure

VAR
  IndiceCarte,Indiceimagecarte:integer;
begin
  etat:='choix';

  SetLength(main, 5, 0);  //j'alloue le tableau main
  preneur:=0;
  atout:='0';
  IndiceCarte:=1;
  deck:=melangertableau(3000);

  distribution_4joueurs(3,PremierJoueur,IndiceCarte);
  Form2.ImageList1.GetBitmap(main[1,0].id_image,Form2.Image2.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,1].id_image,Form2.Image3.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,2].id_image,Form2.Image4.Picture.Bitmap);
  distribution_4joueurs(2,PremierJoueur,IndiceCarte);
  Form2.ImageList1.GetBitmap(main[1,3].id_image,Form2.Image5.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,4].id_image,Form2.Image6.Picture.Bitmap);
  Form2.Timer1.Enabled:=True;
  {trieparcouleur();//trie des cartes de chaques joueurs
  trierang();    }

  //affiche la mains du joueur 1

  Form2.Image18.Visible:=True;
  Form2.ImageList1.GetBitmap(deck[21].id_image,Form2.Image18.Picture.Bitmap);
  Form2.Enabled:=True;

end;

procedure deuxieme_distribution (PremierJoueur:integer);//en variable globale peut être, si ou on a besoin de rien pour cette procedure
VAR
  IndiceCarte:integer;
  Chaine:string;
  carte_prise: array of carte;
begin
  SetLength(carte_prise,1);
  carte_prise[0]:=deck[21];
  insert(carte_prise,main[preneur],length(main[preneur]));
  Chaine:='Joueur'+inttostr(preneur);
  main[preneur,length(main[preneur])].pos:=Chaine;
  deck[21].pos:=Chaine;

  IndiceCarte:=22;
  distribution_4joueurs(3,PremierJoueur,IndiceCarte);
  miseajouratout();

  {trieparcouleur();//trie des cartes de chaques joueurs
  trierang(); }

  //affiche les cartes du joueurs 1
  Form2.ImageList1.GetBitmap(main[1,0].id_image,Form2.Image2.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,2].id_image,Form2.Image3.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,2].id_image,Form2.Image4.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,3].id_image,Form2.Image5.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,4].id_image,Form2.Image6.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,5].id_image,Form2.Image7.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,6].id_image,Form2.Image8.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(main[1,7].id_image,Form2.Image9.Picture.Bitmap);


end;

procedure choix_atout;
var
  pris:boolean;
  joueurquiprend:integer;
  I,J:integer;
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
          //Choix de la IA
        end;
      if pris then
      begin
           for j:=1 to 32 do
             begin
               if deck[i].id[2]=deck[20].id[2] then
               begin
                 deck[i].atout:=True;
               end;
             end;
           deck[21].pos:='main';
           preneur:=I;
           deuxieme_distribution(focus_joueur);
           Form2.Image18.Visible:=False;
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
          //Choix de la IA 2
        end;
      if pris then
      begin
           for j:=1 to 32 do
             begin
               if deck[i].id[2]=atout then
               begin
                 deck[i].atout:=True;
               end;
             end;
           deck[21].pos:='main';
           preneur:=I;
           deuxieme_distribution(focus_joueur);
           Form2.Image18.Visible:=False;
           break;
      end;
      joueurquiprend:=joueurquiprend+1;
      if joueurquiprend=5 then
        begin
          joueurquiprend:=1;
        end;
     end;
     //FAIRE LE CAS OU PERSONNE PRENDS ET LES CARTES SONT REDISTRIBUÉS
   end;
end;



//Initialization du basedeck



end.

