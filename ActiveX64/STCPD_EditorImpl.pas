unit STCPD_EditorImpl;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, STCPD_Edit_TLB, StdVcl, SynEdit, SynEditMiscClasses, SynEditSearch,
  SynCompletionProposal, SynEditTypes, SynEditHighlighter, SynHighlighterST_CPD, Math;

type
  TSTCPD_Editor = class(TActiveForm, ISTCPD_Editor)
  private
    { Private declarations }
    FEvents: ISTCPD_EditorEvents;
    SynEdit1: TSynEdit;
    SynSTCPDSyn1: TSynSTCPDSyn;
    sesUno: TSynEditSearch;
    SynCompleteProp: TSynCompletionProposal;
    SecondProposal: TSynCompletionProposal;
    ReplaceDialog1: TReplaceDialog;
    FontDialog1: TFontDialog;

    {event keepers}
    OnShowCtx : procedure(ASender: TObject; const Line: WideString; PosInLine: SYSINT;
                                                       var CurrWord: WideString;
                                                       out CompleteList: WideString;
                                                       out DisplayList :WideString) of object;
    OnContextHelp : procedure(ASender: TObject; const CurrWord: WideString;
                                                           const CurrLine: WideString;
                                                           CursorPos: SYSINT) of object;
    OnSpecialLineColors : procedure(Line: SYSINT; var Special: SYSINT; var FgColor: OLE_COLOR;
                                  var BgColor: OLE_COLOR) of object;
    OnEditorKeyDown : procedure(var Key: Smallint; ShiftState: SYSINT) of object;
    OnEditorKeyPress : procedure(var Key: Smallint) of object;
    OnEditorKeyUp : procedure(var Key: Smallint; ShiftState: SYSINT) of object;
    OnEditorMouseCursor : procedure(CharIndex: SYSINT; LineIndex: SYSINT; var aCursor: SYSINT) of object;
    OnShowSecondProposal : procedure of object;
    OnSecondParameterToken : TCompletionParameter;
    OnSecondCompletionExecute : procedure(Kind: TxProposalType; var CurrentInput: WideString;
       var X: SYSINT; var Y: SYSINT; var CanExecute: WordBool) of object;
    OnSecondCodeCompletion : procedure(var Value: WideString; ShiftState: SYSINT;
       Index: SYSINT; EndTokenChar: Smallint) of object;
    OnSecondClose : procedure of object;
    OnSecondProposalChange : procedure(Aindex: SYSINT) of object;
    OnSecondProposalCancelled : procedure of object;
    OnSecondAfterCodeCompletion : procedure (const Value: WideString; ShiftState: SYSINT;
                                          Index: SYSINT; EndToken: Smallint) of object;
    OnPrimeProposalChange : procedure(AIndex: SYSINT) of object;
    OnDropFiles : procedure (X: SYSINT; Y: SYSINT; const AFiles: WideString) of object;
    OnGutterClick : procedure (Button: TxMouseButton; X: SYSINT; Y: SYSINT; Line: SYSINT) of object;

    AlignWithMargins : WordBool;
    fReplaceDialog1_Visible : Boolean;
    procedure ActivateEvent(Sender: TObject);
    procedure AfterMonitorDpiChangedEvent(Sender: TObject; OldDPI, NewDPI: Integer);
    procedure BeforeMonitorDpiChangedEvent(Sender: TObject; OldDPI, NewDPI: Integer);

    procedure ClickEvent(Sender: TObject);
    procedure CreateEvent(Sender: TObject);
    procedure DblClickEvent(Sender: TObject);
    procedure DeactivateEvent(Sender: TObject);
    procedure DestroyEvent(Sender: TObject);
    procedure KeyPressEvent(Sender: TObject; var Key: Char);
    procedure MouseEnterEvent(Sender: TObject);
    procedure MouseLeaveEvent(Sender: TObject);
    procedure PaintEvent(Sender: TObject);
    procedure SynCompletePropExecute(Kind: SynCompletionType;
      Sender: TObject; var CurrentInput: String; var x, y: Integer;
      var CanExecute: Boolean);
    procedure SynEdit1ContextHelp(Sender: TObject; word: String);
    procedure SynEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SynEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure SynEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SynEdit1MouseCursor(Sender: TObject;
      const aLineCharPos: TBufferCoord; var aCursor: TCursor);
    procedure SynEdit1SpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure SecondProposalShow(Sender: TObject);
    procedure SecondProposalParameterToken(Sender: TObject; Key: WideChar;
    var CurrentIndex, Level: Integer);
    procedure SecondProposalCodeCompletion(Sender: TObject;
      var Value: String; Shift: TShiftState; Index: Integer;
      EndToken: Char);
    procedure SecondProposalClose(Sender: TObject);
    procedure SecondProposalChange(Sender: TObject; AIndex: Integer);
    procedure SecondProposalCancelled(Sender: TObject);
    procedure SecondProposalAfterCodeCompletion(Sender: TObject;
      const Value: String; Shift: TShiftState; Index: Integer;
      EndToken: Char);
    procedure SynCompletePropChange(Sender: TObject; AIndex: Integer);
    procedure SynEdit1DropFiles(Sender: TObject; X, Y: Integer;
      AFiles: TStrings);
    procedure SynEdit1GutterClick(Sender: TObject; Button: TMouseButton; X,
      Y, Line: Integer; Mark: TSynEditMark);
    procedure SecondProposalDoPropExecute(Kind: SynCompletionType;
      Sender: TObject; var CurrentInput: String; var x, y: Integer;
      var CanExecute: Boolean);
    procedure ReplaceDialog1Find(Sender: TObject);
    procedure ReplaceDialog1Show(Sender: TObject);
    procedure ReplaceDialog1Close(Sender: TObject);

    procedure ShowCtxEvent(ASender: TObject; const Line: WideString; PosInLine: SYSINT;
                                                       var CurrWord: WideString;
                                                       out CompleteList: WideString;
                                                       out DisplayList :WideString);
    procedure ContextHelpEvent(ASender: TObject; const CurrWord: WideString;
                                                           const CurrLine: WideString;
                                                           CursorPos: SYSINT);
    procedure SpecialLineColorsEvent(Line: SYSINT; var Special: SYSINT; var FgColor: OLE_COLOR;
                                  var BgColor: OLE_COLOR);
    procedure EditorKeyDownEvent(var Key: Smallint; ShiftState: SYSINT);
    procedure EditorKeyPressEvent(var Key: Smallint);
    procedure EditorKeyUpEvent(var Key: Smallint; ShiftState: SYSINT);
    procedure EditorMouseCursorEvent(CharIndex: SYSINT; LineIndex: SYSINT; var aCursor: SYSINT);
    procedure ShowSecondProposalEvent;
    procedure SecondParameterTokenEvent(Sender: TObject; Key: WideChar; var CurrentIndex, Level: Integer);
    procedure SecondCompletionExecuteEvent(Kind: TxProposalType; var CurrentInput: WideString;
       var X: SYSINT; var Y: SYSINT; var CanExecute: WordBool);
    procedure SecondCodeCompletionEvent(var Value: WideString; ShiftState: SYSINT;
       Index: SYSINT; EndTokenChar: Smallint);
    procedure SecondCloseEvent;
    procedure SecondProposalChangeEvent(Aindex: SYSINT);
    procedure SecondProposalCancelledEvent;
    procedure SecondAfterCodeCompletionEvent(const Value: WideString; ShiftState: SYSINT;
                                          Index: SYSINT; EndToken: Smallint);
    procedure PrimeProposalChangeEvent(AIndex: SYSINT);
    procedure DropFilesEvent(X: SYSINT; Y: SYSINT; const AFiles: WideString);
    procedure GutterClickEvent(Button: TxMouseButton; X: SYSINT; Y: SYSINT; Line: SYSINT);

  protected
    { Protected declarations }
    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    function Get_Active: WordBool; safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_AlignWithMargins: WordBool; safecall;
    function Get_AutoScroll: WordBool; safecall;
    function Get_AutoSize: WordBool; safecall;
    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;
    function Get_BorderWidth: Integer; safecall;
    function Get_Caption: WideString; safecall;
    function Get_Color: OLE_COLOR; safecall;
    function Get_CurrentPPI: Integer; safecall;
    function Get_DockSite: WordBool; safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    function Get_DropTarget: WordBool; safecall;
    function Get_Enabled: WordBool; safecall;
    function Get_ExplicitHeight: Integer; safecall;
    function Get_ExplicitLeft: Integer; safecall;
    function Get_ExplicitTop: Integer; safecall;
    function Get_ExplicitWidth: Integer; safecall;
    function Get_Font: IFontDisp; safecall;
    function Get_HelpFile: WideString; safecall;
    function Get_IsDrawingLocked: WordBool; safecall;
    function Get_KeyPreview: WordBool; safecall;
    function Get_MouseInClient: WordBool; safecall;
    function Get_ParentCustomHint: WordBool; safecall;
    function Get_ParentDoubleBuffered: WordBool; safecall;
    function Get_PixelsPerInch: Integer; safecall;
    function Get_PopupMode: TxPopupMode; safecall;
    function Get_PrintScale: TxPrintScale; safecall;
    function Get_RaiseOnNonMainThreadUsage: WordBool; safecall;
    function Get_RedrawDisabled: WordBool; safecall;
    function Get_Scaled: WordBool; safecall;
    function Get_ScaleFactor: Single; safecall;
    function Get_ScreenSnap: WordBool; safecall;
    function Get_SnapBuffer: Integer; safecall;
    function Get_StyleName: WideString; safecall;
    function Get_UseDockManager: WordBool; safecall;
    function Get_Visible: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    procedure Set_AlignWithMargins(Value: WordBool); safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;
    procedure Set_BorderWidth(Value: Integer); safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    procedure Set_DockSite(Value: WordBool); safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    procedure Set_DropTarget(Value: WordBool); safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure Set_HelpFile(const Value: WideString); safecall;
    procedure Set_KeyPreview(Value: WordBool); safecall;
    procedure Set_ParentCustomHint(Value: WordBool); safecall;
    procedure Set_ParentDoubleBuffered(Value: WordBool); safecall;
    procedure Set_PixelsPerInch(Value: Integer); safecall;
    procedure Set_PopupMode(Value: TxPopupMode); safecall;
    procedure Set_PrintScale(Value: TxPrintScale); safecall;
    procedure Set_RaiseOnNonMainThreadUsage(Value: WordBool); safecall;
    procedure Set_Scaled(Value: WordBool); safecall;
    procedure Set_ScreenSnap(Value: WordBool); safecall;
    procedure Set_SnapBuffer(Value: Integer); safecall;
    procedure Set_StyleName(const Value: WideString); safecall;
    procedure Set_UseDockManager(Value: WordBool); safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function CaretInView: SYSINT; safecall;
    function Get_AvailableOptions: WideString; safecall;
    function Get_BgrColor: OLE_COLOR; safecall;
    function Get_CompleteList: WideString; safecall;
    function Get_Current_Line: WideString; safecall;
    function Get_Current_Word: WideString; safecall;
    function Get_CurrentLineColor: OLE_COLOR; safecall;
    function Get_DisplayList: WideString; safecall;
    function Get_DisplaySTSyntaxOptions: TxSTSyntaxOptions; safecall;
    function Get_EditorOptions: WideString; safecall;
    function Get_EmuTabSize: SYSINT; safecall;
    function Get_HighlightFontString: WideString; safecall;
    function Get_HighlightSet: WideString; safecall;
    function Get_ModifiedFlag: SYSINT; safecall;
    function Get_ParentEditorWindowHandle: Int64; safecall;
    function Get_PrimeEndOfTokenChar: WideString; safecall;
    function Get_PrimeNbItemsInWindow: SYSINT; safecall;
    function Get_PrimeProposalWidth: SYSINT; safecall;
    function Get_PrimeShortCutKey: WideString; safecall;
    function Get_PrimeTimerInterval: SYSINT; safecall;
    function Get_PrimeTriggerChars: WideString; safecall;
    function Get_ProposalColumns: WideString; safecall;
    function Get_ProposalOptions: SYSINT; safecall;
    function Get_ProposalType: TxProposalType; safecall;
    function Get_ReadOnly: SYSINT; safecall;
    function Get_SecondEndOfTokenChar: WideString; safecall;
    function Get_SecondNbItemsInWindow: SYSINT; safecall;
    function Get_SecondPoprosalColumns: WideString; safecall;
    function Get_SecondProposalInsertList: WideString; safecall;
    function Get_SecondProposalItemList: WideString; safecall;
    function Get_SecondProposalOptions: SYSINT; safecall;
    function Get_SecondProposalType: TxProposalType; safecall;
    function Get_SecondProposalWidth: SYSINT; safecall;
    function Get_SecondShortCutKey: WideString; safecall;
    function Get_SecondTimerInterval: SYSINT; safecall;
    function Get_SecondTriggerChars: WideString; safecall;
    function Get_ShowText: WideString; safecall;
    function Get_TextCursorIndex: SYSINT; safecall;
    function Get_XCoord: SYSINT; safecall;
    function Get_YCoord: SYSINT; safecall;
    function GetBookMark(BookMark: SYSINT; var X, Y: SYSINT): SYSINT; safecall;
    function GetDebugInfo(command: SYSINT; var parameter: SYSINT): WideString; safecall;

    function InternalSelectFontDialog: SYSINT; safecall;
    procedure ClearBookMark(BookMark: SYSINT); safecall;
    procedure Copy_Clip; safecall;
    procedure CursorIndexToXY(CurIdx: SYSINT; out TextX, TextY: SYSINT); safecall;
    procedure Cut_Clip; safecall;
    procedure DisplayToXYCoord(ScreenX, ScreenY: SYSINT; out TextLine, TextChar: SYSINT);
          safecall;
    procedure EnsureCursorPosVisible(ForceToMiddle: WordBool); safecall;
    procedure Find_Clip(const SearchStr: WideString; FindStart, FindLen, Options: SYSINT);
          safecall;
    procedure InsertAtCursor(const Tekst: WideString); safecall;
    procedure InternalFindReplaceDlg(NewVisible: SYSINT; const InitFind, InitReplace: WideString;
          out OutResult: SYSINT); safecall;
    procedure LoadLinesFromFile(const FileName: WideString); safecall;
    procedure Paste_Clip; safecall;
    procedure PrimeProposalCancel; safecall;
    procedure PrimeProposalExecute; safecall;
    procedure Redo_Clip; safecall;
    procedure SaveLinesToFile(const FileName: WideString); safecall;
    procedure SecondProposalCancel; safecall;
    procedure SecondProposalExecute(const DisplayList, CompleteList: WideString; ProposalType: TxProposalType;
          ProposalPosX, ProposalPosY: SYSINT); safecall;
    procedure SelectAll_Clip; safecall;
    procedure Set_BgrColor(Value: OLE_COLOR); safecall;
    procedure Set_CompleteList(const Value: WideString); safecall;
    procedure Set_Current_Line(const Value: WideString); safecall;
    procedure Set_Current_Word(const Value: WideString); safecall;
    procedure Set_CurrentLineColor(Value: OLE_COLOR); safecall;
    procedure Set_DisplayList(const Value: WideString); safecall;
    procedure Set_DisplaySTSyntaxOptions(Value: TxSTSyntaxOptions); safecall;
    procedure Set_EditorOptions(const Value: WideString); safecall;
    procedure Set_EmuTabSize(Value: SYSINT); safecall;
    procedure Set_HighlightFontString(const Value: WideString); safecall;
    procedure Set_HighlightSet(const Value: WideString); safecall;
    procedure Set_ModifiedFlag(Value: SYSINT); safecall;
    procedure Set_ParentEditorWindowHandle(Value: Int64); safecall;
    procedure Set_PrimeEndOfTokenChar(const Value: WideString); safecall;
    procedure Set_PrimeNbItemsInWindow(Value: SYSINT); safecall;
    procedure Set_PrimeProposalWidth(Value: SYSINT); safecall;
    procedure Set_PrimeShortCutKey(const Value: WideString); safecall;
    procedure Set_PrimeTimerInterval(Value: SYSINT); safecall;
    procedure Set_PrimeTriggerChars(const Value: WideString); safecall;
    procedure Set_ProposalColumns(const Value: WideString); safecall;
    procedure Set_ProposalOptions(Value: SYSINT); safecall;
    procedure Set_ProposalType(Value: TxProposalType); safecall;
    procedure Set_ReadOnly(Value: SYSINT); safecall;
    procedure Set_SecondEndOfTokenChar(const Value: WideString); safecall;
    procedure Set_SecondNbItemsInWindow(Value: SYSINT); safecall;
    procedure Set_SecondPoprosalColumns(const Value: WideString); safecall;
    procedure Set_SecondProposalInsertList(const Value: WideString); safecall;
    procedure Set_SecondProposalItemList(const Value: WideString); safecall;
    procedure Set_SecondProposalOptions(Value: SYSINT); safecall;
    procedure Set_SecondProposalType(Value: TxProposalType); safecall;
    procedure Set_SecondProposalWidth(Value: SYSINT); safecall;
    procedure Set_SecondShortCutKey(const Value: WideString); safecall;
    procedure Set_SecondTimerInterval(Value: SYSINT); safecall;
    procedure Set_SecondTriggerChars(const Value: WideString); safecall;
    procedure Set_ShowText(const Value: WideString); safecall;
    procedure Set_TextCursorIndex(Value: SYSINT); safecall;
    procedure Set_XCoord(Value: SYSINT); safecall;
    procedure Set_YCoord(Value: SYSINT); safecall;
    procedure SetBookMark(BookMark, X, Y: SYSINT); safecall;
    procedure Undo_Clip; safecall;
    procedure XYCoordToDisplay(TextLine, TextChar: SYSINT; out ScreenX, ScreenY: SYSINT);
          safecall;
    procedure XYToCursorIndex(TextX, TextY: SYSINT; out CurIdx: SYSINT); safecall;
    procedure SetGroupAttribs(const AttrGrp : array of String);
  public
    { Public declarations }
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses ComObj, ComServ, Menus, StrUtils;

