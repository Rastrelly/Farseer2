object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
  ClientHeight = 240
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 497
    Height = 240
    Align = alLeft
    Caption = #1054#1073#1098#1077#1082#1090#1099
    TabOrder = 0
    object Label1: TLabel
      Left = 216
      Top = 15
      Width = 18
      Height = 13
      Caption = #1058#1080#1087
    end
    object ic1: TImage
      Left = 216
      Top = 187
      Width = 41
      Height = 41
      OnClick = ic1Click
    end
    object Label2: TLabel
      Left = 216
      Top = 168
      Width = 35
      Height = 13
      Caption = #1062#1074#1077#1090' 1'
    end
    object Label3: TLabel
      Left = 272
      Top = 168
      Width = 35
      Height = 13
      Caption = #1062#1074#1077#1090' 2'
    end
    object ic2: TImage
      Left = 272
      Top = 187
      Width = 41
      Height = 41
      OnClick = ic2Click
    end
    object ListBox1: TListBox
      Left = 2
      Top = 15
      Width = 199
      Height = 223
      Align = alLeft
      ItemHeight = 13
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object ComboBox1: TComboBox
      Left = 216
      Top = 34
      Width = 265
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = #1058#1086#1095#1082#1072
      Items.Strings = (
        #1058#1086#1095#1082#1072
        #1054#1090#1088#1077#1079#1086#1082
        #1055#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082
        #1069#1083#1083#1080#1087#1089)
    end
    object ex1: TLabeledEdit
      Left = 216
      Top = 96
      Width = 121
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'X1'
      TabOrder = 2
    end
    object ex2: TLabeledEdit
      Left = 216
      Top = 136
      Width = 121
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'X2'
      TabOrder = 3
    end
    object ey1: TLabeledEdit
      Left = 360
      Top = 96
      Width = 121
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'Y1'
      TabOrder = 4
    end
    object ey2: TLabeledEdit
      Left = 360
      Top = 136
      Width = 121
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'Y2'
      TabOrder = 5
    end
    object StaticText1: TStaticText
      Left = 216
      Top = 61
      Width = 68
      Height = 17
      Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1099
      TabOrder = 6
    end
    object Button1: TButton
      Left = 406
      Top = 203
      Width = 75
      Height = 25
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      TabOrder = 7
      OnClick = Button1Click
    end
    object Button4: TButton
      Left = 325
      Top = 203
      Width = 75
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 8
      OnClick = Button4Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 497
    Top = 0
    Width = 212
    Height = 240
    Align = alClient
    Caption = #1054#1073#1097#1080#1077' '#1076#1077#1081#1089#1090#1074#1080#1103
    TabOrder = 1
    ExplicitWidth = 176
    object Label4: TLabel
      Left = 10
      Top = 92
      Width = 194
      Height = 13
      Caption = #1050#1086#1085#1090#1088#1072#1089#1090#1085#1099#1081' '#1087#1077#1088#1077#1087#1072#1076' '#1072#1074#1090#1086#1080#1079#1084#1077#1088#1077#1085#1080#1103
    end
    object Button2: TButton
      Left = 10
      Top = 30
      Width = 199
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1090#1086#1095#1082#1080' '#1079#1072#1084#1077#1088#1086#1074
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 10
      Top = 61
      Width = 199
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1086#1073#1098#1077#1082#1090#1099
      TabOrder = 1
      OnClick = Button3Click
    end
    object econt: TEdit
      Left = 10
      Top = 111
      Width = 199
      Height = 21
      TabOrder = 2
      Text = '100'
    end
    object Button5: TButton
      Left = 134
      Top = 138
      Width = 75
      Height = 25
      Caption = #1053#1072#1079#1085#1072#1095#1080#1090#1100
      TabOrder = 3
      OnClick = Button5Click
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 152
    Top = 128
  end
  object ColorDialog1: TColorDialog
    Left = 160
    Top = 24
  end
  object ColorDialog2: TColorDialog
    Left = 160
    Top = 72
  end
end
