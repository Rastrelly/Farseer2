unit ustats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Vcl.StdCtrls,
  Vcl.ExtCtrls, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.TeeFunci;

type

  parset=record //����������� ����� ���������� �������
    name,text,norm:string;
  end;

  TForm4 = class(TForm)
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Chart2: TChart;
    LineSeries1: TBarSeries;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Edit3: TEdit;
    Button4: TButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel2: TPanel;
    Memo2: TMemo;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Series3: TLineSeries;
    function extr(a:array of real;getmax:boolean):real;
    function getz(n,p:real):real;
    procedure readxi;

    procedure BuildChart;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  rsj,xi,pp:array of real;
  sj:array of integer;
  min,max:real;
  norm:real;
  parsets:array of parset;
  ap,az:array of real;

implementation

{$R *.dfm}

uses ufarseer2;

function tform4.extr(a:array of real;getmax:boolean):real;
var k:integer; i:integer; ex:real;
begin
  k:=length(a);
  //form1.memo2.lines.add('Comparison array length: '+inttostr(k));
  ex:=a[0];
  for i:=0 to (k-1) do
  begin
    if getmax=true then
    begin
      //form1.memo2.lines.add('Checking if '+floattostr(a[i])+'>'+floattostr(ex));
      if a[i]>ex then ex:=a[i];
    end
    else
    begin
      //form1.memo2.lines.add('Checking if '+floattostr(a[i])+'<'+floattostr(ex));
      if a[i]<ex then ex:=a[i];
    end;
  end;
  result:=ex;
end;

function tform4.getz(n,p:real):real;
var k:integer;
    z:real;
    s:string;
    F:  TextFile;
    i:integer;
begin

  z:=0;

  //���� �������� ���������
  if (n<20) and fileexists(extractfiledir(application.ExeName)+
                           '\tlist_'+inttostr(round(n))+'.txt') then
  begin
    AssignFile(F, extractfiledir(application.ExeName)+
                  '\tlist_'+inttostr(round(n))+'.txt');
  end
  else
    AssignFile(F, extractfiledir(application.ExeName)+'\tlist.txt');

  Reset(F);

  i:=0;
  setlength(ap,0);
  setlength(az,0);

  //��������� ������ �� ����������
  while (not EOF(F)) do
  begin
    if (i mod 2 =0) then
    begin
      setlength(ap,length(ap)+1);
      ReadLn(F, s);
      ap[length(ap)-1]:=strtofloat(s);
    end
    else
    begin
      setlength(az,length(az)+1);
      ReadLn(F, s);
      az[length(az)-1]:=strtofloat(s);
    end;
    i:=i+1;
  end;

  //�� �������� �������� �����. ����������� ���� �����������
  k:=length(ap)-1;
  i:=0;
  if k>-1 then
  repeat
    if (p>=ap[i]) then
    begin
      z:=az[i];
    end;
    inc(i);
  until (p>=ap[i]) or (i>k);

  CloseFile(F);
  result:=z;

end;

procedure tform4.readxi;
var i,e,n:integer;
    sum,sumsq:real;
    xf,sig,siga,z,p,b,a,r,aa:real;
    arlist:string;
    ii,jj:integer;
    kmin,kmax:real;