{$R *.DFM}

{ TSTCPD_Editor }

procedure TSTCPD_Editor.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  { Define property pages here.  Property pages are defined by calling
    DefinePropertyPage with the class id of the page.  For example,
      DefinePropertyPage(Class_STCPD_EditorPage); }
end;

procedure TSTCPD_Editor.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as ISTCPD_EditorEvents;
  inherited EventSinkChanged(EventSink);
end;

procedure TSTCPD_Editor.Initialize;
begin
  inherited Initialize;
  {extra initialization from Form}

  SynSTCPDSyn1 := TSynSTCPDSyn.Create(self);
  SynSTCPDSyn1.Options := [];
    sesUno := TSynEditSearch.Create(self);

  ReplaceDialog1 := TReplaceDialog.Create(self);
  with ReplaceDialog1 do begin
    OnClose := ReplaceDialog1Close;
    OnShow := ReplaceDialog1Show;
    OnFind := ReplaceDialog1Find;
    OnReplace := ReplaceDialog1Find;
  end;

  FontDialog1 := TFontDialog.Create(self);
  with FontDialog1 do begin
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    Device := fdBoth;
    Options := [fdNoStyleSel];
  end;

  SynEdit1 := TSynEdit.Create(self);
  with SynEdit1 do begin
    Left := 0;
    Top := 0;
    Width := 570;
    Height := 328;
    Align := alClient;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'Consolas';
    Font.Style := [];
    TabOrder := 0;
    OnKeyDown := SynEdit1KeyDown;
    OnKeyPress := SynEdit1KeyPress;
    OnKeyUp := SynEdit1KeyUp;
    CodeFolding.GutterShapeSize := 11;
    CodeFolding.CollapsedLineColor := clGrayText;
    CodeFolding.FolderBarLinesColor := clGrayText;
{    CodeFolding.IndentGuidesColor := clGray;
    CodeFolding.IndentGuides := True; }
    CodeFolding.ShowCollapsedLine := False;
    CodeFolding.ShowHintMark := True;
    UseCodeFolding := False;
    BorderStyle := bsNone;
    //Gutter.AutoSize := True;
    Gutter.DigitCount := 3;
    Gutter.Font.Charset := DEFAULT_CHARSET;
    Gutter.Font.Color := clWindowText;
    Gutter.Font.Height := -11;
    Gutter.Font.Name := 'Consolas';
    Gutter.Font.Style := [];
    Gutter.Font.Quality := fqClearTypeNatural;
    Gutter.LeadingZeros := True;
    Gutter.ShowLineNumbers := True;
    Gutter.Gradient := True;
    IndentGuides.Visible := False;
    Highlighter := SynSTCPDSyn1;
    SearchEngine := sesUno;
    WantTabs := True;
    OnContextHelp := SynEdit1ContextHelp;
    OnDropFiles := SynEdit1DropFiles;
    OnGutterClick := SynEdit1GutterClick;
    OnMouseCursor := SynEdit1MouseCursor;
    OnSpecialLineColors := SynEdit1SpecialLineColors;
 {   FontSmoothing := fsmNone;
    RemovedKeystrokes := <
      item
        Command = ecInsertLine
        ShortCut = 16462
      end
      item
        Command = ecDeleteLine
        ShortCut = 16473
      end>
    AddedKeystrokes = <
      item
        Command = ecInsertLine
        ShortCut = 16456
      end
      item
        Command = ecDeleteLine
        ShortCut = 16455
      end>
      }
    Parent := self;
  end;

  SynCompleteProp := TSynCompletionProposal.Create(self);
  with SynCompleteProp do begin
    Options := [scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText,
    scoUseBuiltInTimer, scoEndCharCompletion, scoConsiderWordBreakChars,
    scoCompleteWithTab, scoCompleteWithEnter];
    EndOfTokenChr := '()[]. ';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := DEFAULT_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'MS Sans Serif';
    TitleFont.Style := [fsBold];
    Columns.Clear;
    OnChange := SynCompletePropChange;
    OnExecute := SynCompletePropExecute;
    ShortCut := 16416;
    Editor := SynEdit1;
    Resizeable := true;
  end;

  SecondProposal:= TSynCompletionProposal.Create(self);
  with SecondProposal do begin
    Options := [scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText,
      scoUseBuiltInTimer, scoEndCharCompletion, scoConsiderWordBreakChars,
      scoCompleteWithTab, scoCompleteWithEnter];
    EndOfTokenChr := '()[]. ';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := DEFAULT_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'MS Sans Serif';
    TitleFont.Style := [fsBold];
    OnChange := SecondProposalChange;
    OnClose := SecondProposalClose;
    OnExecute := SecondProposalDoPropExecute;
    OnParameterToken := SecondProposalParameterToken;
    OnShow := SecondProposalShow;
    ShortCut := 0;
    Editor := SynEdit1;
    OnAfterCodeCompletion := SecondProposalAfterCodeCompletion;
    OnCancelled := SecondProposalCancelled;
    OnCodeCompletion := SecondProposalCodeCompletion;
    Resizeable := true;
  end;
  ActiveControl := SynEdit1;
  OnActivate := ActivateEvent;
  OnAfterMonitorDpiChanged := AfterMonitorDpiChangedEvent;
  OnBeforeMonitorDpiChanged := BeforeMonitorDpiChangedEvent;
  OnClick := ClickEvent;
  OnCreate := CreateEvent;
  OnDblClick := DblClickEvent;
  OnDeactivate := DeactivateEvent;
  OnDestroy := DestroyEvent;
  OnKeyPress := KeyPressEvent;
  OnMouseEnter := MouseEnterEvent;
  OnMouseLeave := MouseLeaveEvent;
  OnPaint := PaintEvent;
  OnShowCtx := ShowCtxEvent;
  OnContextHelp := ContextHelpEvent;
  OnSpecialLineColors := SpecialLineColorsEvent;
  OnEditorKeyDown := EditorKeyDownEvent;
  OnEditorKeyPress := EditorKeyPressEvent;
  OnEditorKeyUp := EditorKeyUpEvent;
  OnEditorMouseCursor := EditorMouseCursorEvent;
  OnShowSecondProposal := ShowSecondProposalEvent;
  OnSecondParameterToken := SecondParameterTokenEvent;
  OnSecondCompletionExecute := SecondCompletionExecuteEvent;
  OnSecondCodeCompletion := SecondCodeCompletionEvent;
  OnSecondClose := SecondCloseEvent;
  OnSecondProposalChange := SecondProposalChangeEvent;
  OnSecondProposalCancelled := SecondProposalCancelledEvent;
  OnSecondAfterCodeCompletion := SecondAfterCodeCompletionEvent;
  OnPrimeProposalChange := PrimeProposalChangeEvent;
  OnDropFiles := DropFilesEvent;
  OnGutterClick := GutterClickEvent;
