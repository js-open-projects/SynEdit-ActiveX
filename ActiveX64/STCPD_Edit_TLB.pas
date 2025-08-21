unit STCPD_Edit_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 98336 $
// File generated on 02.08.2025 18:42:35 from Type Library described below.

// ************************************************************************  //
// Type Lib: F:\Projekty\CPDev\CPDev_FBD\CPDev_root\src\Utils\STCPD_Edit_other\ActiveX64\STCPD_Edit (1)
// LIBID: {7006466C-8247-4E6C-BE6E-FC0FEA110483}
// LCID: 0
// Helpfile:
// HelpString: Library for ST editor in CPDev
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleCtrls, Winapi.ActiveX;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  STCPD_EditMajorVersion = 0;
  STCPD_EditMinorVersion = 8;

  LIBID_STCPD_Edit: TGUID = '{7006466C-8247-4E6C-BE6E-FC0FEA110483}';

  IID_ISTCPD_Editor: TGUID = '{FFD550BB-85C9-45C6-9925-88D819EF523B}';
  DIID_ISTCPD_EditorEvents: TGUID = '{76629B13-8766-4AEE-9DC8-85BD44CFA458}';
  CLASS_STCPD_Editor: TGUID = '{E920F4E8-4FB9-4355-AA0F-21C64F5384D5}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum TxActiveFormBorderStyle
type
  TxActiveFormBorderStyle = TOleEnum;
const
  afbNone = $00000000;
  afbSingle = $00000001;
  afbSunken = $00000002;
  afbRaised = $00000003;

// Constants for enum TxPrintScale
type
  TxPrintScale = TOleEnum;
const
  poNone = $00000000;
  poProportional = $00000001;
  poPrintToFit = $00000002;

// Constants for enum TxMouseButton
type
  TxMouseButton = TOleEnum;
const
  mbLeft = $00000000;
  mbRight = $00000001;
  mbMiddle = $00000002;

// Constants for enum TxPopupMode
type
  TxPopupMode = TOleEnum;
const
  pmNone = $00000000;
  pmAuto = $00000001;
  pmExplicit = $00000002;

// Constants for enum TxProposalType
type
  TxProposalType = TOleEnum;
const
  ptctCode = $00000000;
  ptctHint = $00000001;
  ptctParam = $00000002;

// Constants for enum TxProposalOptions
type
  TxProposalOptions = TOleEnum;
const
  poscoAnsiStrings = $00000001;
  poscoCaseSensitive = $00000002;
  poscoLimitToMatchedText = $00000004;
  poscoTitleIsCentered = $00000008;
  poscoUseInsertList = $00000010;
  poscoUsePrettyText = $00000020;
  poscoUseBuiltInTimer = $00000040;
  poscoEndCharCompletion = $00000080;
  poscoConsiderWordBreakChars = $00000100;
  poscoCompleteWithTab = $00000200;
  poscoCompleteWithEnter = $00000400;
  poscoLimitToMatchedTextAnywhere = $00000800;

// Constants for enum TxSTSyntaxOptions
type
  TxSTSyntaxOptions = TOleEnum;
const
  stsoEnableCppComment = $00000001;
  stsoEnableNestedComments = $00000002;
  stsoAllowSpecialProc = $00000004;
  stsoAllowVerifDirect = $00000008;
  stsoUseFINTAsType = $00000010;
  stsoUseClassesSyntax = $00000020;
  stsoUseTryCatchSyntax = $00000040;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  ISTCPD_Editor = interface;
  ISTCPD_EditorDisp = dispinterface;
  ISTCPD_EditorEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  STCPD_Editor = ISTCPD_Editor;


// *********************************************************************//
// Declaration of structures, unions and aliases.
// *********************************************************************//
  PPUserType1 = ^IFontDisp; {*}