begin
  //������ ����� ������
  e:=form1.memo1.Lines.Count-1;
  n:=e+1;
  //���������� �������� -  ����� � ��������� �������� �����
  setlength(xi,0);
  setlength(xi,n);
  //�������� �����
  sum:=0;

  //���������� ������
  arlist:='�������� ������: ';

  //��������� ������ ���������� �������
  for i:=0 to e do
  begin
    xi[i]:=strtofloat(form1.memo1.lines[i]);
    sum:=sum+xi[i];
    arlist:=arlist+floattostr(xi[i])+'; ';
  end;

  //������� ��������
  xf:=sum/n;

  Chart1.SeriesList[1].AddXY(strtofloat(edit1.Text),xf);
  Chart1.SeriesList[1].AddXY(strtofloat(edit2.Text),xf);

  //������ ���������� ��������
  norm:=strtofloat(edit3.text);

  //�������������� ������� (������� � �.�.)
  chart2.SeriesList[0].Clear;
  chart2.SeriesList[1].Clear;

  memo2.Lines.add(arlist);

  //��������� ������������ �����������
  sumsq:=0;
  for i:=0 to e do
  begin
    sumsq:=sumsq+sqr(xi[i]-xf);
  end;
  sig:=sqrt(sumsq/e);

  //..������������������ �����������
  siga:=sig/sqrt(n);

  //��������� ������ �� �����������
  p:=strtofloat(edit4.text);
  r:=strtofloat(edit5.text);

  //������ �������� ��������� (��. ������� getz)
  z:=getz(n,p);
  memo2.lines.add('����: '+floattostrf(xf,ffNumber,8,2)+'+-'+floattostrf(z*siga,ffNumber,8,2));

  //������� ������� � ��������
  min:=extr(xi,false);
  max:=extr(xi,true);
  memo2.lines.add('���='+floattostrf(min,ffNumber,8,2)+' ����='+floattostrf(max,ffNumber,8,2));

  //������� �������� ��������
  b:=max-min;

  //������� ������ ������������
  a:=b/r;


  aa:=min;
  jj:=round(r);

  setlength(sj,jj);
  setlength(rsj,jj);
  setlength(pp,jj);

  memo2.lines.add('b='+floattostrf(b,ffNumber,8,2)+' a='+floattostrf(a,ffNumber,8,2));

  //��������� �������� �� ���������� ��� ������ �� �����������
  //� ���� ���� ���������
  for ii:=0 to (jj-1) do sj[ii]:=0;
  for ii:=0 to (jj-1) do
  begin
    memo2.Lines.add(inttostr(ii)+') aa='+floattostr(aa));
    memo2.lines.add('������������ ������ '+floattostrf((aa+a*ii),ffNumber,8,2)+'...'+floattostrf((aa+a*(ii+1)),ffNumber,8,2));
    for i:=0 to e do
    begin
      if (xi[i]>=(aa+a*ii)) and (xi[i]<(aa+a*(ii+1))) then
      begin
        sj[ii]:=sj[ii]+1;
        Memo2.Lines.Add('��������� '+floattostr(xi[i])+' � ������ '+floattostrf(aa+a*ii,ffNumber,8,2)+
                        '...'+floattostrf(aa+a*(ii+1),ffNumber,8,2));
      end;
    end;
  end;

  jj:=length(sj);


  //������������ ����� �� ���������������� ���������
  kmin:=(max-min)/2*(-1);
  kmax:=(max-min)/2;

  for i:=0 to jj-1 do
  begin
    rsj[i]:=sj[i]/(n*a);

    pp[i]:=( 1/(sig*sqrt(2*3.14)) )*exp( -sqr(kmin+a*i+(a/2))/(2*sqr(sig)) );

  end;

  //������� ������ ��� ���������� � ����������������� �������
  chart2.SeriesList[0].Clear;
  chart2.SeriesList[0].Clear;
  for i:=0 to (jj-1) do
  begin
    chart2.SeriesList[0].AddXY((min+a*i+(a/2)),rsj[i],inttostr(sj[i]),clBlue);
    Chart2.SeriesList[0].TreatNulls:=tnIgnore;
    chart2.SeriesList[1].AddXY((min+a*i+(a/2)),pp[i],inttostr(sj[i]),clRed);
  end;

end;

procedure TForm4.BuildChart;
var i:integer;
    x,y,xmin,xmax:real;
    dx:real;
begin
  //������ �������
  Chart1.SeriesList[0].Clear;

  xmin:=strtofloat(edit1.Text);
  xmax:=strtofloat(edit2.Text);

  dx:=(xmax-xmin)/form1.memo1.Lines.Count;

  for i:=0 to form1.memo1.lines.count-1 do
  begin
    Chart1.SeriesList[0].AddXY(xmin+dx*i,strtofloat(form1.memo1.lines[i]));
  end;
end;



procedure TForm4.Button3Click(Sender: TObject);
begin
  BuildChart;
  readxi;
end;

end.
