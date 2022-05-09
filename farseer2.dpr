program farseer2;

uses
  Vcl.Forms,
  ufarseer2 in 'ufarseer2.pas' {Form1},
  uinput in 'uinput.pas' {Form2},
  utools in 'utools.pas' {Form3},
  ustats in 'ustats.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Farseer 2';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
