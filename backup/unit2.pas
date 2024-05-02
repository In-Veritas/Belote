unit Unit2;  //INTERFACE PRINCIPALE

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls,unit7, deckstructure;

type

  { TForm2 }


  TForm2 = class(TForm)
    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image2: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    ImageList1: TImageList;
    ImageList2: TImageList;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    Timer1: TTimer;
    procedure Image10Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure jouercarte (cartejouer:carte;
               joueur : integer);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure Timer1StartTimer(Sender: TObject);


  private

  public

  end;

var
  Form2: TForm2;

implementation


{$R *.lfm}

{ TForm2 }

procedure TForm2.jouercarte (cartejouer:carte;
                            joueur : integer);
VAR
  I:integer;

begin
  setlength(centre,5);
  centre[joueur]:=cartejouer;

  if joueur=1 then
    begin
      Form2.Image14.Visible:=True;
      imagelist1.getbitmap(centre[joueur].id_image,Image14.Picture.Bitmap);
      image2.Enabled:=False;
      image3.Enabled:=False;
      image4.Enabled:=False;
      image5.Enabled:=False;
      image6.Enabled:=False;
      image7.Enabled:=False;
      image8.Enabled:=False;
      image9.Enabled:=False;
      cartes_joues:=cartes_joues+1;

      if (cartes_joues=4) OR (playcap = 4) then
       begin
        fin_tour(centre);

       end
                         else
       begin
        playcap:=playcap+1;
        cartes_jouables(2);
       end;

    end else


  if joueur=4 then
    begin
      Form2.Image17.Visible:=True;
      imagelist1.getbitmap(centre[joueur].id_image,Image17.Picture.Bitmap);
      cartes_joues:=cartes_joues+1;

      if (cartes_joues=4) OR (playcap = 4) then
      begin
        fin_tour(centre);


      end                 else
      begin
        playcap:=playcap+1;
        cartes_jouables(1);
      end;
    end else

  if joueur=3 then
    begin
      Form2.Image15.Visible:=True;
      imagelist1.getbitmap(centre[joueur].id_image,Image15.Picture.Bitmap);
      cartes_joues:=cartes_joues+1;

      if (cartes_joues=4) OR (playcap = 4) then
       begin
        fin_tour(centre);
       end                 else
      begin
        playcap:=playcap+1;
        cartes_jouables(4);
      end;
    end else

  if joueur=2 then
    begin
      Form2.Image16.Visible:=True;
      imagelist1.getbitmap(centre[joueur].id_image,Image16.Picture.Bitmap);
      cartes_joues:=cartes_joues+1;

       if (cartes_joues=4) OR (playcap = 4) then
       begin
         fin_tour(centre);
       end                 else
      begin
        playcap:=playcap+1;
        cartes_jouables(3);
      end;
    end;
end;



procedure TForm2.Image3Click(Sender: TObject);
VAR
  cartejouer:carte;
begin
  if main[1,1].jouable=true then
    begin
      cartejouer:=main[1,1];
      jouercarte(cartejouer,1);
      Image3.visible:=False;
      if (joueurquiabelote=1) and (main[1,1].atout=true) and ( (main[1,1].id[1]='R') OR (main[1,1].id[1]='D') ) then
        begin
          showmessage('Belote!');
        end;

      main[1,1].jouable:=false;
      main[1,1].rang:=10;
      main[1,1].atout:=false;
      main[1,1].id:='00';
      main[1,1].id_image:=0;
    end;
end;

procedure TForm2.Image10Click(Sender: TObject);
begin
  if etat='choix' then
  begin
    premiere_distribution (focus_joueur);
    //METTRE LE VRAI SLEEP
    choix_atout;
    Form2.showhint:=False;
    Image10.Enabled:=False;
  end;
end;

procedure TForm2.Image4Click(Sender: TObject);
VAR
  cartejouer:carte;
begin
  if main[1,2].jouable=true then
    begin
      cartejouer:=main[1,2];
      jouercarte(cartejouer,1);
      Image4.visible:= False;
      if (joueurquiabelote=1) and (main[1,2].atout=true) and ( (main[1,2].id[1]='R') OR (main[1,2].id[1]='D') ) then
        begin
          showmessage('Belote!');
        end;

      main[1,2].jouable:=false;
      main[1,2].rang:=10;
      main[1,2].atout:=false;
      main[1,2].id:='00';
      main[1,2].id_image:=0;
    end;


end;

procedure TForm2.Image5Click(Sender: TObject);
VAR
  cartejouer:carte;
begin
  if main[1,3].jouable=true then
    begin
      cartejouer:=main[1,3];
      jouercarte(cartejouer,1);
      Image5.visible:= False;
      if (joueurquiabelote=1) and (main[1,3].atout=true) and ( (main[1,3].id[1]='R') OR (main[1,3].id[1]='D') ) then
        begin
          showmessage('Belote!');
        end;

      main[1,3].jouable:=false;
      main[1,3].rang:=10;
      main[1,3].atout:=false;
      main[1,3].id:='00';
      main[1,3].id_image:=0;
    end;
