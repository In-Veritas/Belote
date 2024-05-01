unit Unit5;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,deckstructure;

type

  { TForm5 }

  TForm5 = class(TForm)
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
  atout:='C';
  Form5.Close;
end;

procedure TForm5.Panel1Click(Sender: TObject);
begin
  atout:='P';
  Form5.Close;
end;

procedure TForm5.Panel2Click(Sender: TObject);
begin
  atout:='K';
  Form5.Close;
end;

procedure TForm5.Panel3Click(Sender: TObject);
begin
  atout:='T';
  Form5.Close;
end;

end.