// *********************************************************************//
// Interface: ISTCPD_Editor
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FFD550BB-85C9-45C6-9925-88D819EF523B}
// *********************************************************************//
  ISTCPD_Editor = interface(IDispatch)
    ['{FFD550BB-85C9-45C6-9925-88D819EF523B}']
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_AutoScroll: WordBool; safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    function Get_AutoSize: WordBool; safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;
    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;
    function Get_BorderWidth: Integer; safecall;
    procedure Set_BorderWidth(Value: Integer); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    function Get_Color: OLE_COLOR; safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    function Get_KeyPreview: WordBool; safecall;
    procedure Set_KeyPreview(Value: WordBool); safecall;
    function Get_PrintScale: TxPrintScale; safecall;
    procedure Set_PrintScale(Value: TxPrintScale); safecall;
    function Get_Scaled: WordBool; safecall;
    procedure Set_Scaled(Value: WordBool); safecall;
    function Get_Active: WordBool; safecall;
    function Get_DropTarget: WordBool; safecall;
    procedure Set_DropTarget(Value: WordBool); safecall;
    function Get_HelpFile: WideString; safecall;
    procedure Set_HelpFile(const Value: WideString); safecall;
    function Get_PopupMode: TxPopupMode; safecall;
    procedure Set_PopupMode(Value: TxPopupMode); safecall;
    function Get_ScreenSnap: WordBool; safecall;
    procedure Set_ScreenSnap(Value: WordBool); safecall;
    function Get_SnapBuffer: Integer; safecall;
    procedure Set_SnapBuffer(Value: Integer); safecall;
    function Get_DockSite: WordBool; safecall;
    procedure Set_DockSite(Value: WordBool); safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    function Get_PixelsPerInch: Integer; safecall;
    procedure Set_PixelsPerInch(Value: Integer); safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_MouseInClient: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function Get_ParentDoubleBuffered: WordBool; safecall;
    procedure Set_ParentDoubleBuffered(Value: WordBool); safecall;
    function Get_IsDrawingLocked: WordBool; safecall;
    function Get_RedrawDisabled: WordBool; safecall;
    function Get_UseDockManager: WordBool; safecall;
    procedure Set_UseDockManager(Value: WordBool); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_CurrentPPI: Integer; safecall;
    function Get_ExplicitLeft: Integer; safecall;
    function Get_ExplicitTop: Integer; safecall;
    function Get_ExplicitWidth: Integer; safecall;
    function Get_ExplicitHeight: Integer; safecall;
    function Get_ScaleFactor: Single; safecall;
    function Get_StyleName: WideString; safecall;
    procedure Set_StyleName(const Value: WideString); safecall;
    function Get_RaiseOnNonMainThreadUsage: WordBool; safecall;
    procedure Set_RaiseOnNonMainThreadUsage(Value: WordBool); safecall;
    function Get_AlignWithMargins: WordBool; safecall;
    procedure Set_AlignWithMargins(Value: WordBool); safecall;
    function Get_ParentCustomHint: WordBool; safecall;
    procedure Set_ParentCustomHint(Value: WordBool); safecall;
    function Get_ShowText: WideString; safecall;
    procedure Set_ShowText(const Value: WideString); safecall;
    function Get_BgrColor: OLE_COLOR; safecall;
    procedure Set_BgrColor(Value: OLE_COLOR); safecall;
    function Get_HighlightSet: WideString; safecall;
    procedure Set_HighlightSet(const Value: WideString); safecall;
    function Get_ReadOnly: SYSINT; safecall;
    procedure Set_ReadOnly(Value: SYSINT); safecall;
    function Get_XCoord: SYSINT; safecall;
    procedure Set_XCoord(Value: SYSINT); safecall;
    function Get_YCoord: SYSINT; safecall;
    procedure Set_YCoord(Value: SYSINT); safecall;
    procedure Cut_Clip; safecall;
    procedure Copy_Clip; safecall;
    procedure Paste_Clip; safecall;
    procedure Undo_Clip; safecall;
    procedure Redo_Clip; safecall;
    procedure SelectAll_Clip; safecall;
    procedure Find_Clip(const SearchStr: WideString; FindStart: SYSINT; FindLen: SYSINT;
                        Options: SYSINT); safecall;
    procedure InsertAtCursor(const Tekst: WideString); safecall;
    function Get_Current_Line: WideString; safecall;
    procedure Set_Current_Line(const Value: WideString); safecall;
    function Get_Current_Word: WideString; safecall;
    procedure Set_Current_Word(const Value: WideString); safecall;
    function Get_TextCursorIndex: SYSINT; safecall;
    procedure Set_TextCursorIndex(Value: SYSINT); safecall;
    procedure CursorIndexToXY(CurIdx: SYSINT; out TextX: SYSINT; out TextY: SYSINT); safecall;
    procedure XYToCursorIndex(TextX: SYSINT; TextY: SYSINT; out CurIdx: SYSINT); safecall;
    function Get_CurrentLineColor: OLE_COLOR; safecall;
    procedure Set_CurrentLineColor(Value: OLE_COLOR); safecall;
    procedure LoadLinesFromFile(const FileName: WideString); safecall;
    procedure SaveLinesToFile(const FileName: WideString); safecall;
    function Get_ModifiedFlag: SYSINT; safecall;
    procedure Set_ModifiedFlag(Value: SYSINT); safecall;
    function Get_ParentEditorWindowHandle: Int64; safecall;
    procedure Set_ParentEditorWindowHandle(Value: Int64); safecall;
    function Get_DisplayList: WideString; safecall;
    procedure Set_DisplayList(const Value: WideString); safecall;
    function Get_CompleteList: WideString; safecall;
    procedure Set_CompleteList(const Value: WideString); safecall;
    function Get_ProposalOptions: SYSINT; safecall;
    procedure Set_ProposalOptions(Value: SYSINT); safecall;
    function Get_ProposalType: TxProposalType; safecall;
    procedure Set_ProposalType(Value: TxProposalType); safecall;
    function Get_ProposalColumns: WideString; safecall;
    procedure Set_ProposalColumns(const Value: WideString); safecall;
    procedure XYCoordToDisplay(TextLine: SYSINT; TextChar: SYSINT; out ScreenX: SYSINT;
                               out ScreenY: SYSINT); safecall;
    procedure DisplayToXYCoord(ScreenX: SYSINT; ScreenY: SYSINT; out TextLine: SYSINT;
                               out TextChar: SYSINT); safecall;
    function GetBookMark(BookMark: SYSINT; var X: SYSINT; var Y: SYSINT): SYSINT; safecall;
    procedure SetBookMark(BookMark: SYSINT; X: SYSINT; Y: SYSINT); safecall;
    procedure ClearBookMark(BookMark: SYSINT); safecall;
    function CaretInView: SYSINT; safecall;
    procedure EnsureCursorPosVisible(ForceToMiddle: WordBool); safecall;
    function Get_SecondProposalOptions: SYSINT; safecall;
    procedure Set_SecondProposalOptions(Value: SYSINT); safecall;
    function Get_SecondProposalType: TxProposalType; safecall;
    procedure Set_SecondProposalType(Value: TxProposalType); safecall;
    function Get_SecondPoprosalColumns: WideString; safecall;
    procedure Set_SecondPoprosalColumns(const Value: WideString); safecall;
    procedure SecondProposalExecute(const DisplayList: WideString; const CompleteList: WideString;
                                    ProposalType: TxProposalType; ProposalPosX: SYSINT;
                                    ProposalPosY: SYSINT); safecall;
    function Get_DisplaySTSyntaxOptions: TxSTSyntaxOptions; safecall;
    procedure Set_DisplaySTSyntaxOptions(Value: TxSTSyntaxOptions); safecall;
    procedure SecondProposalCancel; safecall;
    procedure PrimeProposalExecute; safecall;
    procedure PrimeProposalCancel; safecall;
    function Get_PrimeProposalWidth: SYSINT; safecall;
    procedure Set_PrimeProposalWidth(Value: SYSINT); safecall;
    function Get_SecondProposalWidth: SYSINT; safecall;
    procedure Set_SecondProposalWidth(Value: SYSINT); safecall;
    function Get_PrimeEndOfTokenChar: WideString; safecall;
    procedure Set_PrimeEndOfTokenChar(const Value: WideString); safecall;
    function Get_SecondEndOfTokenChar: WideString; safecall;
    procedure Set_SecondEndOfTokenChar(const Value: WideString); safecall;
    function Get_PrimeShortCutKey: WideString; safecall;
    procedure Set_PrimeShortCutKey(const Value: WideString); safecall;
    function Get_SecondShortCutKey: WideString; safecall;
    procedure Set_SecondShortCutKey(const Value: WideString); safecall;
    function Get_PrimeTriggerChars: WideString; safecall;
    procedure Set_PrimeTriggerChars(const Value: WideString); safecall;
    function Get_SecondTriggerChars: WideString; safecall;
    procedure Set_SecondTriggerChars(const Value: WideString); safecall;
    function Get_PrimeTimerInterval: SYSINT; safecall;
    procedure Set_PrimeTimerInterval(Value: SYSINT); safecall;
    function Get_SecondTimerInterval: SYSINT; safecall;
    procedure Set_SecondTimerInterval(Value: SYSINT); safecall;
    function Get_PrimeNbItemsInWindow: SYSINT; safecall;
    procedure Set_PrimeNbItemsInWindow(Value: SYSINT); safecall;
    function Get_SecondNbItemsInWindow: SYSINT; safecall;
    procedure Set_SecondNbItemsInWindow(Value: SYSINT); safecall;
    function Get_SecondProposalInsertList: WideString; safecall;
    procedure Set_SecondProposalInsertList(const Value: WideString); safecall;
    function Get_SecondProposalItemList: WideString; safecall;
    procedure Set_SecondProposalItemList(const Value: WideString); safecall;
    procedure InternalFindReplaceDlg(NewVisible: SYSINT; const InitFind: WideString;
                                     const InitReplace: WideString; out OutResult: SYSINT); safecall;
    function InternalSelectFontDialog: SYSINT; safecall;
    function Get_HighlightFontString: WideString; safecall;
    procedure Set_HighlightFontString(const Value: WideString); safecall;
    function GetDebugInfo(command: SYSINT; var parameter: SYSINT): WideString; safecall;
    function Get_EmuTabSize: SYSINT; safecall;
    procedure Set_EmuTabSize(Value: SYSINT); safecall;
    function Get_EditorOptions: WideString; safecall;
    procedure Set_EditorOptions(const Value: WideString); safecall;
    function Get_AvailableOptions: WideString; safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property AutoScroll: WordBool read Get_AutoScroll write Set_AutoScroll;
    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property AxBorderStyle: TxActiveFormBorderStyle read Get_AxBorderStyle write Set_AxBorderStyle;
    property BorderWidth: Integer read Get_BorderWidth write Set_BorderWidth;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Color: OLE_COLOR read Get_Color write Set_Color;
    property Font: IFontDisp read Get_Font write Set_Font;
    property KeyPreview: WordBool read Get_KeyPreview write Set_KeyPreview;
    property PrintScale: TxPrintScale read Get_PrintScale write Set_PrintScale;
    property Scaled: WordBool read Get_Scaled write Set_Scaled;
    property Active: WordBool read Get_Active;
    property DropTarget: WordBool read Get_DropTarget write Set_DropTarget;
    property HelpFile: WideString read Get_HelpFile write Set_HelpFile;
    property PopupMode: TxPopupMode read Get_PopupMode write Set_PopupMode;
    property ScreenSnap: WordBool read Get_ScreenSnap write Set_ScreenSnap;
    property SnapBuffer: Integer read Get_SnapBuffer write Set_SnapBuffer;
    property DockSite: WordBool read Get_DockSite write Set_DockSite;
    property DoubleBuffered: WordBool read Get_DoubleBuffered write Set_DoubleBuffered;
    property PixelsPerInch: Integer read Get_PixelsPerInch write Set_PixelsPerInch;
    property AlignDisabled: WordBool read Get_AlignDisabled;
    property MouseInClient: WordBool read Get_MouseInClient;
    property VisibleDockClientCount: Integer read Get_VisibleDockClientCount;
    property ParentDoubleBuffered: WordBool read Get_ParentDoubleBuffered write Set_ParentDoubleBuffered;
    property IsDrawingLocked: WordBool read Get_IsDrawingLocked;
    property RedrawDisabled: WordBool read Get_RedrawDisabled;
    property UseDockManager: WordBool read Get_UseDockManager write Set_UseDockManager;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property CurrentPPI: Integer read Get_CurrentPPI;
    property ExplicitLeft: Integer read Get_ExplicitLeft;
    property ExplicitTop: Integer read Get_ExplicitTop;
    property ExplicitWidth: Integer read Get_ExplicitWidth;
    property ExplicitHeight: Integer read Get_ExplicitHeight;
    property ScaleFactor: Single read Get_ScaleFactor;
    property StyleName: WideString read Get_StyleName write Set_StyleName;
    property RaiseOnNonMainThreadUsage: WordBool read Get_RaiseOnNonMainThreadUsage write Set_RaiseOnNonMainThreadUsage;
    property AlignWithMargins: WordBool read Get_AlignWithMargins write Set_AlignWithMargins;
    property ParentCustomHint: WordBool read Get_ParentCustomHint write Set_ParentCustomHint;
    property ShowText: WideString read Get_ShowText write Set_ShowText;
    property BgrColor: OLE_COLOR read Get_BgrColor write Set_BgrColor;
    property HighlightSet: WideString read Get_HighlightSet write Set_HighlightSet;
    property ReadOnly: SYSINT read Get_ReadOnly write Set_ReadOnly;
    property XCoord: SYSINT read Get_XCoord write Set_XCoord;
    property YCoord: SYSINT read Get_YCoord write Set_YCoord;
    property Current_Line: WideString read Get_Current_Line write Set_Current_Line;
    property Current_Word: WideString read Get_Current_Word write Set_Current_Word;
    property TextCursorIndex: SYSINT read Get_TextCursorIndex write Set_TextCursorIndex;
    property CurrentLineColor: OLE_COLOR read Get_CurrentLineColor write Set_CurrentLineColor;
    property ModifiedFlag: SYSINT read Get_ModifiedFlag write Set_ModifiedFlag;
    property ParentEditorWindowHandle: Int64 read Get_ParentEditorWindowHandle write Set_ParentEditorWindowHandle;
    property DisplayList: WideString read Get_DisplayList write Set_DisplayList;
    property CompleteList: WideString read Get_CompleteList write Set_CompleteList;
    property ProposalOptions: SYSINT read Get_ProposalOptions write Set_ProposalOptions;
    property ProposalType: TxProposalType read Get_ProposalType write Set_ProposalType;
    property ProposalColumns: WideString read Get_ProposalColumns write Set_ProposalColumns;
    property SecondProposalOptions: SYSINT read Get_SecondProposalOptions write Set_SecondProposalOptions;
    property SecondProposalType: TxProposalType read Get_SecondProposalType write Set_SecondProposalType;
    property SecondPoprosalColumns: WideString read Get_SecondPoprosalColumns write Set_SecondPoprosalColumns;
    property DisplaySTSyntaxOptions: TxSTSyntaxOptions read Get_DisplaySTSyntaxOptions write Set_DisplaySTSyntaxOptions;
    property PrimeProposalWidth: SYSINT read Get_PrimeProposalWidth write Set_PrimeProposalWidth;
    property SecondProposalWidth: SYSINT read Get_SecondProposalWidth write Set_SecondProposalWidth;
    property PrimeEndOfTokenChar: WideString read Get_PrimeEndOfTokenChar write Set_PrimeEndOfTokenChar;
    property SecondEndOfTokenChar: WideString read Get_SecondEndOfTokenChar write Set_SecondEndOfTokenChar;
    property PrimeShortCutKey: WideString read Get_PrimeShortCutKey write Set_PrimeShortCutKey;
    property SecondShortCutKey: WideString read Get_SecondShortCutKey write Set_SecondShortCutKey;
    property PrimeTriggerChars: WideString read Get_PrimeTriggerChars write Set_PrimeTriggerChars;
    property SecondTriggerChars: WideString read Get_SecondTriggerChars write Set_SecondTriggerChars;
    property PrimeTimerInterval: SYSINT read Get_PrimeTimerInterval write Set_PrimeTimerInterval;
    property SecondTimerInterval: SYSINT read Get_SecondTimerInterval write Set_SecondTimerInterval;
    property PrimeNbItemsInWindow: SYSINT read Get_PrimeNbItemsInWindow write Set_PrimeNbItemsInWindow;
    property SecondNbItemsInWindow: SYSINT read Get_SecondNbItemsInWindow write Set_SecondNbItemsInWindow;
    property SecondProposalInsertList: WideString read Get_SecondProposalInsertList write Set_SecondProposalInsertList;
    property SecondProposalItemList: WideString read Get_SecondProposalItemList write Set_SecondProposalItemList;
    property HighlightFontString: WideString read Get_HighlightFontString write Set_HighlightFontString;
    property EmuTabSize: SYSINT read Get_EmuTabSize write Set_EmuTabSize;
    property EditorOptions: WideString read Get_EditorOptions write Set_EditorOptions;
    property AvailableOptions: WideString read Get_AvailableOptions;
  end;