end;

function TSTCPD_Editor.Get_Active: WordBool;
begin
  Result := Active;
end;

function TSTCPD_Editor.Get_AlignDisabled: WordBool;
begin
  Result := AlignDisabled;
end;

function TSTCPD_Editor.Get_AlignWithMargins: WordBool;
begin
  Result := AlignWithMargins;
end;

function TSTCPD_Editor.Get_AutoScroll: WordBool;
begin
  Result := AutoScroll;
end;

function TSTCPD_Editor.Get_AutoSize: WordBool;
begin
  Result := AutoSize;
end;

function TSTCPD_Editor.Get_AxBorderStyle: TxActiveFormBorderStyle;
begin
  Result := Ord(AxBorderStyle);
end;

function TSTCPD_Editor.Get_BorderWidth: Integer;
begin
  Result := Integer(BorderWidth);
end;

function TSTCPD_Editor.Get_Caption: WideString;
begin
  Result := WideString(Caption);
end;

function TSTCPD_Editor.Get_Color: OLE_COLOR;
begin
  Result := OLE_COLOR(Color);
end;

function TSTCPD_Editor.Get_CurrentPPI: Integer;
begin
  Result := CurrentPPI;
end;

function TSTCPD_Editor.Get_DockSite: WordBool;
begin
  Result := DockSite;
end;

function TSTCPD_Editor.Get_DoubleBuffered: WordBool;
begin
  Result := DoubleBuffered;
end;

function TSTCPD_Editor.Get_DropTarget: WordBool;
begin
  Result := DropTarget;
end;

function TSTCPD_Editor.Get_Enabled: WordBool;
begin
  Result := Enabled;
end;

function TSTCPD_Editor.Get_ExplicitHeight: Integer;
begin
  Result := ExplicitHeight;
end;

function TSTCPD_Editor.Get_ExplicitLeft: Integer;
begin
  Result := ExplicitLeft;
end;

function TSTCPD_Editor.Get_ExplicitTop: Integer;
begin
  Result := ExplicitTop;
end;

function TSTCPD_Editor.Get_ExplicitWidth: Integer;
begin
  Result := ExplicitWidth;
end;

function TSTCPD_Editor.Get_Font: IFontDisp;
begin
  GetOleFont(Font, Result);
end;

function TSTCPD_Editor.Get_HelpFile: WideString;
begin
  Result := WideString(HelpFile);
end;

function TSTCPD_Editor.Get_IsDrawingLocked: WordBool;
begin
  Result := IsDrawingLocked;
end;

function TSTCPD_Editor.Get_KeyPreview: WordBool;
begin
  Result := KeyPreview;
end;

function TSTCPD_Editor.Get_MouseInClient: WordBool;
begin
  Result := MouseInClient;
end;

function TSTCPD_Editor.Get_ParentCustomHint: WordBool;
begin
  Result := ParentCustomHint;
end;

function TSTCPD_Editor.Get_ParentDoubleBuffered: WordBool;
begin
  Result := ParentDoubleBuffered;
end;

function TSTCPD_Editor.Get_PixelsPerInch: Integer;
begin
  Result := PixelsPerInch;
end;

function TSTCPD_Editor.Get_PopupMode: TxPopupMode;
begin
  Result := Ord(PopupMode);
end;

function TSTCPD_Editor.Get_PrintScale: TxPrintScale;
begin
  Result := Ord(PrintScale);
end;

function TSTCPD_Editor.Get_RaiseOnNonMainThreadUsage: WordBool;
begin
  Result := RaiseOnNonMainThreadUsage;
end;

function TSTCPD_Editor.Get_RedrawDisabled: WordBool;
begin
  Result := RedrawDisabled;
end;

function TSTCPD_Editor.Get_Scaled: WordBool;
begin
  Result := Scaled;
end;

function TSTCPD_Editor.Get_ScaleFactor: Single;
begin
  Result := ScaleFactor;
end;

function TSTCPD_Editor.Get_ScreenSnap: WordBool;
begin
  Result := ScreenSnap;
end;

function TSTCPD_Editor.Get_SnapBuffer: Integer;
begin
  Result := SnapBuffer;
end;

function TSTCPD_Editor.Get_StyleName: WideString;
begin
  Result := WideString(StyleName);
end;

function TSTCPD_Editor.Get_UseDockManager: WordBool;
begin
  Result := UseDockManager;
end;

function TSTCPD_Editor.Get_Visible: WordBool;
begin
  Result := Visible;
end;

function TSTCPD_Editor.Get_VisibleDockClientCount: Integer;
begin
  Result := VisibleDockClientCount;
end;

