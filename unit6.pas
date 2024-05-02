unit Unit6;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,unit2, deckstructure;

type

  { TForm6 }

  TForm6 = class(TForm)
    Image1: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  Form6: TForm6;

implementation

{$R *.lfm}

{ TForm6 }



procedure TForm6.FormShow(Sender: TObject);
begin

end;

procedure TForm6.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.terminate;
end;

procedure TForm6.Image1Click(Sender: TObject);
begin

end;

procedure TForm6.Label1Click(Sender: TObject);
begin

end;

end.