end;

procedure TForm2.Image6Click(Sender: TObject);
VAR
  cartejouer:carte;
begin
  if main[1,4].jouable=true then
    begin
      cartejouer:=main[1,4];
      jouercarte(cartejouer,1);
      Image6.visible:= False;

      if (joueurquiabelote=1) and (main[1,4].atout=true) and ( (main[1,4].id[1]='R') OR (main[1,4].id[1]='D') ) then
        begin
          showmessage('Belote!');
        end;

      main[1,4].jouable:=false;
      main[1,4].rang:=10;
      main[1,4].atout:=false;
      main[1,4].id:='00';
      main[1,4].id_image:=0;
    end;
end;

procedure TForm2.Image7Click(Sender: TObject);
VAR
  cartejouer:carte;
begin
  if main[1,5].jouable=true then
    begin
      cartejouer:=main[1,5];
      jouercarte(cartejouer,1);
      Image7.visible:= False;
      if (joueurquiabelote=1) and (main[1,5].atout=true) and ( (main[1,5].id[1]='R') OR (main[1,5].id[1]='D') ) then
        begin
          showmessage('Belote!');
        end;

      main[1,5].jouable:=false;
      main[1,5].rang:=10;
      main[1,5].atout:=false;
      main[1,5].id:='00';
      main[1,5].id_image:=0;
    end;
end;

procedure TForm2.Image8Click(Sender: TObject);
VAR
  cartejouer:carte;
begin
  if main[1,6].jouable=true then
    begin
      cartejouer:=main[1,6];
      jouercarte(cartejouer,1);
      Image8.visible:= False;
      if (joueurquiabelote=1) and (main[1,6].atout=true) and ( (main[1,6].id[1]='R') OR (main[1,6].id[1]='D') ) then
        begin
          showmessage('Belote!');
        end;

      main[1,6].jouable:=false;
      main[1,6].rang:=10;
      main[1,6].atout:=false;
      main[1,6].id:='00';
      main[1,6].id_image:=0;
    end;
end;

procedure TForm2.Image9Click(Sender: TObject);
VAR
  cartejouer:carte;
begin
  if main[1,7].jouable=true then
    begin
      cartejouer:=main[1,7];
      jouercarte(cartejouer,1);
      Image9.visible:= False;
      if (joueurquiabelote=1) and (main[1,7].atout=true) and ( (main[1,7].id[1]='R') OR (main[1,7].id[1]='D') ) then
        begin
          showmessage('Belote!');
        end;
      main[1,7].jouable:=false;
      main[1,7].rang:=10;
      main[1,7].atout:=false;
      main[1,7].id:='00';
      main[1,7].id_image:=0;
    end;
end;

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  application.Terminate;
end;

procedure TForm2.FormShow(Sender: TObject);
var
nom_joueur: string;
begin
  randomize;
  playcap:=0;
  Form2.ImageList1.GetBitmap(0,Form2.Image2.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(0,Form2.Image3.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(0,Form2.Image4.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(0,Form2.Image5.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(0,Form2.Image6.Picture.Bitmap);
  Form2.ImageList1.GetBitmap(0,Form2.Image18.Picture.Bitmap);

  focus_joueur:=random(4)+1;

  if focus_joueur=1 then
  begin
    nom_joueur:= 'Toi!';
  end else if focus_joueur=2 then
  begin
    nom_joueur:= 'Giovanni';
  end else if focus_joueur=3 then
  begin
    nom_joueur:= 'Paul';
  end else if focus_joueur=4 then
  begin
    nom_joueur:= 'Martiniel';
  end;


  etat:='choix';
  Form2.Hint:='Cliquez sur le tapis pour commencer';
  Form2.Showhint:=True;
  showmessage(nom_joueur + ' Commence! Cliquez sur le tapis pour commencer');
end;

procedure TForm2.Image2Click(Sender: TObject);
VAR
  cartejouer:carte;
begin
  if main[1,0].jouable=true then
    begin
      cartejouer:=main[1,0];
      jouercarte(cartejouer,1);
      Image2.visible:= False;
      if (joueurquiabelote=1) and (main[1,0].atout=true) and ( (main[1,0].id[1]='R') OR (main[1,0].id[1]='D') ) then
        begin
          showmessage('Belote!');
        end;
      main[1,0].jouable:=false;
      main[1,0].rang:=10;
      main[1,0].atout:=false;
      main[1,0].id:='00';
      main[1,0].id_image:=0;

    end;
end;

procedure TForm2.MenuItem1Click(Sender: TObject);
begin
  Form7.showmodal;
end;



procedure TForm2.Timer1StartTimer(Sender: TObject);
begin
  Application.processmessages;
end;



end.

