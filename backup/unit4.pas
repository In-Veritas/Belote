unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  deckstructure, Unit2;

type

  { TForm4 }

  TForm4 = class(TForm)
    Image4: TImage;
    Image1: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormShow(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

{ TForm4 }



procedure TForm4.FormShow(Sender: TObject);
begin
  Form4.Image1.Picture:=Form2.Image18.Picture;
end;

procedure TForm4.Panel1Click(Sender: TObject);
begin
  atout:=copy(deck[21].id,2,1);
  Form4.Close;
end;

procedure TForm4.Panel2Click(Sender: TObject);
begin
   Form4.Close;
end;


end.

