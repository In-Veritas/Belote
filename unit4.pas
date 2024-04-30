unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  deckstructure, Unit2;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

{ TForm4 }

procedure TForm4.FormActivate(Sender: TObject);
begin
  Form4.Image1.Picture:=Form2.Image16.Picture;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  atout:=copy(deck[21].id,2,1);
  TForm4.Close;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  TForm4.Close;
end;

end.

