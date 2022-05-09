unit ufarseer2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ExtDlgs, Math, Vcl.ComCtrls, JPeg, PNGImage, ComObj;

type

  //������ �������
  mobject=record
    objtp:integer;
    //4 - dot, 5 - line, 6 - rectangle, 7 - ellipse
    x1,y1,x2,y2:real; //coords
    color1,color2:TColor;//colors
    p1,p2:integer; //additional parameters
  end;

  //������ ���������
  clickdot = record
    x,y:real;
  end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Panel2: TPanel;
    Memo1: TMemo;
    Timer1: TTimer;
    Panel3: TPanel;
    Image2: TImage;
    Image3: TImage;
    SaveDialog1: TSaveDialog;
    SavePictureDialog1: TSavePictureDialog;
    OpenDialog1: TOpenDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    ColorDialog1: TColorDialog;
    ColorDialog2: TColorDialog;
    Panel4: TPanel;
    Image1: TImage;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    StatusBar1: TStatusBar;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    Memo2: TMemo;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    Panel5: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    procedure showinputform(msg:string;
                            usedef,up,down:boolean;def1,def2,
                            ttl1,ttl2:string);
    procedure getinputformdata;
    procedure rendervisiblefragment;
    procedure drawimageoverlay;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton4Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure SaveProject(fn:string);
    procedure LoadProject(fn:string);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseLeave(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  shiftd:boolean;
  skx,sky:real; //���������� ������������ ����
  pic:TBitmap; //opened image
  bigcanvas:TBitmap; //full render of picture and objects
  viscanvas:TBitmap; //copy of visible part of bigcanvas
  clickdots,sizedots:array of clickdot; //������� ���������
  objects:array of mobject; //������ ��������
  clrf,clrbg:TColor; //����� ���� � �����
  tempobj:mobject; //��������� ������
  selobj:integer; //������ ���������� �������


  mode,phase:integer; //������� ������ � ���� ������ ���������

  w,h,cx,cy:integer; //width,height,camera coords, scale
  scl:real;
  canrender:boolean=false; //if rendering is allowed
  mx,my,lmx,lmy,mcx,mcy,lmcx,lmcy:integer; //���������� �������
  rmx,rmy:real;

  wd:boolean=false; //�������� ������

  contrast:Integer=100; //������� ������ ��� �������� �������

implementation

{$R *.dfm}

uses uinput, utools, ustats;

function dpix(c1,c2:real):real;
begin
  //������� �������� ����� �������� ������� �� ���
  result:=Abs(c2-c1);
end;

function getdist(dx,dy,sx,sy:real):real;
//������� ���������� (����������) ��� ���� �������� ��������
begin
  result:=sqrt(sqr(dx*sx)+sqr(dy*sy));
end;

function autogetdist(x1,y1,x2,y2:integer):real;
//������� ���������� �� ������ ������������� �������
var a,b,fx,fy,fx0,fy0:real;
    x1x2:boolean;
    ox1,ox2,oy1,oy2:real;
    wx1,wy1,wx2,wy2:integer;
    dr,dg,db,dcavg:integer;
    clr1,clr2:TColor;
    detx:array of integer;
    dety:array of integer;
begin

  if x1<>x2 then
  begin
    if x1>x2 then
    begin
      wx1:=x2;
      wx2:=x1;
      wy1:=y2;
      wy2:=y1;
    end;
    if x1<x2 then
    begin
      wx1:=x1;
      wx2:=x2;
      wy1:=y1;
      wy2:=y2;
    end;
  end;

  if wx1=wx2 then
  begin
    a:=(wx2-wx1)/(wy2-wy1);
    b:=(wx1-(wx2-wx1)/(wy2-wy1)*wy1);
    x1x2:=true;
  end
  else
  begin
    a:=(wy2-wy1)/(wx2-wx1);
    b:=(wy1-(wy2-wy1)/(wx2-wx1)*wx1);
    x1x2:=false;
  end;


  with pic.Canvas do
  begin

    clr1:=Pixels[wx1,wy1];
    clr2:=Pixels[wx1,wy1];
    if not x1x2 then
    begin
      fx:=wx1;
      fy:=wy1;
    end
    else
    begin
      fx:=wy1;
      fy:=wx1;
    end;

    setlength(detx,0);
    setlength(dety,0);

    while ((fx<wx2) and (x1x2=false)) or ((fx<wy2) and (x1x2=true)) do
    begin
      clr2:=clr1;
      fy:=a*fx+b;
      clr1:=Pixels[round(fx),round(fy)];
      dr:=abs(GetRValue(clr1)-GetRValue(clr2));
      dg:=abs(GetGValue(clr1)-GetGValue(clr2));
      db:=abs(GetBValue(clr1)-GetBValue(clr2));
      dcavg:=round((dr+dg+db)/3);
      if (dcavg>=contrast) then
      begin
        setlength(detx,length(detx)+1);
        setlength(dety,length(dety)+1);
        detx[length(detx)-1]:=round(fx);
        dety[length(dety)-1]:=round(fy);

        setlength(clickdots,length(clickdots)+1);
        clickdots[length(clickdots)-1].x:=round(fx);
        clickdots[length(clickdots)-1].y:=round(fy);

      end;
      fx:=fx+1;
    end;

  end;

  ox1:=detx[0];
  oy1:=dety[0];
  ox2:=detx[length(detx)-1];
  oy2:=dety[length(dety)-1];

  result:=getdist(ox1-ox2,oy1-oy2,skx,sky);

end;

function getangle3(a,b,c:clickdot):real;
//������� ���� �� ���� ������
var x1,x2,y1,y2,d1,d2:real;
begin
  x1:=a.x-b.x;
  x2:=c.x-b.x;
  y1:=a.y-b.y;
  y2:=c.y-b.y;
  d1:=sqrt(x1*x1+y1*y1);
  d2:=sqrt(x2*x2+y2*y2);
  result:=arccos((x1*x2+y1*y2)/(d1*d2));
end;

procedure LoadPic(fn:string);
var ext:string; exti:integer;
    prepicpng:TPngImage;
    prepicjpg:TJPEGImage;
begin
  //��������� ����������� �� ������� ����� ����� ��������/������
  freeandnil(pic); pic:=TBitmap.Create;
  ext:=extractfileext(fn);
  if ext='.bmp' then exti:=0;
  if ext='.jpg' then exti:=1;
  if ext='.png' then exti:=2;
  case exti of
  0:begin
      pic.LoadFromFile(fn);
    end;
  1:begin
      prepicjpg:=TJPEGImage.Create;
      prepicjpg.LoadFromFile(fn);
      pic.Width:=prepicjpg.Width;
      pic.Height:=prepicjpg.Height;
      pic.Canvas.CopyRect(rect(0,0,pic.Width,pic.Height),prepicjpg.Canvas,
                          rect(0,0,pic.Width,pic.Height));
      freeandnil(prepicjpg);
    end;
  2:begin
      prepicpng:=TPngImage.Create;
      prepicpng.LoadFromFile(fn);
      pic.Width:=prepicpng.Width;
      pic.Height:=prepicpng.Height;
      pic.Canvas.CopyRect(rect(0,0,pic.Width,pic.Height),prepicpng.Canvas,
                          rect(0,0,pic.Width,pic.Height));
      freeandnil(prepicpng);
    end;
  end;

  canrender:=true;
end;

procedure formbigcanvas;
var i,cl:integer;
begin
  {��� ��������� ������ ������ ���� ����� ����������� ��� �������� ��
  ������� � ����������, ���� � ����� ������ ����� ���� �������
  ������ ��� ��������}

  //����������� �������� ��������� ����� � �������� ��������
  FreeAndNil(bigcanvas);
  bigcanvas:=TBitmap.Create;
  bigcanvas.Width:=pic.Width;
  bigcanvas.Height:=pic.Height;
  w:=bigcanvas.Width;
  h:=bigcanvas.Height;
  bigcanvas.Canvas.CopyRect(rect(0,0,w,h),pic.Canvas,rect(0,0,w,h));

  //������ ����� ������, ���� ��� ����������
  cl:=length(clickdots);
  if cl>0 then
  for i:=0 to (cl-1) do
  with bigcanvas.Canvas do
  begin
    pen.Color:=clRed;
    Brush.Color:=clLime;
    Ellipse(round(clickdots[i].x)-2,round(clickdots[i].y)-2,
            round(clickdots[i].x)+2,round(clickdots[i].y)+2);
  end;

  //������ ����� ��������, ���� ��� ����������
  cl:=length(sizedots);
  if cl>0 then
  for i:=0 to (cl-1) do
  with bigcanvas.Canvas do
  begin
    pen.Color:=clYellow;
    Brush.Color:=clBlue;
    Ellipse(round(sizedots[i].x)-2,round(sizedots[i].y)-2,
            round(sizedots[i].x)+2,round(sizedots[i].y)+2);
  end;

  //������ �������
  cl:=length(objects);
  if cl>0 then
  for i:=0 to (cl-1) do
  with bigcanvas.Canvas do
  begin
    //������ ��������� � ��������� ������ ����� ������
    if (form3.visible=true) and (selobj=i) then
    begin
      pen.Width:=3;
      brush.Style:=bsFDiagonal;
    end
    else
    begin
      pen.Width:=1;
      brush.Style:=bsSolid;
    end;
    //������������� ����� �������
    pen.Color:=objects[i].color1;
    Brush.Color:=objects[i].color2;

    //������ ������ � ����������� �� �������������� ����
    if not (((mode=4) or (mode=5) or (mode=6) or (mode=7)) and
           (i=length(objects)-1) and (phase>0)) then
    {��� ������� ���������� ���� �� ������������� ������� ������, ���� ���
    ������������ �� ���������, ����� ����� ����� �� ���������}
    begin
      if objects[i].objtp=4 then
        Ellipse(round(objects[i].x1)-2,round(objects[i].y1)-2,
                round(objects[i].x1)+2,round(objects[i].y1)+2);
      if objects[i].objtp=5 then
      begin
        moveto(round(objects[i].x1),round(objects[i].y1));
        lineto(round(objects[i].x2),round(objects[i].y2));
      end;
      if objects[i].objtp=6 then
      begin
        rectangle(round(objects[i].x1),round(objects[i].y1),
                  round(objects[i].x2),round(objects[i].y2));
      end;
      if objects[i].objtp=7 then
      begin
        ellipse(round(objects[i].x1),round(objects[i].y1),
                round(objects[i].x2),round(objects[i].y2));
      end;
    end;
  end;

end;

procedure tform1.rendervisiblefragment;
begin
  {��� ��������� �������� ��� ����� ������ �������, ������� ��������
  � ���� ���������}
  with image1.Canvas do
  begin
    pen.Color:=clwhite;
    Brush.Color:=clwhite;
    rectangle(0,0,image1.Width,Image1.Height);
    if canrender=true then
    begin
      formbigcanvas;
      CopyRect(rect(0,0,image1.Width,image1.height),bigcanvas.canvas,
               rect(cx,cy,round((cx+image1.Width/scl)),
                          round((cy+image1.Height/scl))));
    end;
  end;
end;

procedure tform1.drawimageoverlay;
var cl,i:integer;
begin
  {��� ��������� ������ ������������ �������� - ������������ ��������,
  ����������� ��� ��������}
  with image1.canvas do
  begin
    //������ �����������
    pen.color:=clLime;
    moveto(mx,0); lineto(mx,image1.height);
    moveto(0,my); lineto(image1.width,my);

    //������ �������������� �����
    if (mode=1) and (phase=1) or (phase=4) then
    with Image1.Canvas do
    begin
      pen.Color:=clBlue;
      moveto(mcx,mcy); lineto(mx,my);
    end;

    //������ �������������� �����
    if ((mode=2) or (mode=8)) and (phase=1) then
    with Image1.Canvas do
    begin
      pen.Color:=clBlue;
      moveto(mcx,mcy); lineto(mx,my);
    end;

    //������ �������������� �����
    if (mode=3) and (phase=1) or (phase=2) then
    with Image1.Canvas do
    begin
      pen.Color:=clBlue;
      moveto(mcx,mcy); lineto(mx,my);
    end;

    //������ ������ ��������
    if (mode=5) and (phase=1) then
    with Image1.Canvas do
    begin
      pen.Color:=clrf;
      brush.Style:=bsClear;
      moveto(mcx,mcy); lineto(mx,my);
      brush.Style:=bsSolid;
    end;

    if (mode=6) and (phase=1) then
    with Image1.Canvas do
    begin
      pen.Color:=clrf;
      brush.Style:=bsClear;
      rectangle(mcx,mcy,mx,my);
      brush.Style:=bsSolid;
    end;

    if (mode=7) and (phase=1) then
    with Image1.Canvas do
    begin
      pen.Color:=clrf;
      brush.Style:=bsClear;
      ellipse(mcx,mcy,mx,my);
      brush.Style:=bsSolid;
    end;
  end;
end;

function calcrmc(mc,cscl,rscl:real;cd:integer):real;
//������������ ���������� ����� � �������� �������� ���������
//mc - ���������� �������. cscl - ������� ������� ��������.
//rscl - ������� ������ ��������. cd - �������� ������ (��� ��� ����� ���)
begin
  result:=cd*rscl+(mc*rscl)/cscl;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
//������ ��������� ������ ��������� ������
  cx:=ScrollBar1.Position;
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
//������ ��������� ������ ��������� ������
  cy:=ScrollBar2.Position;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //������ �������� �������� ���������
  scl:=1;
  skx:=1;
  sky:=1;
  //������ �������� �����
  clrf:=clBlack;
  clrbg:=clWhite;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_SHIFT then shiftd:=true;
end;


procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key=VK_SHIFT then shiftd:=false;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
//��������������� ����� ������� �� ��������� ����������
  Image1.Picture.Bitmap.Width:= Image1.Width;
  Image1.Picture.Bitmap.Height:=Image1.Height;
end;

procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
//���������� ����� � ����
  mode:=0; phase:=0;
end;

procedure TForm1.SpeedButton11Click(Sender: TObject);
begin
  mode:=4;
  phase:=0;
  SetLength(clickdots,0);
end;

procedure TForm1.SpeedButton12Click(Sender: TObject);
begin
  mode:=5;
  phase:=0;
  SetLength(clickdots,0);
end;

procedure TForm1.SpeedButton13Click(Sender: TObject);
begin
  mode:=6;
  phase:=0;
  SetLength(clickdots,0);
end;

procedure TForm1.SpeedButton14Click(Sender: TObject);
begin
  mode:=7;
  phase:=0;
  SetLength(clickdots,0);
end;

procedure TForm1.SpeedButton15Click(Sender: TObject);
begin
  form3.Show;
end;

procedure TForm1.SpeedButton16Click(Sender: TObject);
var
  ovExcelApp: OleVariant;
  ovExcelWorkbook: OleVariant;
  ovWS: OleVariant;
  ovRange: OleVariant;
  k,i,n,acl,cl:integer;
begin
  ovExcelApp := CreateOleObject('Excel.Application'); //If Excel isnt installed will raise an exception
  cl:=strtoint(Edit1.Text);
  try
    ovExcelApp.Visible := true;
    ovExcelWorkbook   := ovExcelApp.WorkBooks.Add;
    ovWS := ovExcelWorkbook.Worksheets.Item[1]; // go to first worksheet
    ovWS.Activate;
    ovWS.Select;
    n:=Memo1.Lines.Count;
    k:=-1;
    if CheckBox1.Checked=true then
    begin
      for acl:=1 to cl do
      begin
        for i:=1 to round(n/cl) do
        begin
          inc(k);
          ovExcelApp.WorkBooks[1].WorkSheets[1].Cells[i, acl] := memo1.Lines[k];
        end;
      end;
    end
    else
    begin
      for i:=1 to round(n/cl) do
      begin
        for acl:=1 to cl do
        begin
          inc(k);
          ovExcelApp.WorkBooks[1].WorkSheets[1].Cells[i, acl] := memo1.Lines[k];
        end;
      end;
    end;
  finally
    //ovExcelWorkbook.Close(SaveChanges := False);
    ovWS := Unassigned;
    ovExcelWorkbook := Unassigned;
    ovExcelApp := Unassigned;
  end;

end;

procedure TForm1.SpeedButton17Click(Sender: TObject);
begin
  form4.show;
end;

procedure TForm1.SpeedButton18Click(Sender: TObject);
begin
  mode:=8;
  phase:=0;
  SetLength(clickdots,0);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  mode:=1;
  phase:=0;
  SetLength(clickdots,0);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
//��������� ������������� �����
  if canrender=true then
  begin
    if SavePictureDialog1.Execute then
      bigcanvas.SaveToFile(SavePictureDialog1.FileName);
  end
  else
  begin
    MessageDlg('����������� �� ���������, ���������� ����������.',
               mtError,[mbOk],0);
  end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then SaveProject(savedialog1.FileName);
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  if form1.OpenPictureDialog1.Execute then
  begin
    loadpic(OpenPictureDialog1.FileName);
  end;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  if OpenDialog1.Execute then LoadProject(opendialog1.FileName);
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  mode:=2;
  phase:=0;
  SetLength(clickdots,0);
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
  mode:=3;
  phase:=0;
  SetLength(clickdots,0);
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  if scl>1 then
  begin
    scl:=scl-1;
  end;
  if scl <=1 then
  begin
    scl:=scl-0.1; if scl<0.1 then scl:=0.1;
  end;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
begin
  if scl<1 then scl:=scl+0.1;
  if scl>=1 then scl:=scl+1;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var dstr:real;
    mstr:string;
begin
  {������ ���������� �������������� ����� � ��� ��� � 100 ��. ����� ��
  ����������� ������������� ������ ������� �� ���� ������, �, � ���������
  �������, ����������� ������� ������������ ��� ��� ������� ������}
  rendervisiblefragment;
  drawimageoverlay;

  StatusBar1.Panels[0].Text:='�������: '+inttostr(round(scl*100))+'%';

  if canrender=true then
  begin
    ScrollBar1.Max:=bigcanvas.Width;
    ScrollBar2.Max:=bigcanvas.Height;
  end;

  //mode switcher
  if mode=1 then
  begin
    if phase=0 then
    begin
      StatusBar1.Panels[1].Text:=
      '������ �������� �� ��� �. ������� ������ �����.'
    end;
    if phase=1 then
    begin
      StatusBar1.Panels[1].Text:=
      '������ �������� �� ��� �. ������� ������ �����.'
    end;
    if phase=2 then
    begin
      StatusBar1.Panels[1].Text:='������ �������� �� ��� �. ������� ������.';
      showinputform('������� �������� ����� ������� �� ��� X',
                    false,true,false,'','','X','');
    end;
    if phase=3 then
    begin
      StatusBar1.Panels[1].Text:=
      '������ �������� �� ��� Y. ������� ������ �����.'
    end;
    if phase=4 then
    begin
      StatusBar1.Panels[1].Text:=
      '������ �������� �� ��� Y. ������� ������ �����.'
    end;
    if phase=5 then
    begin
      StatusBar1.Panels[1].Text:='������ �������� �� ��� Y. ������� ������.';
      showinputform('������� �������� ����� ������� �� ��� Y',
                    false,true,false,'','','Y','');
    end;
    if phase=6 then
    begin
      mode:=0;
      phase:=0;
      StatusBar1.Panels[1].Text:='���������� ������������ �����������';
    end;
  end;

  if mode=2 then
  begin
    if phase=0 then
    begin
      StatusBar1.Panels[1].Text:='��������� �����. ������� ������ �����.'
    end;
    if phase=1 then
    begin
      StatusBar1.Panels[1].Text:='��������� �����. ������� ������ �����.'
    end;
    if phase=2 then
    begin
      mode:=2;
      phase:=0;
      dstr:=getdist(dpix(round(clickdots[0].x),round(clickdots[1].x)),
                    dpix(round(clickdots[0].y),round(clickdots[1].y)),
                    skx,sky);
      Memo1.Lines.Add(floattostr(dstr));
      SetLength(clickdots,0);
    end;
  end;

  if mode=3 then
  begin
    if phase=0 then
    begin
      StatusBar1.Panels[1].Text:='��������� ����. ������� ������ �����.'
    end;
    if phase=1 then
    begin
      StatusBar1.Panels[1].Text:='��������� ����. ������� ������ �����.'
    end;
    if phase=2 then
    begin
      StatusBar1.Panels[1].Text:='��������� ����. ������� ������ �����.'
    end;
    if phase=3 then
    begin
      mode:=3;
      phase:=0;
      dstr:=getangle3(clickdots[0],clickdots[1],clickdots[2]);
      Memo1.Lines.Add(floattostr(dstr*180/pi));
      SetLength(clickdots,0);
    end;
  end;

  if mode=4 then
  begin
    if phase=0 then
    begin
      StatusBar1.Panels[1].Text:='��������� �����. ������� ����������.'
    end;
    if phase=1 then
    begin
      phase:=0;
    end;
  end;

  if (mode=5) or (mode=6) or (mode=7) then
  begin
    case mode of
    5:mstr:='������� ������';
    6:mstr:='��������������';
    7:mstr:='�������';
    end;
    if phase=0 then
    begin
      StatusBar1.Panels[1].Text:='��������� '+mstr+
                                 '. ������� ���������� ������ �����.'
    end;
    if phase=1 then
    begin
      StatusBar1.Panels[1].Text:='��������� '+mstr+
                                 '. ������� ���������� ������ �����.'
    end;
    if phase=2 then
    begin
      phase:=0;
    end;
  end;

  if mode=8 then
  begin
    if phase=0 then
    begin
      StatusBar1.Panels[1].Text:='��������������� ��������� �����. ������� ������ �����.'
    end;
    if phase=1 then
    begin
      StatusBar1.Panels[1].Text:='�������������� ��������� �����. ������� ������ �����.'
    end;
    if phase=2 then
    begin
      mode:=0;
      phase:=0;
      dstr:=autogetdist(round(clickdots[0].x),round(clickdots[0].y),
                        round(clickdots[1].x),round(clickdots[1].y));
      Memo1.Lines.Add(floattostr(dstr));
      SetLength(clickdots,0);
    end;
  end;

  //������ ���� �������� � ������ �����, ���������� �� ����� �����
  with image2.Canvas do
  begin
    pen.Color:=clblack;
    brush.Color:=clrf;
    rectangle(0,0,image2.Width,image2.Height);
  end;
  with image3.Canvas do
  begin
    pen.Color:=clblack;
    brush.Color:=clrbg;
    rectangle(0,0,image3.Width,image3.Height);
  end;

end;

procedure tform1.showinputform(msg:string;
                               usedef,up,down:boolean;def1,def2,
                               ttl1,ttl2:string);
begin
  {��������� ������� �� ����� ����� ������ ������, ���� ������� ��� ��
  ������������ �� ������. ���������� �������� ��: ��������� ���������, �����
  �������� �� ���������, ���������� ������� ����, ���������� ������� ����
  �������� � ����� �� ���������, ������� �����}
  if form2.Visible=false then
  with form2 do
  begin
    Label1.Caption:=msg;
    LabeledEdit1.Enabled:=up;
    LabeledEdit2.Enabled:=down;
    LabeledEdit1.EditLabel.Caption:=ttl1;
    LabeledEdit2.EditLabel.Caption:=ttl2;
    if usedef=true then
    begin
      LabeledEdit1.Text:=def1;
      LabeledEdit1.Text:=def2;
    end;
    Form2.Show;
  end;
end;

procedure tform1.getinputformdata;
var s1,s2:string;
    d1,d2:real;
begin
  {��������� ��������� ���������� �� ����� ����� ����� � � ����������� ��
  ������ � ���� ��������� �� ��� ���� ��������}
  s1:=Form2.LabeledEdit1.Text;
  s2:=Form2.LabeledEdit2.Text;
  case mode of
  1:begin
      if phase=2 then
      begin
        d1:=dpix(clickdots[0].x,clickdots[1].x);
        d2:=strtofloat(s1);
        skx:=d2/d1;
        phase:=phase+1;
      end;
      if phase=5 then
      begin
        d1:=dpix(clickdots[2].y,clickdots[3].y);
        d2:=strtofloat(s1);
        sky:=d2/d1;
        phase:=phase+1;
      end;
    end;
  end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button=mbRight then
  begin
    wd:=true;
  end;
end;

procedure TForm1.Image1MouseLeave(Sender: TObject);
begin
  wd:=false;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var dx,dy:integer;
begin
  //���������� ���������� ������� � ��������� ������
  lmx:=mx;
  lmy:=my;
  mx:=x;
  my:=y;
  if (ssShift in Shift) then
  begin
    if abs(dpix(mx,mcx))>abs(dpix(my,mcy)) then
    begin
      my:=mcy;
    end
    else
    begin
      mx:=mcx;
    end;
  end;

  //����������� ����������� ��� ������� �������� ����
  if (wd=true) then
  begin
    dx:=lmx-mx;
    dy:=lmy-my;
    ScrollBar1.Position:=ScrollBar1.Position+dx;
    ScrollBar2.Position:=ScrollBar2.Position+dy;
  end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var fcome:boolean;
begin
  {�������� ���������, �������������� ������ ����, ������������ ��������
  ��������� � ����������� ��� ������ �������� � ����������� �� ������
  � ����}
  //���������� ������������� ����������
  fcome:=true;

  //���������� ���������� ������� � ������ ������
  if button=mbleft then
  begin
    lmcx:=mcx;
    lmcy:=mcy;
    mcx:=x;
    mcy:=y;
    if (ssShift in Shift) then
    begin
      if abs(dpix(mcx,lmcx))>abs(dpix(mcy,lmcy)) then
      begin
        mcy:=lmcy;
      end
      else
      begin
        mcx:=lmcx;
      end;
    end;

    //������������ ��������� ����� (� ����������� �� ������)
    if mode=1 then
    begin
      if (phase=0) or (phase=1) or (phase=3) or (phase=4) then
      begin
        setlength(clickdots,length(clickdots)+1);
        clickdots[length(clickdots)-1].x:=mcx/scl+cx;
        clickdots[length(clickdots)-1].y:=mcy/scl+cy;
        phase:=phase+1;
      end;
    end;

    if (mode=2) or (mode=8) then
    begin
      if (phase=0) or (phase=1) then
      begin
        setlength(clickdots,length(clickdots)+1);
        clickdots[length(clickdots)-1].x:=mcx/scl+cx;
        clickdots[length(clickdots)-1].y:=mcy/scl+cy;
        setlength(sizedots,length(sizedots)+1);
        sizedots[length(sizedots)-1].x:=mcx/scl+cx;
        sizedots[length(sizedots)-1].y:=mcy/scl+cy;
        phase:=phase+1;
      end;
    end;

    if mode=3 then
    begin
      if (phase=0) or (phase=1) or (phase=2) then
      begin
        setlength(clickdots,length(clickdots)+1);
        clickdots[length(clickdots)-1].x:=mcx/scl+cx;
        clickdots[length(clickdots)-1].y:=mcy/scl+cy;
        setlength(sizedots,length(sizedots)+1);
        sizedots[length(sizedots)-1].x:=mcx/scl+cx;
        sizedots[length(sizedots)-1].y:=mcy/scl+cy;
        phase:=phase+1;
      end;
    end;

    if mode=4 then
    begin
      if (phase=0) then
      begin
        setlength(clickdots,length(clickdots)+1);
        setlength(objects,length(objects)+1);
        objects[length(objects)-1].objtp:=mode;
        objects[length(objects)-1].x1:=mcx/scl+cx;
        objects[length(objects)-1].y1:=mcy/scl+cy;
        phase:=phase+1;
      end;
    end;

    if (mode=5) or (mode=6) or (mode=7) then
    //��� �����, ����� � �������������� ���������� ������ ���
    begin
      if (phase=0) and (fcome=true) then
      begin
        fcome:=false;
        setlength(objects,length(objects)+1);
        objects[length(objects)-1].objtp:=mode;
        objects[length(objects)-1].x1:=mcx/scl+cx;
        objects[length(objects)-1].y1:=mcy/scl+cy;
        objects[length(objects)-1].color1:=clrf;
        objects[length(objects)-1].color2:=clrbg;
        phase:=phase+1;
      end;
      if (phase=1) and (fcome=true) then
      begin
        fcome:=false;
        objects[length(objects)-1].x2:=mcx/scl+cx;
        objects[length(objects)-1].y2:=mcy/scl+cy;
        phase:=phase+1;
      end;
    end;
  end;

  if Button=mbRight then
  begin
    wd:=false;
  end;

end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    clrf:=ColorDialog1.Color;
  end;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
  if ColorDialog2.Execute then
  begin
    clrbg:=ColorDialog2.Color;
  end;
end;

procedure TForm1.SaveProject(fn:string);
var i,k:integer;
begin
  //��������� ��� ������ � ����
  memo2.Lines.Clear;
  k:=length(sizedots);
  Memo2.Lines.Add(OpenPictureDialog1.Filename);
  if k>0 then
  for i:=0 to (k-1) do
  begin
    memo2.Lines.Add(floattostr(sizedots[i].x));
    memo2.Lines.Add(floattostr(sizedots[i].y));
  end;
  memo2.Lines.Add('@');
  k:=length(objects);
  if k>0 then
  for i:=0 to (k-1) do
  begin
    memo2.Lines.Add(inttostr(objects[i].objtp));
    memo2.Lines.Add(floattostr(objects[i].x1));
    memo2.Lines.Add(floattostr(objects[i].y1));
    memo2.Lines.Add(floattostr(objects[i].x2));
    memo2.Lines.Add(floattostr(objects[i].y2));
    memo2.Lines.Add(inttostr(objects[i].p1));
    memo2.Lines.Add(inttostr(objects[i].p2));
    memo2.Lines.Add(ColorToString(objects[i].color1));
    memo2.Lines.Add(ColorToString(objects[i].color2));
  end;
  memo2.Lines.SaveToFile(fn);
end;

procedure TForm1.LoadProject(fn:string);
var i,j,k:integer;
    ts:string;
    hassd:boolean;
begin
  //��������� ��� ������ �� �����
  memo2.Lines.LoadFromFile(fn);
  if memo2.Lines[1]='@' then hassd:=false else hassd:=true;
  k:=0;
  try
    LoadPic(memo2.Lines[k]);
    canrender:=true;
  except
    MessageDlg('������ ��� �������� �����������!'+
               '��������� ��� ������� ��� ����������� �������� �����.',
               mtError,[mbOK],0);
  end;
  inc(k);
  setlength(sizedots,0);
  setlength(objects,0);
  //������ ������ ��������� �����
  if hassd=true then
  begin
    repeat
      ts:=memo2.Lines[k];
      if ts<>'@' then
      begin
        setlength(sizedots,length(sizedots)+1);
        sizedots[length(sizedots)-1].x:=strtofloat(memo2.Lines[k]);
        sizedots[length(sizedots)-1].y:=strtofloat(memo2.Lines[k+1]);
        k:=k+2;
      end;
    until (ts='@');
    inc(k);
  end
  else inc(k);
  if ((memo2.Lines.Count-k)>=8) then
  repeat
    setlength(objects,length(objects)+1);
    objects[length(objects)-1].objtp:=strtoint(memo2.Lines[k]);
    inc(k);
    objects[length(objects)-1].x1:=strtofloat(memo2.Lines[k]);
    inc(k);
    objects[length(objects)-1].y1:=strtofloat(memo2.Lines[k]);
    inc(k);
    objects[length(objects)-1].x2:=strtofloat(memo2.Lines[k]);
    inc(k);
    objects[length(objects)-1].y2:=strtofloat(memo2.Lines[k]);
    inc(k);
    objects[length(objects)-1].p1:=strtoint(memo2.Lines[k]);
    inc(k);
    objects[length(objects)-1].p2:=strtoint(memo2.Lines[k]);
    inc(k);
    objects[length(objects)-1].color1:=stringtocolor(memo2.Lines[k]);
    inc(k);
    objects[length(objects)-1].color2:=stringtocolor(memo2.Lines[k]);
    inc(k);
  until(k>=memo2.Lines.Count)
end;


end.