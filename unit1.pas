unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,uos, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  deckstructure,Unit2, Unit3;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
  private

  public
  end;

var
  Form1: TForm1;
  deck: array[1..32] of carte;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.Panel1Click(Sender: TObject); //Ouvre une nouvelle partie
begin
   Form1.hide;
   Form2.show;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
   deck:=basedeck;
end;

procedure TForm1.Panel2Click(Sender: TObject); //Ouvre une partie sauvegardé
begin
  if opendialog1.execute then showmessage('ON A PAS FINI ÇA'); //A FINIR
end;

end.