// *********************************************************************//
// DispIntf:  ISTCPD_EditorDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FFD550BB-85C9-45C6-9925-88D819EF523B}
// *********************************************************************//
  ISTCPD_EditorDisp = dispinterface
    ['{FFD550BB-85C9-45C6-9925-88D819EF523B}']
    property Visible: WordBool dispid 201;
    property AutoScroll: WordBool dispid 202;
    property AutoSize: WordBool dispid 203;
    property AxBorderStyle: TxActiveFormBorderStyle dispid 204;
    property BorderWidth: Integer dispid 205;
    property Caption: WideString dispid -518;
    property Color: OLE_COLOR dispid -501;
    property Font: IFontDisp dispid -512;
    property KeyPreview: WordBool dispid 206;
    property PrintScale: TxPrintScale dispid 207;
    property Scaled: WordBool dispid 208;
    property Active: WordBool readonly dispid 209;
    property DropTarget: WordBool dispid 210;
    property HelpFile: WideString dispid 211;
    property PopupMode: TxPopupMode dispid 212;
    property ScreenSnap: WordBool dispid 213;
    property SnapBuffer: Integer dispid 214;
    property DockSite: WordBool dispid 215;
    property DoubleBuffered: WordBool dispid 216;
    property PixelsPerInch: Integer dispid 217;
    property AlignDisabled: WordBool readonly dispid 218;
    property MouseInClient: WordBool readonly dispid 219;
    property VisibleDockClientCount: Integer readonly dispid 220;
    property ParentDoubleBuffered: WordBool dispid 221;
    property IsDrawingLocked: WordBool readonly dispid 222;
    property RedrawDisabled: WordBool readonly dispid 223;
    property UseDockManager: WordBool dispid 224;
    property Enabled: WordBool dispid -514;
    property CurrentPPI: Integer readonly dispid 225;
    property ExplicitLeft: Integer readonly dispid 226;
    property ExplicitTop: Integer readonly dispid 227;
    property ExplicitWidth: Integer readonly dispid 228;
    property ExplicitHeight: Integer readonly dispid 229;
    property ScaleFactor: Single readonly dispid 230;
    property StyleName: WideString dispid 231;
    property RaiseOnNonMainThreadUsage: WordBool dispid 232;
    property AlignWithMargins: WordBool dispid 233;
    property ParentCustomHint: WordBool dispid 234;
    property ShowText: WideString dispid 235;
    property BgrColor: OLE_COLOR dispid 236;
    property HighlightSet: WideString dispid 237;
    property ReadOnly: SYSINT dispid 238;
    property XCoord: SYSINT dispid 239;
    property YCoord: SYSINT dispid 240;
    procedure Cut_Clip; dispid 241;
    procedure Copy_Clip; dispid 242;
    procedure Paste_Clip; dispid 243;
    procedure Undo_Clip; dispid 244;
    procedure Redo_Clip; dispid 245;
    procedure SelectAll_Clip; dispid 246;
    procedure Find_Clip(const SearchStr: WideString; FindStart: SYSINT; FindLen: SYSINT;
                        Options: SYSINT); dispid 247;
    procedure InsertAtCursor(const Tekst: WideString); dispid 248;
    property Current_Line: WideString dispid 249;
    property Current_Word: WideString dispid 250;
    property TextCursorIndex: SYSINT dispid 251;
    procedure CursorIndexToXY(CurIdx: SYSINT; out TextX: SYSINT; out TextY: SYSINT); dispid 252;
    procedure XYToCursorIndex(TextX: SYSINT; TextY: SYSINT; out CurIdx: SYSINT); dispid 253;
    property CurrentLineColor: OLE_COLOR dispid 254;
    procedure LoadLinesFromFile(const FileName: WideString); dispid 255;
    procedure SaveLinesToFile(const FileName: WideString); dispid 256;
    property ModifiedFlag: SYSINT dispid 257;
    property ParentEditorWindowHandle: Int64 dispid 258;
    property DisplayList: WideString dispid 259;
    property CompleteList: WideString dispid 260;
    property ProposalOptions: SYSINT dispid 261;
    property ProposalType: TxProposalType dispid 262;
    property ProposalColumns: WideString dispid 263;
    procedure XYCoordToDisplay(TextLine: SYSINT; TextChar: SYSINT; out ScreenX: SYSINT;
                               out ScreenY: SYSINT); dispid 264;
    procedure DisplayToXYCoord(ScreenX: SYSINT; ScreenY: SYSINT; out TextLine: SYSINT;
                               out TextChar: SYSINT); dispid 265;
    function GetBookMark(BookMark: SYSINT; var X: SYSINT; var Y: SYSINT): SYSINT; dispid 266;
    procedure SetBookMark(BookMark: SYSINT; X: SYSINT; Y: SYSINT); dispid 267;
    procedure ClearBookMark(BookMark: SYSINT); dispid 268;
    function CaretInView: SYSINT; dispid 269;
    procedure EnsureCursorPosVisible(ForceToMiddle: WordBool); dispid 270;
    property SecondProposalOptions: SYSINT dispid 271;
    property SecondProposalType: TxProposalType dispid 272;
    property SecondPoprosalColumns: WideString dispid 273;
    procedure SecondProposalExecute(const DisplayList: WideString; const CompleteList: WideString;
                                    ProposalType: TxProposalType; ProposalPosX: SYSINT;
                                    ProposalPosY: SYSINT); dispid 274;
    property DisplaySTSyntaxOptions: TxSTSyntaxOptions dispid 275;
    procedure SecondProposalCancel; dispid 276;
    procedure PrimeProposalExecute; dispid 277;
    procedure PrimeProposalCancel; dispid 278;
    property PrimeProposalWidth: SYSINT dispid 279;
    property SecondProposalWidth: SYSINT dispid 280;
    property PrimeEndOfTokenChar: WideString dispid 281;
    property SecondEndOfTokenChar: WideString dispid 282;
    property PrimeShortCutKey: WideString dispid 283;
    property SecondShortCutKey: WideString dispid 284;
    property PrimeTriggerChars: WideString dispid 285;
    property SecondTriggerChars: WideString dispid 286;
    property PrimeTimerInterval: SYSINT dispid 287;
    property SecondTimerInterval: SYSINT dispid 288;
    property PrimeNbItemsInWindow: SYSINT dispid 289;
    property SecondNbItemsInWindow: SYSINT dispid 290;
    property SecondProposalInsertList: WideString dispid 291;
    property SecondProposalItemList: WideString dispid 292;
    procedure InternalFindReplaceDlg(NewVisible: SYSINT; const InitFind: WideString;
                                     const InitReplace: WideString; out OutResult: SYSINT); dispid 293;
    function InternalSelectFontDialog: SYSINT; dispid 294;
    property HighlightFontString: WideString dispid 295;
    function GetDebugInfo(command: SYSINT; var parameter: SYSINT): WideString; dispid 296;
    property EmuTabSize: SYSINT dispid 297;
    property EditorOptions: WideString dispid 304;
    property AvailableOptions: WideString readonly dispid 305;
  end;

