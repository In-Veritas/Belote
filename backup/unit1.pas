unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  uplaysound, deckstructure, Unit2, Unit3;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    playsound1: Tplaysound;
    Timer1: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Timer1StartTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Random_music;
  private

  public

  end;

var
  Form1: TForm1;





implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.Panel1Click(Sender: TObject); //Ouvre une nouvelle partie
begin
   Form1.hide;
   init_jeu;
   Form2.show;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  RequireDerivedFormResource:=True;
  Form1.Show;
  Form1.Visible:=True;
  Timer1.enabled:=True;
  deck:=basedeck;
end;


procedure TForm1.Panel2Click(Sender: TObject); //Ouvre une partie sauvegardé
begin
  if opendialog1.execute then showmessage('ON A PAS FINI ÇA'); //A FINIR
end;
procedure Tform1.random_music;
var
song: integer;
begin
  randomize;
  song:=random(3)+1;
  if song = 1 then
  begin
    playsound1.soundfile:='music1.wav';
    timer1.interval:=168000;

  end else if song = 2 then
  begin
    playsound1.soundfile:='music2.wav';
    timer1.interval:=96000;
  end else
  begin
    playsound1.soundfile:='music3.wav';
    timer1.interval:=179000;
  end;
  playsound1.execute;


end;
procedure TForm1.Timer1StartTimer(Sender: TObject);
begin
   random_music;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  random_music;
end;



end.

