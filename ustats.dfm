object Form4: TForm4
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1095#1077#1089#1082#1072#1103' '#1086#1073#1088#1072#1073#1086#1090#1082#1072
  ClientHeight = 552
  ClientWidth = 1004
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 669
    Top = 0
    Height = 453
    Align = alRight
    ExplicitLeft = 678
    ExplicitTop = -6
    ExplicitHeight = 463
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 453
    Width = 1004
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 5
  end
  object Chart1: TChart
    Left = 185
    Top = 0
    Width = 484
    Height = 453
    Legend.Alignment = laBottom
    Legend.LegendStyle = lsSeries
    Title.Text.Strings = (
      #1042#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077)
    View3D = False
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 487
    ExplicitHeight = 463
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 4
    object Series1: TLineSeries
      Title = #1053#1072#1073#1086#1088' '#1074#1093#1086#1076#1085#1099#1093' '#1076#1072#1085#1085#1099#1093
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      Title = #1057#1088#1077#1076#1085#1077#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 453
    Align = alLeft
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitHeight = 463
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 183
      Height = 144
      Align = alTop
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1089#1080' '#1061
      TabOrder = 0
      object Label1: TLabel
        Left = 3
        Top = 16
        Width = 44
        Height = 13
        Caption = #1052#1080#1085#1080#1084#1091#1084
      end
      object Label2: TLabel
        Left = 3
        Top = 62
        Width = 49
        Height = 13
        Caption = #1052#1072#1082#1089#1080#1084#1091#1084
      end
      object Edit1: TEdit
        Left = 3
        Top = 35
        Width = 166
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object Edit2: TEdit
        Left = 3
        Top = 81
        Width = 166
        Height = 21
        TabOrder = 1
        Text = '100'
      end
      object Button1: TButton
        Left = 104
        Top = 108
        Width = 65
        Height = 25
        Caption = #1055#1088#1080#1085#1103#1090#1100
        TabOrder = 2
      end
      object Button2: TButton
        Left = 3
        Top = 108
        Width = 95
        Height = 25
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
        TabOrder = 3
      end
    end
    object Button3: TButton
      Left = 1
      Top = 427
      Width = 183
      Height = 25
      Align = alBottom
      Caption = #1056#1072#1073#1086#1090#1072
      TabOrder = 1
      OnClick = Button3Click
      ExplicitTop = 437
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 145
      Width = 183
      Height = 282
      Align = alClient
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1072#1085#1072#1083#1080#1079#1072
      TabOrder = 2
      ExplicitHeight = 292
      object Label3: TLabel
        Left = 3
        Top = 24
        Width = 117
        Height = 13
        Caption = #1053#1086#1084#1080#1085#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
      end
      object Label4: TLabel
        Left = 3
        Top = 70
        Width = 6
        Height = 13
        Caption = 'p'
      end
      object Label5: TLabel
        Left = 3
        Top = 116
        Width = 4
        Height = 13
        Caption = 'r'
      end
      object Edit3: TEdit
        Left = 3
        Top = 43
        Width = 121
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object Button4: TButton
        Left = 130
        Top = 43
        Width = 48
        Height = 21
        Caption = #1048#1079' '#1089#1088'.'
        TabOrder = 1
      end
      object Edit4: TEdit
        Left = 3
        Top = 89
        Width = 121
        Height = 21
        TabOrder = 2
        Text = '0,95'
      end
      object Edit5: TEdit
        Left = 3
        Top = 135
        Width = 121
        Height = 21
        TabOrder = 3
        Text = '6'
      end
    end
  end
  object Chart2: TChart
    Left = 672
    Top = 0
    Width = 332
    Height = 453
    Legend.Alignment = laBottom
    Title.Text.Strings = (
      #1057#1090#1072#1090#1080#1089#1090#1080#1095#1077#1089#1082#1080#1077' '#1076#1072#1085#1085#1099#1077)
    View3D = False
    Align = alRight
    TabOrder = 2
    ExplicitHeight = 463
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 4
    object LineSeries1: TBarSeries
      BarBrush.BackColor = clDefault
      Marks.Visible = False
      Title = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1079#1085#1072#1095#1077#1085#1080#1081
      MarksOnBar = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Title = #1050#1086#1083#1086#1082#1086#1083#1086#1086#1073#1088#1072#1079#1085#1072#1103' '#1076#1080#1072#1075#1088#1072#1084#1084#1072
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 456
    Width = 1004
    Height = 96
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 3
    object Memo2: TMemo
      Left = 1
      Top = 1
      Width = 1002
      Height = 94
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