procedure TSTCPD_Editor._Set_Font(var Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TSTCPD_Editor.ActivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnActivate;
end;

procedure TSTCPD_Editor.AfterMonitorDpiChangedEvent(Sender: TObject; OldDPI, NewDPI: Integer);

begin
  if FEvents <> nil then FEvents.OnAfterMonitorDpiChanged(OldDPI, NewDPI);
end;

procedure TSTCPD_Editor.BeforeMonitorDpiChangedEvent(Sender: TObject; OldDPI, NewDPI: Integer);

begin
  if FEvents <> nil then FEvents.OnBeforeMonitorDpiChanged(OldDPI, NewDPI);
end;

procedure TSTCPD_Editor.ClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnClick;
end;

procedure TSTCPD_Editor.CreateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnCreate;
end;

procedure TSTCPD_Editor.DblClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDblClick;
end;

procedure TSTCPD_Editor.DeactivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDeactivate;
end;

destructor TSTCPD_Editor.Destroy;
begin
  ActiveControl := nil;
  OnActivate := nil;
  OnAfterMonitorDpiChanged := nil;
  OnBeforeMonitorDpiChanged := nil;
  OnClick := nil;
  OnCreate := nil;
  OnDblClick := nil;
  OnDeactivate := nil;
  OnDestroy := nil;
  OnKeyPress := nil;
  OnMouseEnter := nil;
  OnMouseLeave := nil;
  OnPaint := nil;
  OnShowCtx := nil;
  OnContextHelp := nil;
  OnSpecialLineColors := nil;
  OnEditorKeyDown := nil;
  OnEditorKeyPress := nil;
  OnEditorKeyUp := nil;
  OnEditorMouseCursor := nil;
  OnShowSecondProposal := nil;
  OnSecondParameterToken := nil;
  OnSecondCompletionExecute := nil;
  OnSecondCodeCompletion := nil;
  OnSecondClose := nil;
  OnSecondProposalChange := nil;
  OnSecondProposalCancelled := nil;
  OnSecondAfterCodeCompletion := nil;
  OnPrimeProposalChange := nil;
  OnDropFiles := nil;
  OnGutterClick := nil;
  FreeAndNil(SecondProposal);
  FreeAndNil(SynCompleteProp);
  FreeAndNil(SynEdit1);
  FreeAndNil(FontDialog1);
  FreeAndNil(ReplaceDialog1);
  FreeAndNil(SynSTCPDSyn1);
  inherited;
end;

procedure TSTCPD_Editor.DestroyEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDestroy;
end;

procedure TSTCPD_Editor.KeyPressEvent(Sender: TObject; var Key: Char);
var
  TempKey: Smallint;
begin
  TempKey := Smallint(Key);
  if FEvents <> nil then FEvents.OnKeyPress(TempKey);
  Key := Char(TempKey);
end;

procedure TSTCPD_Editor.MouseEnterEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnMouseEnter;
end;

procedure TSTCPD_Editor.MouseLeaveEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnMouseLeave;
end;

procedure TSTCPD_Editor.PaintEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnPaint;
end;

procedure TSTCPD_Editor.Set_AlignWithMargins(Value: WordBool);
begin
  AlignWithMargins := Value;
end;

procedure TSTCPD_Editor.Set_AutoScroll(Value: WordBool);
begin
  AutoScroll := Value;
end;

procedure TSTCPD_Editor.Set_AutoSize(Value: WordBool);
begin
  AutoSize := Value;
end;

procedure TSTCPD_Editor.Set_AxBorderStyle(Value: TxActiveFormBorderStyle);
begin
  AxBorderStyle := TActiveFormBorderStyle(Value);
end;

procedure TSTCPD_Editor.Set_BorderWidth(Value: Integer);
begin
  BorderWidth := TBorderWidth(Value);
end;

procedure TSTCPD_Editor.Set_Caption(const Value: WideString);
begin
  Caption := TCaption(Value);
end;

procedure TSTCPD_Editor.Set_Color(Value: OLE_COLOR);
begin
  Color := TColor(Value);
end;

procedure TSTCPD_Editor.Set_DockSite(Value: WordBool);
begin
  DockSite := Value;
end;

procedure TSTCPD_Editor.Set_DoubleBuffered(Value: WordBool);
begin
  DoubleBuffered := Value;
end;

procedure TSTCPD_Editor.Set_DropTarget(Value: WordBool);
begin
  DropTarget := Value;
end;

procedure TSTCPD_Editor.Set_Enabled(Value: WordBool);
begin
  Enabled := Value;
end;

procedure TSTCPD_Editor.Set_Font(const Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TSTCPD_Editor.Set_HelpFile(const Value: WideString);
begin
  HelpFile := string(Value);
end;

procedure TSTCPD_Editor.Set_KeyPreview(Value: WordBool);
begin
  KeyPreview := Value;
end;

procedure TSTCPD_Editor.Set_ParentCustomHint(Value: WordBool);
begin
  ParentCustomHint := Value;
end;

procedure TSTCPD_Editor.Set_ParentDoubleBuffered(Value: WordBool);
begin
  ParentDoubleBuffered := Value;
end;

procedure TSTCPD_Editor.Set_PixelsPerInch(Value: Integer);
begin
  PixelsPerInch := Value;
end;

procedure TSTCPD_Editor.Set_PopupMode(Value: TxPopupMode);
begin
  PopupMode := TPopupMode(Value);
end;

procedure TSTCPD_Editor.Set_PrintScale(Value: TxPrintScale);
begin
  PrintScale := TPrintScale(Value);
end;

procedure TSTCPD_Editor.Set_RaiseOnNonMainThreadUsage(Value: WordBool);
begin
  RaiseOnNonMainThreadUsage := Value;
end;

procedure TSTCPD_Editor.Set_Scaled(Value: WordBool);
begin
  Scaled := Value;
end;

procedure TSTCPD_Editor.Set_ScreenSnap(Value: WordBool);
begin
  ScreenSnap := Value;
end;

procedure TSTCPD_Editor.Set_SnapBuffer(Value: Integer);
begin
  SnapBuffer := Value;
end;

procedure TSTCPD_Editor.Set_StyleName(const Value: WideString);
begin
  StyleName := string(Value);
end;

procedure TSTCPD_Editor.Set_UseDockManager(Value: WordBool);
begin
  UseDockManager := Value;
end;

procedure TSTCPD_Editor.Set_Visible(Value: WordBool);
begin
  Visible := Value;
end;

function TSTCPD_Editor.CaretInView: SYSINT;
begin
Result := ord(SynEdit1.CaretInView);
end;

function TSTCPD_Editor.Get_AvailableOptions: WideString;
begin
Result := 'eoAutoIndent,eoDragDropEditing,eoDropFiles,eoEnhanceHomeKey,eoEnhanceEndKey,eoGroupUndo,eoKeepCaretX,eoNoCaret,' +
  'eoNoSelection,eoRightMouseMovesCursor,eoSmartTabDelete,eoSmartTabs,eoSpecialLineDefaultFg,eoTabIndent,eoTabsToSpaces,'+
  'eoTrimTrailingSpaces,eoShowLigatures,eoCopyPlainText,eoNoHTMLBackground,eoWrapWithRightEdge,eoBracketsHighlight,'+
  'eoAccessibility,eoCompleteBrackets,eoCompleteQuotes,eoDisableScrollArrows,eoHalfPageScroll,eoHideShowScrollbars,'+
  'eoScrollByOneLess,eoScrollHintFollows,eoScrollPastEof,eoScrollPastEol,eoShowScrollHint,usrShowIndentGuides';
end;

function TSTCPD_Editor.Get_BgrColor: OLE_COLOR;
begin
  Result := OLE_COLOR(SynEdit1.Color);
end;

function TSTCPD_Editor.Get_CompleteList: WideString;
begin
  Result := SynCompleteProp.InsertList.CommaText;
end;

function TSTCPD_Editor.Get_Current_Line: WideString;
begin
  Result := SynEdit1.LineText;
end;

function TSTCPD_Editor.Get_Current_Word: WideString;
begin
  Result := SynEdit1.WordAtCursor;
end;

function TSTCPD_Editor.Get_CurrentLineColor: OLE_COLOR;
begin
  Result := OLE_COLOR(SynEdit1.ActiveLineColor);
end;

function TSTCPD_Editor.Get_DisplayList: WideString;
begin
  Result :=  SynCompleteProp.ItemList.CommaText;
end;

function ConvertOptionsToTxSTSyntaxOptions(Src : JTSynSTCPDSynOptions):TxSTSyntaxOptions;
begin
 Result := 0;
 if jtsAllowCppComment in Src then Inc(Result, stsoEnableCppComment);
 if jtsAllowNestedComments in Src then Inc(Result, stsoEnableNestedComments);
 if jtsAllowSpecialProc in Src then Inc(Result, stsoAllowSpecialProc);
 if jtsAllowVerifDirect in Src then Inc(Result, stsoAllowVerifDirect);
 if jtsUseFINTAsType in Src then Inc(Result, stsoUseFINTAsType);
end;

function DeConvertOptionsFromTxSTSyntaxOptions(Src : TxSTSyntaxOptions):JTSynSTCPDSynOptions;
begin
 Result := [];
 if (Src and stsoEnableCppComment) <> 0 then Include(Result, jtsAllowCppComment);
 if (Src and stsoEnableNestedComments) <> 0 then Include(Result, jtsAllowNestedComments);
 if (Src and stsoAllowSpecialProc) <> 0 then Include(Result, jtsAllowSpecialProc);
 if (Src and stsoAllowVerifDirect) <> 0 then Include(Result, jtsAllowVerifDirect);
 if (Src and stsoUseFINTAsType) <> 0 then Include(Result, jtsUseFINTAsType);
end;

function TSTCPD_Editor.Get_DisplaySTSyntaxOptions: TxSTSyntaxOptions;
begin
  Result := ConvertOptionsToTxSTSyntaxOptions(SynSTCPDSyn1.Options);
end;

function TSTCPD_Editor.Get_EditorOptions: WideString;
var no : TSynEditorOptions;
     sr : TSynEditorScrollOptions;
     r : TStringList;
begin
 r := TStringList.Create;
 no := SynEdit1.Options;
 sr := SynEdit1.ScrollOptions;
// if eoAltSetsColumnMode in no then r.Add('eoAltSetsColumnMode');
 if eoAutoIndent in no then r.Add('eoAutoIndent');
// if eoAutoSizeMaxScrollWidth in no then r.Add('eoAutoSizeMaxScrollWidth');
 if eoDisableScrollArrows in sr then r.Add('eoDisableScrollArrows');
 if eoDragDropEditing in no then r.Add('eoDragDropEditing');
 if eoDropFiles in no then r.Add('eoDropFiles');
 if eoEnhanceHomeKey in no then r.Add('eoEnhanceHomeKey');
 if eoEnhanceEndKey in no then r.Add('eoEnhanceEndKey');
 if eoGroupUndo in no then r.Add('eoGroupUndo');
 if eoHalfPageScroll in sr then r.Add('eoHalfPageScroll');
 if eoHideShowScrollbars in sr then r.Add('eoHideShowScrollbars');
 if eoKeepCaretX in no then r.Add('eoKeepCaretX');
 if eoNoCaret in no then r.Add('eoNoCaret');
 if eoNoSelection in no then r.Add('eoNoSelection');
 if eoRightMouseMovesCursor in no then r.Add('eoRightMouseMovesCursor');
 if eoScrollByOneLess in sr then r.Add('eoScrollByOneLess');
 if eoScrollHintFollows in sr then r.Add('eoScrollHintFollows');
 if eoScrollPastEof in sr then r.Add('eoScrollPastEof');
 if eoScrollPastEol in sr then r.Add('eoScrollPastEol');
 if eoShowScrollHint in sr then r.Add('eoShowScrollHint');
// if eoShowSpecialChars in no then r.Add('eoShowSpecialChars');
 if eoSmartTabDelete in no then r.Add('eoSmartTabDelete');
 if eoSmartTabs in no then r.Add('eoSmartTabs');
 if eoSpecialLineDefaultFg in no then r.Add('eoSpecialLineDefaultFg');
 if eoTabIndent in no then r.Add('eoTabIndent');
 if eoTabsToSpaces in no then r.Add('eoTabsToSpaces');
 if eoTrimTrailingSpaces in no then r.Add('eoTrimTrailingSpaces');
 if eoShowLigatures in no then r.Add('eoShowLigatures');
 if eoCopyPlainText in no then r.Add('eoCopyPlainText');
 if eoNoHTMLBackground in no then r.Add('eoNoHTMLBackground');
 if eoWrapWithRightEdge in no then r.Add('eoWrapWithRightEdge');
 if eoBracketsHighlight in no then r.Add('eoBracketsHighlight');
 if eoAccessibility in no then r.Add('eoAccessibility');
 if eoCompleteBrackets in no then r.Add('eoCompleteBrackets');
 if eoCompleteQuotes in no then r.Add('eoCompleteQuotes');
 if eoDisableScrollArrows in sr then r.Add('eoDisableScrollArrows');
 if eoHalfPageScroll in sr then r.Add('eoHalfPageScroll');
 if eoHideShowScrollbars in sr then r.Add('eoHideShowScrollbars');
 if SynEdit1.IndentGuides.Visible then r.Add('usrShowIndentGuides');
 Result := r.CommaText;
 r.Free;
end;

function TSTCPD_Editor.Get_EmuTabSize: SYSINT;
begin
  Result := SynEdit1.TabWidth;
end;

function TSTCPD_Editor.Get_HighlightFontString: WideString;
var L : TStringList;
begin
 L := TStringList.Create;
 L.Append(SynEdit1.Font.Name);
 L.Append(IntToStr(SynEdit1.Font.Height));
 L.Append(IntToStr(SynEdit1.Font.Charset));
 Result := L.CommaText;
 L.Free;
end;

procedure StrtoAttr(var Attr: TSynHighlighterAttributes; Value: string);
var
 tmp: TStringList;
begin
  tmp:= TStringList.Create;
  try
   tmp.commaText:= Value;
   if tmp.count = 5 then
    with attr do
     begin
       Foreground:= StringtoColor(tmp[0]);
       Background:= StringtoColor(tmp[1]);
       style:= [];
       if tmp[2] = '1' then
        style:= style + [fsbold]
       else
        style:= style - [fsbold];
       if tmp[3] = '1' then
        style:= style + [fsItalic]
       else
        style:= style - [fsItalic];
       if tmp[4] = '1' then
        style:= style + [fsUnderline]
       else
        style:= style - [fsUnderline];
     end;
  finally
   tmp.Free;
  end;
end;

function AttrtoStr(const Attr: TSynHighlighterAttributes): string;
begin
  result := format('%s, %s, %d, %d, %d',
           [ColortoString(Attr.Foreground),
            ColortoString(Attr.Background),
            ord(fsBold in Attr.Style),
            ord(fsItalic in Attr.Style),
            ord(fsUnderline in Attr.Style)]);
end;

function TSTCPD_Editor.Get_HighlightSet: WideString;
var  i : integer;
begin
 Result := '';
 for i:= 0 to pred(SynSTCPDSyn1.AttrCount) do
  begin
    if i <> 0 then Result := Result + '|';
    Result := Result + AttrtoStr(SynSTCPDSyn1.Attribute[i]);
  end;
end;

function TSTCPD_Editor.Get_ModifiedFlag: SYSINT;
begin
 Result := ord(SynEdit1.Modified);
end;

function TSTCPD_Editor.Get_ParentEditorWindowHandle: Int64;
{$IFDEF SJ_ACTIVEX}
var v,w : HWND;
{$ENDIF}
begin
{$IFDEF SJ_ACTIVEX}
 v := SynCompleteProp.AppWinSend;
 w := SecondProposal.AppWinSend;
 if v <> w then
   begin
     if ((v = 0) or (v = INVALID_HANDLE_VALUE))
      then Result := Int64(w)
      else Result := Int64(v);
   end
 else
   Result := Int64(v);
{$ELSE}
   {$MESSAGE 'This means that property AppWinSend has been turned off, turn it on by defining SJ_ACTIVEX symbol'}
   Result := 0;
{$ENDIF}
end;

function TSTCPD_Editor.Get_PrimeEndOfTokenChar: WideString;
begin
  Result := SynCompleteProp.EndOfTokenChr;
end;

function TSTCPD_Editor.Get_PrimeNbItemsInWindow: SYSINT;
begin
  Result := SynCompleteProp.NbLinesInWindow;
end;

function TSTCPD_Editor.Get_PrimeProposalWidth: SYSINT;
begin
  Result := SynCompleteProp.Width;
end;

function TSTCPD_Editor.Get_PrimeShortCutKey: WideString;
begin
  Result := ShortCutToText(SynCompleteProp.ShortCut);
end;

function TSTCPD_Editor.Get_PrimeTimerInterval: SYSINT;
begin
  Result := SynCompleteProp.TimerInterval;
end;

function TSTCPD_Editor.Get_PrimeTriggerChars: WideString;
begin
  Result := SynCompleteProp.TriggerChars;
end;

function Multi_Get_ProposalColumns(SynCompleteProp : TSynCompletionProposal): WideString;
var cols : TStringList;
var i : Integer;
    c : TProposalColumn;
    s : WideString;
    v : TFontStyles;
begin
cols := TStringList.Create;
for i := 0 to SynCompleteProp.Columns.Count - 1 do
 begin
  c := SynCompleteProp.Columns[i];
  cols.Add(IntToStr(c.ColumnWidth));
  v := c.DefaultFontStyle;
  s := '[';
  if fsBold in v then s := s + 'B';
  if fsUnderline in v then s := s + 'U';
  if fsItalic in v then s := s + 'I';
  if fsStrikeOut in v then s := s + 'S';
  s := s + ']';
  cols.Append(s);
 end;
Result := cols.CommaText;
cols.Free;
end;

procedure Multi_Set_ProposalColumns(const SynCompleteProp : TSynCompletionProposal; const Value: WideString);
var cols : TStringList;
var i, j : Integer;
    c : TProposalColumn;
    s : String;
    v : TFontStyles;
begin
//CATEGORY,[],
SynCompleteProp.Columns.BeginUpdate;
SynCompleteProp.Columns.Clear;
cols := TStringList.Create;
cols.CommaText := Value;
i := 0;
while i < cols.Count do
begin
 c := SynCompleteProp.Columns.Add;
 c.ColumnWidth := StrToInt(cols[i]);
 inc(i);
 if i < cols.Count
  then
  begin
   s := cols[i];
   if ((Length(s) > 0) and (s[1] = '[')) then
   begin
      Inc(i);
      j := 2;
      v := [];
      while j < Length(S) do
       begin
        case s[j] of
         'B': Include(v, fsBold);
         'S': Include(v, fsStrikeOut);
         'I': Include(v, fsItalic);
         'U': Include(v, fsUnderline);
        end;
        Inc(j);
      end;
      c.DefaultFontStyle := v;
   end;
  end;
end;
SynCompleteProp.Columns.EndUpdate;
cols.Free;
end;

function TSTCPD_Editor.Get_ProposalColumns: WideString;
begin
  Result := Multi_Get_ProposalColumns(SynCompleteProp);
end;

function Multi_Get_ProposalOptions(SynCompleteProp : TSynCompletionProposal): SYSINT;
 var v : TSynCompletionOptions;
begin
 Result := 0;
 v := SynCompleteProp.Options;
 //if scoAnsiStrings in v then Inc(Result, poscoAnsiStrings);
 if scoCaseSensitive in v then Inc(Result, poscoCaseSensitive);
 if scoLimitToMatchedText in v then Inc(Result, poscoLimitToMatchedText);
 if scoTitleIsCentered in v then Inc(Result, poscoTitleIsCentered);
 if scoUseInsertList in v then Inc(Result, poscoUseInsertList);
 if scoUsePrettyText in v then Inc(Result, poscoUsePrettyText);
 if scoUseBuiltInTimer in v then Inc(Result, poscoUseBuiltInTimer);
 if scoEndCharCompletion in v then Inc(Result, poscoEndCharCompletion);
 if scoConsiderWordBreakChars in v then Inc(Result, poscoConsiderWordBreakChars);
 if scoCompleteWithTab in v then Inc(Result, poscoCompleteWithTab);
 if scoCompleteWithEnter in v then Inc(Result, poscoCompleteWithEnter);
// if scoLimitToMatchedTextAnywhere in v then Inc(Result, poscoLimitToMatchedTextAnywhere);

end;

procedure Multi_Set_ProposalOptions(SynCompleteProp : TSynCompletionProposal; Value: SYSINT);
 var v : TSynCompletionOptions;
begin
 v := [];
 //if (Value and poscoAnsiStrings) <> 0 then Include(v, scoAnsiStrings);
 if (Value and poscoCaseSensitive) <> 0 then Include(v, scoCaseSensitive);
 if (Value and poscoLimitToMatchedText) <> 0 then Include(v, scoLimitToMatchedText);
 if (Value and poscoTitleIsCentered) <> 0 then Include(v, scoTitleIsCentered);
 if (Value and poscoUseInsertList) <> 0 then Include(v, scoUseInsertList);
 if (Value and poscoUsePrettyText) <> 0 then Include(v, scoUsePrettyText);
 if (Value and poscoUseBuiltInTimer) <> 0 then Include(v, scoUseBuiltInTimer);
 if (Value and poscoEndCharCompletion) <> 0 then Include(v, scoEndCharCompletion);
 if (Value and poscoConsiderWordBreakChars) <> 0 then Include(v, scoConsiderWordBreakChars);
 if (Value and poscoCompleteWithTab) <> 0 then Include(v, scoCompleteWithTab);
 if (Value and poscoCompleteWithEnter) <> 0 then Include(v, scoCompleteWithEnter);
// if (Value and poscoLimitToMatchedTextAnywhere) <> 0 then Include(v, scoLimitToMatchedTextAnywhere);
 SynCompleteProp.Options := v;
end;

function TSTCPD_Editor.Get_ProposalOptions: SYSINT;
begin
  Result := Multi_Get_ProposalOptions(SynCompleteProp);
end;

function TSTCPD_Editor.Get_ProposalType: TxProposalType;
begin
  Result := TxProposalType(SynCompleteProp.DefaultType);
end;

function TSTCPD_Editor.Get_ReadOnly: SYSINT;
begin
  Result := ord(SynEdit1.ReadOnly);
end;

function TSTCPD_Editor.Get_SecondEndOfTokenChar: WideString;
begin
  Result := SecondProposal.EndOfTokenChr;
end;

function TSTCPD_Editor.Get_SecondNbItemsInWindow: SYSINT;
begin
  Result := SecondProposal.NbLinesInWindow;
end;

function TSTCPD_Editor.Get_SecondPoprosalColumns: WideString;
begin
  Result := Multi_Get_ProposalColumns(SecondProposal);
end;

function TSTCPD_Editor.Get_SecondProposalInsertList: WideString;
begin
  Result := SecondProposal.InsertList.CommaText;
end;

function TSTCPD_Editor.Get_SecondProposalItemList: WideString;
begin
  Result := SecondProposal.ItemList.CommaText;
end;

function TSTCPD_Editor.Get_SecondProposalOptions: SYSINT;
begin
  Result := Multi_Get_ProposalOptions(SecondProposal);
end;

function TSTCPD_Editor.Get_SecondProposalType: TxProposalType;
begin
  Result := TxProposalType(SecondProposal.DefaultType);
end;

function TSTCPD_Editor.Get_SecondProposalWidth: SYSINT;
begin
  Result := SecondProposal.Width;
end;

function TSTCPD_Editor.Get_SecondShortCutKey: WideString;
begin
  Result := ShortCutToText(SecondProposal.ShortCut);
end;

function TSTCPD_Editor.Get_SecondTimerInterval: SYSINT;
begin
  Result := SecondProposal.TimerInterval;
end;

function TSTCPD_Editor.Get_SecondTriggerChars: WideString;
begin
  Result := SecondProposal.TriggerChars;
end;

function TSTCPD_Editor.Get_ShowText: WideString;
begin
  Result := SynEdit1.Lines.Text;
end;

function TSTCPD_Editor.Get_TextCursorIndex: SYSINT;
begin
  Result := SynEdit1.SelStart;
end;

function TSTCPD_Editor.Get_XCoord: SYSINT;
begin
  Result := SynEdit1.CaretX;
end;

function TSTCPD_Editor.Get_YCoord: SYSINT;
begin
  Result := SynEdit1.CaretY;
end;

procedure TSTCPD_Editor.GutterClickEvent(Button: TxMouseButton; X, Y,
  Line: SYSINT);
begin

end;

function TSTCPD_Editor.GetBookMark(BookMark: SYSINT; var X, Y: SYSINT): SYSINT;
begin
  Result := ord(Synedit1.GetBookMark(BookMark, X, Y));
end;

function TSTCPD_Editor.GetDebugInfo(command: SYSINT; var parameter: SYSINT): WideString;
var i : Integer;
begin
  Result := '';
  case command of
  1: begin //get array modif names
      for i:= 0 to pred(SynSTCPDSyn1.AttrCount) do
        begin
         if i <> 0 then Result := Result + '|';
            Result := Result + SynSTCPDSyn1.Attribute[i].Name + '=' + AttrtoStr(SynSTCPDSyn1.Attribute[i]);
        end;
     end;
  end;
end;

function TSTCPD_Editor.InternalSelectFontDialog: SYSINT;
  var Status : Boolean;
begin
  FontDialog1.Font := SynEdit1.Font;
  Status := FontDialog1.Execute;
  if Status then SynEdit1.Font := FontDialog1.Font;
  Result := ord(Status);
end;

procedure TSTCPD_Editor.ClearBookMark(BookMark: SYSINT);
begin
  SynEdit1.ClearBookMark(BookMark);
end;

procedure TSTCPD_Editor.ContextHelpEvent(ASender: TObject; const CurrWord,
  CurrLine: WideString; CursorPos: SYSINT);
begin

end;

procedure TSTCPD_Editor.Copy_Clip;
var s : widestring;
begin
  try
    SynEdit1.CopyToClipboard;
  except on E: Exception do begin
    s := 'Exception during copying to clipboard: '#13#10 + e.Message;
    MessageBox(self.Handle, PWideChar(s), 'Clipboard Error', MB_ICONERROR);
  end;
  end;
end;

procedure TSTCPD_Editor.CursorIndexToXY(CurIdx: SYSINT; out TextX, TextY: SYSINT);
var b : TBufferCoord;
begin
 b := SynEdit1.CharIndexToRowCol(CurIdx);
 TextX := b.Char;
 TextY := b.Line;
end;

procedure TSTCPD_Editor.Cut_Clip;
var s : widestring;
begin
  try
    SynEdit1.CutToClipboard;
  except on E: Exception do begin
    s := 'Exception during cuting to clipboard: '#13#10 + e.Message;
    MessageBox(self.Handle, PWideChar(s), 'Clipboard Error', MB_ICONERROR);
  end;
  end;
end;

procedure TSTCPD_Editor.DisplayToXYCoord(ScreenX, ScreenY: SYSINT; out TextLine, TextChar: SYSINT);
var tp : TBufferCoord;
    dp : TDisplayCoord;
    p : TPoint;
begin
  p.X := ScreenX;
  p.Y := ScreenY;
  p := SynEdit1.ScreenToClient(p);
  dp := SynEdit1.PixelsToNearestRowColumn(p.X, p.Y);
  tp := SynEdit1.DisplayToBufferPos(dp);
  TextLine := tp.Line;
  TextChar := tp.Char;
end;

procedure TSTCPD_Editor.DropFilesEvent(X, Y: SYSINT; const AFiles: WideString);
begin
  if FEvents <> nil then FEvents.OnDropFiles(X, Y, AFiles);
end;

procedure TSTCPD_Editor.EditorKeyDownEvent(var Key: Smallint;
  ShiftState: SYSINT);
begin
  if FEvents <> nil then FEvents.OnEditorKeyDown(Key, ShiftState);
end;

procedure TSTCPD_Editor.EditorKeyPressEvent(var Key: Smallint);
begin
  if FEvents <> nil then FEvents.OnEditorKeyPress(Key);
end;

procedure TSTCPD_Editor.EditorKeyUpEvent(var Key: Smallint; ShiftState: SYSINT);
begin
  if FEvents <> nil then FEvents.OnEditorKeyUp(Key, ShiftState);
end;

procedure TSTCPD_Editor.EditorMouseCursorEvent(CharIndex, LineIndex: SYSINT;
  var aCursor: SYSINT);
begin
  if FEvents <> nil then FEvents.OnEditorMouseCursor(CharIndex, LineIndex, aCursor);
end;

procedure TSTCPD_Editor.EnsureCursorPosVisible(ForceToMiddle: WordBool);
begin
  SynEdit1.EnsureCursorPosVisibleEx(ForceToMiddle);
end;

function ConvertOptions(A : SysInt):TSynSearchOptions;
var ret : TSynSearchOptions;
begin
 ret := [];
 if (A and $1 <> 0) then Include(ret, ssoMatchCase);
 if (A and $2 <> 0) then Include(ret, ssoWholeWord);
 if (a and $4 <> 0) then Include(ret, ssoBackwards);
 if (a and $8 <> 0) then Include(ret, ssoEntireScope);
 if (a and $10 <> 0) then Include(ret, ssoSelectedOnly);
 if (a and $20 <> 0) then Include(ret, ssoReplace);
 if (a and $40 <> 0) then Include(ret, ssoReplaceAll);
 if (a and $80 <> 0) then Include(ret, ssoPrompt);
 ConvertOptions := ret;
end;

procedure TSTCPD_Editor.Find_Clip(const SearchStr: WideString; FindStart, FindLen,
          Options: SYSINT);
var {i, ii  : Integer;
     old_selStart : Integer;}
     AAOptions : TSynSearchOptions;
begin
 //SynEditor.SearchReplace(gsSearchText, gsReplaceText, Options) = 0
 AAOptions := ConvertOptions(Options);
// Include(AAOptions, ssoEntireScope);
{ old_selStart := SynEdit1.SelStart;
 SynEdit1.SelStart := FindStart;}
 SynEdit1.SearchReplace(SearchStr, '', AAOptions);
{ if i = 0
   then
     SynEdit1.SelStart := old_selStart
   else
     begin
       ii := 0;
       if ssoBackwards in AAOptions
         then
           begin
             while ((ii < i ) and (SynEdit1.SearchEngine.Results[ii] < FindStart))
               do Inc(ii);

             if ii < i then //znaleziono >= start
                Dec(ii);

             if ((ii >= 0) and (ii < SynEdit1.SearchEngine.ResultCount))
                then
                  SynEdit1.SelStart := SynEdit1.SearchEngine.Results[ii]
                else
                  SynEdit1.SelStart := old_selStart;
           end
         else
           begin
             while ((ii < i ) and (SynEdit1.SearchEngine.Results[ii] <= FindStart))
               do Inc(ii);

             if ((ii >= 0) and (ii < SynEdit1.SearchEngine.ResultCount))
                then
                  SynEdit1.SelStart := SynEdit1.SearchEngine.Results[ii]
                else
                  SynEdit1.SelStart := old_selStart;

             SynEdit1.SelStart := SynEdit1.SearchEngine.Results[0];
           end
     end;}
end;

procedure TSTCPD_Editor.InsertAtCursor(const Tekst: WideString);
var b : TBufferCoord;
    s : WideString;
begin
  b := SynEdit1.CharIndexToRowCol(SynEdit1.SelStart);
  S := SynEdit1.LineText;
  Insert(Tekst, S, b.Char);
  SynEdit1.LineText := S;
end;

procedure TSTCPD_Editor.InternalFindReplaceDlg(NewVisible: SYSINT; const InitFind,
          InitReplace: WideString; out OutResult: SYSINT);
begin
  OutResult := ord(fReplaceDialog1_Visible);
  case (NewVisible and $F) of
  0 : ReplaceDialog1.CloseDialog;
  1 : begin
        if (NewVisible and $10) <> 0 then ReplaceDialog1.FindText := InitFind;
        if (NewVisible and $20) <> 0 then ReplaceDialog1.ReplaceText := InitReplace;
        ReplaceDialog1.Execute;
      end;
  2 : begin end;
  else OutResult := -1;
  end;
end;

procedure TSTCPD_Editor.LoadLinesFromFile(const FileName: WideString);
begin
  SynEdit1.Lines.LoadFromFile(FileName);
end;

procedure TSTCPD_Editor.Paste_Clip;
var s : widestring;
begin
  try
    SynEdit1.PasteFromClipboard;
  except on E: Exception do begin
    s := 'Exception during pasting from clipboard: '#13#10 + e.Message;
    MessageBox(self.Handle, PWideChar(s), 'Clipboard Error', MB_ICONERROR);
  end;
  end;
end;

procedure TSTCPD_Editor.PrimeProposalCancel;
begin
  SynCompleteProp.CancelCompletion;
end;

procedure TSTCPD_Editor.PrimeProposalChangeEvent(AIndex: SYSINT);
begin
  if FEvents <> nil then FEvents.OnPrimeProposalChange(AIndex);
end;

procedure TSTCPD_Editor.PrimeProposalExecute;
begin
  SynCompleteProp.ActivateCompletion;
end;

procedure TSTCPD_Editor.Redo_Clip;
begin
  SynEdit1.Redo;
end;

procedure TSTCPD_Editor.ReplaceDialog1Close(Sender: TObject);
begin
  fReplaceDialog1_Visible := False;
end;

procedure TSTCPD_Editor.ReplaceDialog1Find(Sender: TObject);
var AAOptions : TSynSearchOptions;
begin
 if frDown in ReplaceDialog1.Options then AAOptions := []
                                     else AAOptions := [ssoBackwards];
 if frReplace in ReplaceDialog1.Options then Include(AAOptions, ssoReplace);
 if frReplaceAll in ReplaceDialog1.Options then Include(AAOptions, ssoReplaceAll);
 if frMatchCase in ReplaceDialog1.Options then Include(AAOptions, ssoMatchCase);
 if frWholeWord in ReplaceDialog1.Options then Include(AAOptions, ssoWholeWord);

 SynEdit1.SearchReplace(ReplaceDialog1.FindText, ReplaceDialog1.ReplaceText, AAOptions);
end;

procedure TSTCPD_Editor.ReplaceDialog1Show(Sender: TObject);
begin
  fReplaceDialog1_Visible := True;
end;

procedure TSTCPD_Editor.SaveLinesToFile(const FileName: WideString);
begin
  SynEdit1.Lines.SaveToFile(FileName);
end;

function ShiftState_ToInt(shift : TShiftState):Integer;
begin
 Result := 0;
 if ssShift in Shift then inc(Result, $1);
 if ssAlt in Shift then inc(Result, $2);
 if ssCtrl in Shift then inc(Result, $4);
 if ssLeft in Shift then inc(Result, $8);
 if ssRight in Shift then inc(Result, $10);
 if ssMiddle in Shift then inc(Result, $20);
 if ssDouble in Shift then inc(Result, $40);
end;

function IntTo_ShiftState(sh : Integer):TShiftState;
begin
 Result := [];
 if (sh and $1) <> 0 then Include(Result, ssShift);
 if (sh and $2) <> 0 then Include(Result, ssAlt);
 if (sh and $4) <> 0 then Include(Result, ssCtrl);
 if (sh and $8) <> 0 then Include(Result, ssLeft);
 if (sh and $10) <> 0 then Include(Result, ssRight);
 if (sh and $20) <> 0 then Include(Result, ssMiddle);
 if (sh and $40) <> 0 then Include(Result, ssDouble);
end;

procedure TSTCPD_Editor.SecondAfterCodeCompletionEvent(const Value: WideString;
  ShiftState : SYSINT; Index: SYSINT; EndToken: Smallint);
begin
  if FEvents <> nil then FEvents.OnSecondAfterCodeCompletion(Value, ShiftState, Index, EndToken);
end;

procedure TSTCPD_Editor.SecondCloseEvent;
begin
  if FEvents <> nil then FEvents.OnSecondClose();
end;

procedure TSTCPD_Editor.SecondCodeCompletionEvent(var Value: WideString;
  ShiftState, Index: SYSINT; EndTokenChar: Smallint);
begin
  if FEvents <> nil then FEvents.OnSecondCodeCompletion(Value, ShiftState, Index, EndTokenChar);
end;

procedure TSTCPD_Editor.SecondCompletionExecuteEvent(Kind: TxProposalType;
  var CurrentInput: WideString; var X, Y: SYSINT; var CanExecute: WordBool);
begin
  if FEvents <> nil then FEvents.OnSecondCompletionExecute(Kind, CurrentInput, X, Y, CanExecute);
end;

procedure TSTCPD_Editor.SecondParameterTokenEvent(Sender: TObject; Key: WideChar; var CurrentIndex, Level: Integer);
 var IndexToDisplay : Integer;
     DisplayString: WideString;
begin
  DisplayString := 'dummy';
  IndexToDisplay := Integer($80000000);
  if FEvents <> nil then FEvents.OnSecondParameterToken(CurrentIndex, Level, IndexToDisplay, SmallInt(Key), DisplayString);
end;

procedure TSTCPD_Editor.SecondProposalAfterCodeCompletion(Sender: TObject;
  const Value: String; Shift: TShiftState; Index: Integer; EndToken: Char);
begin
  SecondAfterCodeCompletionEvent(Value, ShiftState_ToInt(Shift), Index, SmallInt(EndToken));
end;

procedure TSTCPD_Editor.SecondProposalCancel;
begin
  SecondProposal.CancelCompletion;
end;

procedure TSTCPD_Editor.SecondProposalCancelled(Sender: TObject);
begin
  SecondProposalCancelledEvent();
end;

procedure TSTCPD_Editor.SecondProposalCancelledEvent;
begin
  if FEvents <> nil then FEvents.OnSecondProposalCancelled();
end;

procedure TSTCPD_Editor.SecondProposalChange(Sender: TObject; AIndex: Integer);
begin
  SecondProposalChangeEvent(AIndex);
end;

procedure TSTCPD_Editor.SecondProposalChangeEvent(Aindex: SYSINT);
begin
  if FEvents <> nil then FEvents.OnSecondProposalChange(Aindex);
end;

procedure TSTCPD_Editor.SecondProposalClose(Sender: TObject);
begin
  SecondCloseEvent();
end;

procedure TSTCPD_Editor.SecondProposalCodeCompletion(Sender: TObject;
  var Value: String; Shift: TShiftState; Index: Integer; EndToken: Char);
var ws : WideString;
begin
 ws := Value;
 SecondCodeCompletionEvent(ws, ShiftState_ToInt(Shift), Index, SmallInt(EndToken));
 Value := ws;
end;

procedure TSTCPD_Editor.SecondProposalDoPropExecute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: String; var x, y: Integer;
  var CanExecute: Boolean);
var ci : WideString;
    wb : WordBool;
begin
  ci := CurrentInput;
  wb := CanExecute;
  SecondCompletionExecuteEvent(TxProposalType(Kind), ci, x, y, wb);
  CanExecute := wb;
  CurrentInput := ci;
end;

procedure TSTCPD_Editor.SecondProposalExecute(const DisplayList, CompleteList: WideString;
          ProposalType: TxProposalType; ProposalPosX, ProposalPosY: SYSINT);

begin
  SecondProposal.DefaultType := SynCompletionType(ProposalType);
  SecondProposal.ItemList.CommaText := Trim(DisplayList);
  SecondProposal.InsertList.CommaText := Trim(CompleteList);
  SecondProposal.ActivateCompletion;
end;

procedure TSTCPD_Editor.SecondProposalParameterToken(Sender: TObject;
  Key: WideChar; var CurrentIndex, Level: Integer);
begin
 SecondParameterTokenEvent(Sender, Key, CurrentIndex, Level);
end;

procedure TSTCPD_Editor.SecondProposalShow(Sender: TObject);
begin
  ShowSecondProposalEvent;
end;

procedure TSTCPD_Editor.SelectAll_Clip;
begin
  SynEdit1.SelectAll;
end;

procedure TSTCPD_Editor.Set_BgrColor(Value: OLE_COLOR);
begin
  SynEdit1.Color := TColor(Value);
end;

procedure TSTCPD_Editor.Set_CompleteList(const Value: WideString);
begin
  SynCompleteProp.InsertList.CommaText := Value;
end;

procedure TSTCPD_Editor.Set_Current_Line(const Value: WideString);
begin
  SynEdit1.LineText := Value;
end;

procedure TSTCPD_Editor.Set_Current_Word(const Value: WideString);
var
  bBegin: TBufferCoord;
  bEnd, pozycja: TBufferCoord;
  S, slowo : String;
  i : Integer;
begin
  pozycja := SynEdit1.CaretXY;
  bBegin := SynEdit1.BlockBegin;
  bEnd := SynEdit1.BlockEnd;
  S := SynEdit1.LineText;
  slowo := SynEdit1.WordAtCursor;
  i := pozycja.Char - Length(slowo);
  if i < 1 then i := 1;
  i := PosEx(slowo, S, i);
  if i > 0 then begin
                Delete(S, i, Length(slowo));
                Insert(Value, S, i);
                SynEdit1.CaretX := i + Length(Value);
                SynEdit1.LineText := S;
                end;
  SynEdit1.BlockBegin := bBegin;
  SynEdit1.BlockEnd := bEnd;
end;

procedure TSTCPD_Editor.Set_CurrentLineColor(Value: OLE_COLOR);
begin
  SynEdit1.ActiveLineColor := TColor(Value);
end;

procedure TSTCPD_Editor.Set_DisplayList(const Value: WideString);
begin
  SynCompleteProp.ItemList.CommaText := Value;
end;

procedure TSTCPD_Editor.Set_DisplaySTSyntaxOptions(Value: TxSTSyntaxOptions);
begin
  SynSTCPDSyn1.Options := DeConvertOptionsFromTxSTSyntaxOptions(Value);
end;

procedure TSTCPD_Editor.Set_EditorOptions(const Value: WideString);
var no : TSynEditorOptions;
     sr : TSynEditorScrollOptions;
     r : TStringList;
     s : String;
  i: Integer;
  bo : Boolean;
begin
 no := [];
 sr := [];
 bo := false;
 r := TStringList.Create;
 r.CommaText := Value;
 for i := 0 to r.Count - 1 do
   begin
     s := r.Strings[i];
//     if s = 'eoAltSetsColumnMode' then Include(no, eoAltSetsColumnMode);
     if s = 'eoAutoIndent' then Include(no, eoAutoIndent);
//     if s = 'eoAutoSizeMaxScrollWidth' then Include(no, eoAutoSizeMaxScrollWidth);
     if s = 'eoDisableScrollArrows' then Include(sr, eoDisableScrollArrows);
     if s = 'eoDragDropEditing' then Include(no, eoDragDropEditing);
     if s = 'eoDropFiles' then Include(no, eoDropFiles);
     if s = 'eoEnhanceHomeKey' then Include(no, eoEnhanceHomeKey);
     if s = 'eoEnhanceEndKey' then Include(no, eoEnhanceEndKey);
     if s = 'eoGroupUndo' then Include(no, eoGroupUndo);
     if s = 'eoHalfPageScroll' then Include(sr, eoHalfPageScroll);
     if s = 'eoHideShowScrollbars' then Include(sr, eoHideShowScrollbars);
     if s = 'eoKeepCaretX' then Include(no, eoKeepCaretX);
     if s = 'eoNoCaret' then Include(no, eoNoCaret);
     if s = 'eoNoSelection' then Include(no, eoNoSelection);
     if s = 'eoRightMouseMovesCursor' then Include(no, eoRightMouseMovesCursor);
     if s = 'eoScrollByOneLess' then Include(sr, eoScrollByOneLess);
     if s = 'eoScrollHintFollows' then Include(sr, eoScrollHintFollows);
     if s = 'eoScrollPastEof' then Include(sr, eoScrollPastEof);
     if s = 'eoScrollPastEol' then Include(sr, eoScrollPastEol);
     if s = 'eoShowScrollHint' then Include(sr, eoShowScrollHint);
//     if s = 'eoShowSpecialChars' then Include(no, eoShowSpecialChars);
     if s = 'eoSmartTabDelete' then Include(no, eoSmartTabDelete);
     if s = 'eoSmartTabs' then Include(no, eoSmartTabs);
     if s = 'eoSpecialLineDefaultFg' then Include(no, eoSpecialLineDefaultFg);
     if s = 'eoTabIndent' then Include(no, eoTabIndent);
     if s = 'eoTabsToSpaces' then Include(no, eoTabsToSpaces);
     if s = 'eoTrimTrailingSpaces' then Include(no, eoTrimTrailingSpaces);
     if s = 'eoShowLigatures' then Include(no, eoShowLigatures);
     if s = 'eoCopyPlainText' then Include(no, eoCopyPlainText);
     if s = 'eoNoHTMLBackground' then Include(no, eoNoHTMLBackground);
     if s = 'eoWrapWithRightEdge' then Include(no, eoWrapWithRightEdge);
     if s = 'eoBracketsHighlight' then Include(no, eoBracketsHighlight);
     if s = 'eoAccessibility' then Include(no, eoAccessibility);
     if s = 'eoCompleteBrackets' then Include(no, eoCompleteBrackets);
     if s = 'eoCompleteQuotes' then Include(no, eoCompleteQuotes);

     if s = 'eoDisableScrollArrows' then Include(sr, eoDisableScrollArrows);
     if s = 'eoHalfPageScroll' then Include(sr, eoHalfPageScroll);
     if s = 'eoHideShowScrollbars' then Include(sr, eoHideShowScrollbars);
     if s = 'usrShowIndentGuides' then bo := true;
   end;
 SynEdit1.Options := no;
 SynEdit1.ScrollOptions := sr;
 SynEdit1.IndentGuides.Visible := bo;
end;

procedure TSTCPD_Editor.Set_EmuTabSize(Value: SYSINT);
begin
  SynEdit1.TabWidth := Value;
end;

procedure TSTCPD_Editor.Set_HighlightFontString(const Value: WideString);
var L : TStringList;
    i : Integer;
begin
 L := TStringList.Create;
 L.CommaText := Value;
 I := L.Count;
 if i > 0 then
   SynEdit1.Font.Name := L.Strings[0];
 if i > 1 then
     SynEdit1.Font.Height := StrToIntDef(L.Strings[1], SynEdit1.Font.Height);
 if i > 2 then
     SynEdit1.Font.Charset := StrToIntDef(L.Strings[2], SynEdit1.Font.Charset);
 L.Free;
end;

procedure TSTCPD_Editor.Set_HighlightSet(const Value: WideString);
var i, j : Integer;
  var Arg : array of String;
  var LocalString : WideString;
begin
  LocalString := Value;
  SetLength(Arg, Self.SynSTCPDSyn1.AttrCount);
  for i := 0 to Pred(Self.SynSTCPDSyn1.AttrCount) do
   Arg[i] := '';

  j := 0;
  LocalString := Trim(Value);
  while Length(LocalString) > 0 do
  begin
   i := Pos('|', LocalString);
   if i = 0 then i := Length(LocalString) + 1;
   Arg[j] := Trim(Copy(LocalString, 1, i - 1));
   Delete(LocalString, 1, i);
   Inc(j);
  end;
  SetGroupAttribs(Arg);
  for i := 0 to Pred(Self.SynSTCPDSyn1.AttrCount) do
   Arg[i] := '';
  SetLength(Arg, 0);
end;

procedure TSTCPD_Editor.Set_ModifiedFlag(Value: SYSINT);
begin
  SynEdit1.Modified := Value <> 0;
end;

procedure TSTCPD_Editor.Set_ParentEditorWindowHandle(Value: Int64);
begin
 {$IFDEF SJ_ACTIVEX}
 SynCompleteProp.AppWinSend := HWND(Value);
 SecondProposal.AppWinSend := HWND(Value);
 {$ENDIF}
end;

procedure TSTCPD_Editor.Set_PrimeEndOfTokenChar(const Value: WideString);
begin
  SynCompleteProp.EndOfTokenChr := Value;
end;

procedure TSTCPD_Editor.Set_PrimeNbItemsInWindow(Value: SYSINT);
begin
  SynCompleteProp.NbLinesInWindow := Value;
end;

procedure TSTCPD_Editor.Set_PrimeProposalWidth(Value: SYSINT);
begin
  SynCompleteProp.Width := Value;
end;

procedure TSTCPD_Editor.Set_PrimeShortCutKey(const Value: WideString);
begin
  SynCompleteProp.ShortCut := Menus.TextToShortCut(Value);
end;

procedure TSTCPD_Editor.Set_PrimeTimerInterval(Value: SYSINT);
begin
  SynCompleteProp.TimerInterval := Value;
end;

procedure TSTCPD_Editor.Set_PrimeTriggerChars(const Value: WideString);
begin
  SynCompleteProp.TriggerChars := Value;
end;

procedure TSTCPD_Editor.Set_ProposalColumns(const Value: WideString);
begin
  Multi_Set_ProposalColumns(SynCompleteProp, Value);
end;

procedure TSTCPD_Editor.Set_ProposalOptions(Value: SYSINT);
begin
  Multi_Set_ProposalOptions(SynCompleteProp, Value);
end;

procedure TSTCPD_Editor.Set_ProposalType(Value: TxProposalType);
begin
  SynCompleteProp.DefaultType := SynCompletionType(Value);
end;

procedure TSTCPD_Editor.Set_ReadOnly(Value: SYSINT);
begin
  SynEdit1.ReadOnly := Value <> 0;
end;

procedure TSTCPD_Editor.Set_SecondEndOfTokenChar(const Value: WideString);
begin
  SecondProposal.EndOfTokenChr := Value;
end;

procedure TSTCPD_Editor.Set_SecondNbItemsInWindow(Value: SYSINT);
begin
  SecondProposal.NbLinesInWindow := Value;
end;

procedure TSTCPD_Editor.Set_SecondPoprosalColumns(const Value: WideString);
begin
  Multi_Set_ProposalColumns(SecondProposal, Value);
end;

procedure TSTCPD_Editor.Set_SecondProposalInsertList(const Value: WideString);
begin
  SecondProposal.InsertList.CommaText := Value;
end;

procedure TSTCPD_Editor.Set_SecondProposalItemList(const Value: WideString);
begin
  SecondProposal.ItemList.CommaText := Value;
end;

procedure TSTCPD_Editor.Set_SecondProposalOptions(Value: SYSINT);
begin
  Multi_Set_ProposalOptions(SecondProposal, Value);
end;

procedure TSTCPD_Editor.Set_SecondProposalType(Value: TxProposalType);
begin
  SecondProposal.DefaultType := SynCompletionType(Value);
end;

procedure TSTCPD_Editor.Set_SecondProposalWidth(Value: SYSINT);
begin
  SecondProposal.Width := Value;
end;

procedure TSTCPD_Editor.Set_SecondShortCutKey(const Value: WideString);
begin
  SecondProposal.ShortCut := Menus.TextToShortCut(Value);
end;

procedure TSTCPD_Editor.Set_SecondTimerInterval(Value: SYSINT);
begin
  SecondProposal.TimerInterval := Value;
end;

procedure TSTCPD_Editor.Set_SecondTriggerChars(const Value: WideString);
begin
  SecondProposal.TriggerChars := Value;
end;

procedure TSTCPD_Editor.Set_ShowText(const Value: WideString);
begin
  SynEdit1.Lines.Text := Value;
end;

procedure TSTCPD_Editor.Set_TextCursorIndex(Value: SYSINT);
begin
  SynEdit1.SelStart := Value;
end;

procedure TSTCPD_Editor.Set_XCoord(Value: SYSINT);
begin
  SynEdit1.CaretX := Value;
end;

procedure TSTCPD_Editor.Set_YCoord(Value: SYSINT);
begin
  SynEdit1.CaretY := Value;
end;

procedure TSTCPD_Editor.ShowCtxEvent(ASender: TObject; const Line: WideString;
  PosInLine: SYSINT; var CurrWord: WideString; out CompleteList,
  DisplayList: WideString);
begin
  if FEvents <> nil then FEvents.OnShowCtx(Line, PosInLine, CurrWord, CompleteList, DisplayList);
end;

procedure TSTCPD_Editor.ShowSecondProposalEvent;
begin
  if FEvents <> nil then FEvents.OnShowSecondProposal();
end;

procedure TSTCPD_Editor.SpecialLineColorsEvent(Line: SYSINT;
  var Special: SYSINT; var FgColor, BgColor: OLE_COLOR);
begin
  if FEvents <> nil then FEvents.OnSpecialLineColors(Line, Special, FgColor, BgColor);
end;

procedure TSTCPD_Editor.SynCompletePropChange(Sender: TObject; AIndex: Integer);
begin
  PrimeProposalChangeEvent(AIndex);
end;

procedure TSTCPD_Editor.SynCompletePropExecute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: String; var x, y: Integer;
  var CanExecute: Boolean);