// *********************************************************************//
// DispIntf:  ISTCPD_EditorEvents
// Flags:     (0)
// GUID:      {76629B13-8766-4AEE-9DC8-85BD44CFA458}
// *********************************************************************//
  ISTCPD_EditorEvents = dispinterface
    ['{76629B13-8766-4AEE-9DC8-85BD44CFA458}']
    procedure OnActivate; dispid 201;
    procedure OnAfterMonitorDpiChanged(OldDPI: Integer; NewDPI: Integer); dispid 202;
    procedure OnBeforeMonitorDpiChanged(OldDPI: Integer; NewDPI: Integer); dispid 203;
    procedure OnClick; dispid 204;
    procedure OnCreate; dispid 205;
    procedure OnDblClick; dispid 206;
    procedure OnDestroy; dispid 207;
    procedure OnDeactivate; dispid 208;
    procedure OnKeyPress(var Key: Smallint); dispid 209;
    procedure OnMouseEnter; dispid 210;
    procedure OnMouseLeave; dispid 211;
    procedure OnPaint; dispid 212;
    procedure OnShowCtx(const Line: WideString; PosInLine: SYSINT; var CurrWord: WideString;
                        out CompleteList: WideString; out DisplayList: WideString); dispid 213;
    function OnContextHelp(const CurrWord: WideString; const CurrLine: WideString; CursorPos: SYSINT): HResult; dispid 214;
    function OnSpecialLineColors(Line: SYSINT; var Special: SYSINT; var FgColor: OLE_COLOR;
                                 var BgColor: OLE_COLOR): HResult; dispid 215;
    function OnEditorKeyDown(var Key: Smallint; ShiftState: SYSINT): HResult; dispid 216;
    function OnEditorKeyPress(var Key: Smallint): HResult; dispid 217;
    function OnEditorKeyUp(var Key: Smallint; ShiftState: SYSINT): HResult; dispid 218;
    function OnEditorMouseCursor(CharIndex: SYSINT; LineIndex: SYSINT; var aCursor: SYSINT): HResult; dispid 219;
    function OnShowSecondProposal: HResult; dispid 220;
    function OnSecondParameterToken(CurrentIndex: SYSINT; var Level: SYSINT;
                                    var IndexToDisplay: SYSINT; var Key: Smallint;
                                    var DisplayString: WideString): HResult; dispid 221;
    function OnSecondCompletionExecute(Kind: TxProposalType; var CurrentInput: WideString;
                                       var X: SYSINT; var Y: SYSINT; var CanExecute: WordBool): HResult; dispid 222;
    function OnSecondCodeCompletion(var Value: WideString; ShiftState: SYSINT; Index: SYSINT;
                                    EndTokenChar: Smallint): HResult; dispid 223;
    function OnSecondClose: HResult; dispid 224;
    function OnSecondProposalChange(Aindex: SYSINT): HResult; dispid 225;
    function OnSecondProposalCancelled: HResult; dispid 226;
    function OnSecondAfterCodeCompletion(const Value: WideString; ShiftState: SYSINT;
                                         Index: SYSINT; EndToken: Smallint): HResult; dispid 227;
    function OnPrimeProposalChange(Aindex: SYSINT): HResult; dispid 228;
    function OnDropFiles(X: SYSINT; Y: SYSINT; const AFiles: WideString): HResult; dispid 229;
    function OnGutterClick(Button: TxMouseButton; X: SYSINT; Y: SYSINT; Line: SYSINT): HResult; dispid 230;
  end;

implementation

uses System.Win.ComObj;

end.

