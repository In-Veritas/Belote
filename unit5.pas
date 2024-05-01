unit Unit5;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,unit2
  ,deckstructure;

type

  { TForm5 }

  TForm5 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
  private

  public

  end;

var
  Form5: TForm5;

implementation

{$R *.lfm}

{ TForm5 }

procedure TForm5.Panel4Click(Sender: TObject);
begin
  atout:='Coeur';
  Form5.Close;
  Form2.label2.caption:='Atout: '+atout;
end;

procedure TForm5.Panel1Click(Sender: TObject);
begin
  atout:='Piques';
  Form5.Close;
  Form2.label2.caption:='Atout: '+atout;
end;

procedure TForm5.Panel2Click(Sender: TObject);
begin
  atout:='Carreaux';
  Form5.Close;
  Form2.label2.caption:='Atout: '+atout;
end;

procedure TForm5.Panel3Click(Sender: TObject);
begin
  atout:='Trefle';
  Form5.Close;
  Form2.label2.caption:='Atout: '+atout;
end;

end.