var CurrLine : WideString;
      CompleteListW : WideString;
      CurrentInputW : WideString;
      DisplayListW : WideString;
begin
 CurrLine := SynEdit1.LineText;
 CurrentInputW := CurrentInput;
 CompleteListW := SynCompleteProp.InsertList.CommaText;
 DisplayListW := SynCompleteProp.ItemList.CommaText;
 ShowCtxEvent(Sender, CurrLine, SynEdit1.CaretX, CurrentInputW, CompleteListW, DisplayListW);
 CompleteListW := Trim(CompleteListW);
 DisplayListW := Trim(DisplayListW);
 SynCompleteProp.ItemList.BeginUpdate;
 SynCompleteProp.InsertList.BeginUpdate;
 if Length(CompleteListW) > 0
   then
     SynCompleteProp.InsertList.CommaText := CompleteListW
   else
     SynCompleteProp.InsertList.Clear;
 if Length(DisplayListW) > 0
   then
     SynCompleteProp.ItemList.CommaText := DisplayListW
   else
     SynCompleteProp.ItemList.Clear;

 SynCompleteProp.InsertList.EndUpdate;
 SynCompleteProp.ItemList.EndUpdate;
end;

procedure TSTCPD_Editor.SynEdit1ContextHelp(Sender: TObject; word: String);
var CurrLineW, wordW : WideString;

