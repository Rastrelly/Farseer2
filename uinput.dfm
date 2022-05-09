object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 165
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object LabeledEdit1: TLabeledEdit
    Left = 24
    Top = 56
    Width = 225
    Height = 21
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'LabeledEdit1'
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 24
    Top = 104
    Width = 225
    Height = 21
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'LabeledEdit2'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 96
    Top = 131
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 177
    Top = 131
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = Button2Click
  end
end
