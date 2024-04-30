unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

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
     FAIT**Faire fonction qui prends l'array de de Init_Cartes, et qui retourne un array mélangé. Placer cette fonction dans l'unité deckStructure
     FAIT**C'est l'array mélangé qu'on va travailler avec, sa position est 'deck'
  On fera la distruibuition initial (3-3-3-3, 2-2-2-2), on prennant les cartes du deck melangé par ordre, et on montrera la carté à prendre
     FAIT**Procedure de distribuition qui change la position des cartes de 'deck' pour 'main'
     FAIT**Tri de la main a la fin(plus élegant)
CHOIX DE L'ATOUT
  On verifie qui commence pour savoir qui va dire en premier(au début tous les joueurs artificiels diront 'une'/'deux')
  Lá, on attend une action de l'utilisateur, deux bouttons vont apparaitre 'Une', 'Je Prends'
      **Procedure qui fait apparaitre et disparaitre les options, et qui termine le CHOIX DE L'ATOUT, si l'utilisateur prend
  Si l'utilisateur ne prends pas au premier tour, donc dans le deuxième il peut choisir entre 'deux', ou prendre à une couleur spécifique
      **Procedure qui donne au joueur les bouttons de 'deux' et de choisir une couleur. REMARQUE: La couleur de la carte à choisir ne doit pas être entre les options affichés
  On va parcourir toutes les cartes dans les positions 'main', et 'deck', et changer l'aout pour TRUE pour les cartes qui sont á l'atout
DISTRIBUITION FINALE
  On identifie le joueur qui a pris, il recevera une carte de mois. On suit l'ordre des cartes dans deck et on fait la distribuition(3,3,3,2).
     FAIT**Procedure de distribuition qui prendra le joueur qui a pris en compte.
     Tri de la main a la fin(plus élegant)


******LE JEU COMMENCE******


Demander a iji pour couper/melanger entre parties



}
begin

end.