begin
 CurrLineW := SynEdit1.LineText;
 wordW := word;
 ContextHelpEvent(Sender, wordW, CurrLineW, SynEdit1.CaretX);
end;

procedure TSTCPD_Editor.SynEdit1DropFiles(Sender: TObject; X, Y: Integer;
  AFiles: TStrings);
begin
  DropFilesEvent(X,Y, AFiles.CommaText);
end;

procedure TSTCPD_Editor.SynEdit1GutterClick(Sender: TObject;
  Button: TMouseButton; X, Y, Line: Integer; Mark: TSynEditMark);
begin
  GutterClickEvent(TxMouseButton(Button), X, Y, Line);
end;

procedure TSTCPD_Editor.SynEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var  k : SmallInt;
begin
 k := Key;
 EditorKeyDownEvent(k, ShiftState_ToInt(Shift));
 Key := k;
end;

procedure TSTCPD_Editor.SynEdit1KeyPress(Sender: TObject; var Key: Char);
var k : SmallInt;
begin
 k := ord(Key);
 EditorKeyPressEvent(k);
 Key := Char(k);
end;

procedure TSTCPD_Editor.SynEdit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var  k : SmallInt;
begin
 k := Key;
 EditorKeyUpEvent(k, ShiftState_ToInt(Shift));
 Key := k;
