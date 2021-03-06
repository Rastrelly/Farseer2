unit utools;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    ex1: TLabeledEdit;
    ex2: TLabeledEdit;
    ey1: TLabeledEdit;
    ey2: TLabeledEdit;
    StaticText1: TStaticText;
    ic1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    ic2: TImage;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Timer1: TTimer;
    ColorDialog1: TColorDialog;
    ColorDialog2: TColorDialog;
    Button4: TButton;
    Label4: TLabel;
    econt: TEdit;
    Button5: TButton;
    procedure FillList;
    procedure FormShow(Sender: TObject);
    procedure ShowSObjInfo;
    procedure setsobjinfo;
    procedure ListBox1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ic1Click(Sender: TObject);
    procedure ic2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  iclr1,iclr2:TColor;


implementation

{$R *.dfm}

uses ufarseer2;

procedure TForm3.Button1Click(Sender: TObject);
begin
  setsobjinfo;
  objects[selobj]:=tempobj;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  setlength(sizedots,0);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  setlength(objects,0);
end;

procedure TForm3.Button4Click(Sender: TObject);
var i:integer;
begin
  if (selobj<(length(objects)-1)) then
  for i:=selobj to length(objects)-2 do
  begin
    objects[i]:=objects[i+1];
  end;
  setlength(objects,length(objects)-1);
  filllist;
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  contrast:=strtoint(econt.Text);
end;

procedure TForm3.FillList;
var i,k:integer; onm:string;
begin
  ListBox1.Clear;
  k:=length(objects)-1;
  for i:=0 to k do
  begin
    case objects[i].objtp of
    4:onm:='?????';
    5:onm:='???????';
    6:onm:='?????????????';
    7:onm:='??????';
    end;
    ListBox1.Items.Add(inttostr(i)+') '+onm);
  end;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  FillList;
  econt.Text:=inttostr(contrast);
end;

procedure Tform3.ShowSObjInfo;
begin
  //??????? ?????????? ? ????????? ???????
  with tempobj do
  begin
    case objtp of
    4:combobox1.itemindex:=0;
    5:combobox1.itemindex:=1;
    6:combobox1.itemindex:=2;
    7:combobox1.itemindex:=3;
    end;
    ex1.Text:=floattostr(x1);
    ex2.Text:=floattostr(x2);
    ey1.Text:=floattostr(y1);
    ey2.Text:=floattostr(y2);
    iclr1:=color1;
    iclr2:=color2;
  end;
end;

procedure tform3.setsobjinfo;
begin
  //?????????? ?????? ?? ????????? ??????
  with tempobj do
  begin
    case combobox1.itemindex of
    0:objtp:=4;
    1:objtp:=5;
    2:objtp:=6;
    3:objtp:=7;
    end;
    x1:=strtofloat(ex1.Text);
    x2:=strtofloat(ex2.Text);
    y1:=strtofloat(ey1.Text);
    y2:=strtofloat(ey2.Text);
    color1:=iclr1;
    color2:=iclr2;
  end;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  if form3.Visible=true then
  begin
    ic1.Canvas.Pen.Color:=clBlack;
    ic1.Canvas.Brush.Color:=iclr1;
    ic1.Canvas.Rectangle(0,0,ic1.Width,ic1.Height);
    ic2.Canvas.Pen.Color:=clBlack;
    ic2.Canvas.Brush.Color:=iclr2;
    ic2.Canvas.Rectangle(0,0,ic2.Width,ic2.Height);
  end;
end;

procedure TForm3.ic1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then iclr1:=ColorDialog1.Color;
end;

procedure TForm3.ic2Click(Sender: TObject);
begin
  if ColorDialog1.Execute then iclr2:=ColorDialog1.Color;
end;

procedure TForm3.ListBox1Click(Sender: TObject);
begin
  try
    selobj:=ListBox1.ItemIndex;
    tempobj:=objects[selobj];
    ShowSObjInfo;
  except end;
end;

end.
