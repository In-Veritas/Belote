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
    procedure FormShow(Sender: TObject);
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
  Form2.label2.caption:='Atout: Coeur';
end;

procedure TForm5.Panel1Click(Sender: TObject);
begin
  atout:='P';
  Form5.Close;
  Form2.label2.caption:='Atout: Pique';
end;

procedure TForm5.FormShow(Sender: TObject);
VAR
  couleur:string;
begin
  couleur:=deck[21].id[2];

  if couleur='C' then
    begin
      Form5.Panel1.Enabled:=true;
      Form5.Panel2.Enabled:=true;
      Form5.Panel3.Enabled:=true;
      Form5.Panel4.Enabled:=False;
      Form5.Panel4.Hint:='Impossible';
    end;

  if couleur='K' then
    begin
      Form5.Panel1.Enabled:=true;
      Form5.Panel4.Enabled:=true;
      Form5.Panel3.Enabled:=true;
      Form5.Panel2.Enabled:=False;
      Form5.Panel2.Hint:='Impossible';
    end;

  if couleur='P' then
    begin
      Form5.Panel4.Enabled:=true;
      Form5.Panel2.Enabled:=true;
      Form5.Panel3.Enabled:=true;
      Form5.Panel1.Enabled:=False;
      Form5.Panel1.Hint:='Impossible';
    end;

  if couleur='T' then
    begin
      Form5.Panel1.Enabled:=true;
      Form5.Panel2.Enabled:=true;
      Form5.Panel4.Enabled:=true;
      Form5.Panel3.Enabled:=False;
      Form5.Panel3.Hint:='Impossible';
    end;

  Form5.showhint:=true;

end;

procedure TForm5.Panel2Click(Sender: TObject);
begin
  atout:='K';
  Form5.Close;
  Form2.label2.caption:='Atout: Carreau';
end;

procedure TForm5.Panel3Click(Sender: TObject);
begin
  atout:='T';
  Form5.Close;
  Form2.label2.caption:='Atout: Trefle';
end;

end.