end;

procedure TSTCPD_Editor.SynEdit1MouseCursor(Sender: TObject;
  const aLineCharPos: TBufferCoord; var aCursor: TCursor);
var i : Integer;
begin
 i := Integer(aCursor);
 EditorMouseCursorEvent(aLineCharPos.Char, aLineCharPos.Line, i);
 aCursor := TCursor(i);
end;

procedure TSTCPD_Editor.SynEdit1SpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
  var spbool : Integer;
      fgc, bgc : OLE_COLOR;
begin
spbool := ord(Special);
fgc := OLE_COLOR(FG);
bgc := OLE_COLOR(BG);
SpecialLineColorsEvent(Line, spbool, FGc, BGc);
Special := spbool <> 0;
FG := TColor(fgc);
BG := TColor(bgc);
end;

procedure TSTCPD_Editor.SetBookMark(BookMark, X, Y: SYSINT);
begin
  SynEdit1.SetBookMark(BookMark, X, Y);
end;

procedure TSTCPD_Editor.SetGroupAttribs(const AttrGrp: array of String);
var  i{, a, offset}: integer;
  Attr: TSynHighlighterAttributes;
  ts : string;
begin
 for i:= 0 to Min(pred(SynSTCPDSyn1.AttrCount), High(AttrGrp)) do
  begin
    ts := SynSTCPDSyn1.Attribute[i].Name;
    attr:= TSynHighlighterAttributes.Create(ts, ts);
    try
      StrtoAttr(Attr, AttrGrp[i]);
      SynSTCPDSyn1.Attribute[i].Assign(Attr);

