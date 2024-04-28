unit DeckStructure;


{$mode ObjFPC}{$H+}
interface




uses
  Classes, SysUtils,Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Unit2, Unit3;
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

procedure fin_tour(centre_fintour : tableau_centre; focus_joueur: integer);
procedure cartes_jouables(joueur:integer; var jouables: array of boolean);
procedure permuter (var X,Y:carte);
function melangertableau(N:integer):tableau_deck;
procedure distribution_4joueurs(Nombredecarte,PremierJoueur:integer;
                                var IndiceCarte:integer);
procedure premiere_distribution (PremierJoueur:integer);
procedure deuxieme_distribution (PremierJoueur:integer);
procedure miseajouratout();
function premierchoixcouleur (toutcouleur:string):integer;
function changementcouleur (x:integer):integer;
procedure triecouleur (I:integer;
                      couleur:string;
                      var C:integer);
procedure trieparcouleur ();
procedure init_jeu;






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
var
i,j: integer;
plus_fort: carte;
jouable_trouve:boolean;
begin
{Primeiro voce ve se ja tem cartas na mesa
Se sim, voce olha pra primeira carta, e pega o naipe
  se o naipe for atout:
          Se jogar um atout mais forte é possivel:
             os atous mais fortes sao jogaveis
          senao qualquer carta de atout vale]
  senão, voce só pode jogar o naipe da primeira carta
         se voce tiver o naipe da primeira carta:
            todas as cartas desse naipe são jogaveis
         se voce nao tiver o naipe da primeira carta:
             se tem atout na mão:
                verificar os atouts na mesa:
                          Pegar o atout mais forte na mesa
                                Se tiver um atout na mão, mais forte que os da mesa, ele é jogavel
                                senão, todos os atouts são jogaveis
             senã :
                todas as cartas são jogaveis
Se não, todas as cartas são jogaveis}
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


function melangertableau(N:integer):tableau_deck; //fonction qui mélange un tableau, N sert au nombre de mélange
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

  melangertableau:=T;  //la fonction renvois le tableau mélanger  (a un moment deck:=melangertableau(nombre de mélange);)
end;

procedure distribution_4joueurs(Nombredecarte,PremierJoueur:integer;
                                var IndiceCarte:integer);
//Nombredecarte => le nombre de carte à distribuer
//PremierJoueur => le premier joueur à recevoir les cartes (de 1 à 4)
//IndiceCarte => à quelle carte on en est dans la "pioche"

VAR
  I,J:integer;
  Chaine: string;
begin
    for I:=1 to 4 do
    begin
      if preneur=PremierJoueur then
        begin
          for J:=1 to Nombredecarte-1 do
            begin
              SetLength(main[I], length(main[I])+1);
              main[PremierJoueur,length(main[I])]:=deck[IndiceCarte];
              Chaine:='Joueur'+inttostr(PremierJoueur);
              deck[IndiceCarte].pos:=Chaine;
              main[PremierJoueur,length(main[I])].pos:=Chaine;
              IndiceCarte:=IndiceCarte+1;
            end;
        end
                                else
      begin
        for J:=1 to Nombredecarte do
         begin
          SetLength(main[I], length(main[I])+1);
          main[PremierJoueur,length(main[I])]:=deck[IndiceCarte];
          Chaine:='Joueur'+inttostr(PremierJoueur);
          deck[IndiceCarte].pos:=Chaine;
          main[PremierJoueur,length(main[I])].pos:=Chaine;
          IndiceCarte:=IndiceCarte+1;
         end;
      end;

      PremierJoueur:=PremierJoueur+1;
      If (PremierJoueur>4) then
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

procedure premiere_distribution (PremierJoueur:integer);//en variable globale peut être, si ou on a besoin de rien pour cette procedure

VAR
  IndiceCarte:integer;
begin
  SetLength(main, 4, 0);  //j'alloue le tableau main
  preneur:=0;
  atout:='0';
  IndiceCarte:=1;

  distribution_4joueurs(3,PremierJoueur,IndiceCarte);
  distribution_4joueurs(2,PremierJoueur,IndiceCarte);

  trieparcouleur();//trie des cartes de chaques joueurs
end;

procedure deuxieme_distribution (PremierJoueur:integer);//en variable globale peut être, si ou on a besoin de rien pour cette procedure
VAR
  IndiceCarte:integer;
  Chaine:string;
begin
  SetLength(main[preneur], length(main[preneur])+1);
  main[preneur,length(main[preneur])]:=deck[21];
  Chaine:='Joueur'+inttostr(preneur);
  main[preneur,length(main[preneur])].pos:=Chaine;
  deck[21].pos:=Chaine;

  IndiceCarte:=22;
  distribution_4joueurs(3,PremierJoueur,IndiceCarte);
  miseajouratout();

  trieparcouleur();//trie des cartes de chaques joueurs
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
  for J:=Min to 8 do
    begin
      couleurcarte:=copy(main[I,J].id,2,1);
      if couleurcarte=couleur then
        begin
          permuter (main[I,J],main[I,C]);
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
      x:=premierchoixcouleur (toutcouleur);
      couleur:=copy(toutcouleur,x,1);
      for a:=1 to 4 do //pour faire les 4 couleur
        begin
          triecouleur(I,couleur,C);
          x:=changementcouleur(x);
          couleur:=copy(toutcouleur,x,1);
        end;
    end;
end;



//Initialization du basedeck
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


end.

