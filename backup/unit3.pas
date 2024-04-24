unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;
Type carte = record
                    id : string[2];  //[1] = Nom de la carte(V = Vallet, R = Roi, N = neuf(...)), [2] = Couleur de la carte (Piques: P, Coeurs: C. Trèfles: T, Carreaux: K)
                    atout: boolean;
                    rang : integer;
                    pos: string[10]; //deck, Joeur(1..4), Centre, Pile(1..2)
                              end;
type

  { TForm3 }

  TForm3 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
  private

  public
  end;

var
  Form3: TForm3;
  basedeck: array[1..32] of carte;
implementation

{$R *.lfm}

//DEVOIR DE GIGI, Mettre les cartes dans les imagelist correspondantes
{Donc la logique du jeu marche de la façon suivante

Pour savoir qui commence, on tire au sort 4 cartes du deck de base, qui répresentent chaque joueur, la position de la carte plus grande entre les 4

MENU PRICIPALE
  Si le joueur clique sur nouveau jeu, les étapes se suivent normalement.
DISTRIBUITION INITIALE
  Du moment oú le form2 est activé:
  Un array 1..32 de cartes est crée avec les cartes de deckStructure mélagés de façon aleatoire
     **Faire fonction qui prends l'array de de Init_Cartes, et qui retourne un array mélangé. Placer cette fonction dans l'unité deckStructure
     **C'est l'array mélangé qu'on va travailler avec, sa position est 'deck'
  On fera la distruibuition initial (3-3-3-3, 2-2-2-2), on prennant les cartes du deck melangé par ordre, et on montrera la carté à prendre
     **Procedure de distribuition qui change la position des cartes de 'deck' pour 'main'
     **Tri de la main a la fin(plus élegant)
CHOIX DE L'ATOUT
  On verifie qui commence pour savoir qui va dire en premier(au début tous les joueurs artificiels diront 'une'/'deux')
  Lá, on attend une action de l'utilisateur, deux bouttons vont apparaitre 'Une', 'Je Prends'
      **Procedure qui fait apparaitre et disparaitre les options, et qui termine le CHOIX DE L'ATOUT, si l'utilisateur prend
  Si l'utilisateur ne prends pas au premier tour, donc dans le deuxième il peut choisir entre 'deux', ou prendre à une couleur spécifique
      **Procedure qui donne au joueur les bouttons de 'deux' et de choisir une couleur. REMARQUE: La couleur de la carte à choisir ne doit pas être entre les options affichés
  On va parcourir toutes les cartes dans les positions 'main', et 'deck', et changer l'aout pour TRUE pour les cartes qui sont á l'atout
DISTRIBUITION FINALE
  On identifie le joueur qui a pris, il recevera une carte de mois. On suit l'ordre des cartes dans deck et on fait la distribuition(3,3,3,2).
     **Procedure de distribuition qui prendra le joueur qui a pris en compte.
     Tri de la main a la fin(plus élegant)
******LE JEU COMMENCE******


Demander a iji pour couper/melanger entre parties





}
begin
     basedeck[1].id:='7P'; //7 de Piques
     basebasedeck[1].atout:=False;
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