{      a:= SynEdit1.IndexOfName(cpp.Attribute[i].Name);
      if a = -1 then
        devEditor.Syntax.Append(format('%s=%s', [cpp.Attribute[i].Name, AttrtoStr(Attr)]))
      else
        devEditor.Syntax.Values[cpp.Attribute[i].Name]:= AttrtoStr(Attr);}
    finally
      Attr.Free;
    end;
  end;
end;

procedure TSTCPD_Editor.Undo_Clip;
begin
  SynEdit1.Undo;
end;

procedure TSTCPD_Editor.XYCoordToDisplay(TextLine, TextChar: SYSINT; out ScreenX,
          ScreenY: SYSINT);
var tp : TBufferCoord;
    dp : TDisplayCoord;
    p : TPoint;
begin
 tp.Char := TextChar;
 tp.Line := TextLine;
 dp := SynEdit1.BufferToDisplayPos(tp);
 p := SynEdit1.RowColumnToPixels(dp);
 p := SynEdit1.ClientToScreen(p);
 ScreenX := p.X;
 ScreenY := p.y;
end;

procedure TSTCPD_Editor.XYToCursorIndex(TextX, TextY: SYSINT; out CurIdx: SYSINT);
var b : TBufferCoord;
begin
 b.Char := TextX;
 b.Line := TextY;
 CurIdx := SynEdit1.RowColToCharIndex(b);
end;

initialization
  TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    TSTCPD_Editor,
    Class_STCPD_Editor,
    0,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmApartment);
end.
