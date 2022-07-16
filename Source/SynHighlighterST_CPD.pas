{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

Code template generated with SynGen.
The original code is: F:\Projekty\CPDev\CPDev_FBD\CPDev_root\src\Utils\STCPD_Edit\SynHighlighterST_CPD.pas, released 2022-07-15.
Description: Syntax Parser/Highlighter
The initial author of this file is Jan Sadolewski.
Copyright (c) 2007-2022, all rights reserved.

Contributors to the SynEdit and mwEdit projects are listed in the
Contributors.txt file.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id: $

You may retrieve the latest version of this file at the SynEdit home page,
located at http://SynEdit.SourceForge.net

-------------------------------------------------------------------------------}

unit SynHighlighterST_CPD;

{$I SynEdit.inc}

interface

uses
  Graphics,
  SynEditTypes,
  SynEditHighlighter,
  SynUnicode,
  SysUtils,
  Classes;

type
  TtkTokenKind = (
    tkBasicType,
    tkComment,
    tkDelimiter,
    tkDirective,
    tkIdentifier,
    tkImmConstant,
    tkInvalid,
    tkKeyword,
    tkNull,
    tkOperator,
    tkSpecialProc,
    tkString,
    tkUnknown,
    tkVarLocDesc,
    tkVerifDirect,
    tkVMAsm,
    tkWhiteSpace);

  TRangeState = (rsUnKnown, rsStandardCode, rsComment, rsString, rsDirective, rsVMAsm, rsSpecialProc, rsVerifDirect);

  TProcTableProc = procedure of object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function (Index: Integer): TtkTokenKind of object;
  JTSynSTCPDSynOption = (jtsAllowCppComment, jtsAllowNestedComments, jtsAllowSpecialProc, jtsAllowVerifDirect, jtsUseFINTAsType);
  JTSynSTCPDSynOptions = set of JTSynSTCPDSynOption;

type
  TSynSTCPDSyn = class(TSynCustomHighlighter)
  private
    FRange: TRangeState;
    FTokenId: TtkTokenKind;
    fIdentFuncTable: array[0..226] of TIdentFuncTableFunc;
    fBasicTypeAttri: TSynHighlighterAttributes;
    fCommentAttri: TSynHighlighterAttributes;
    fDelimiterAttri: TSynHighlighterAttributes;
    fDirectiveAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fImmConstantAttri: TSynHighlighterAttributes;
    fInvalidAttri: TSynHighlighterAttributes;
    fKeywordAttri: TSynHighlighterAttributes;
    fOperatorAttri: TSynHighlighterAttributes;
    fSpecialProcAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    fVarLocDescAttri: TSynHighlighterAttributes;
    fVerifDirectAttri: TSynHighlighterAttributes;
    fVMAsmAttri: TSynHighlighterAttributes;
    fWhiteSpaceAttri: TSynHighlighterAttributes;
    fOptions: JTSynSTCPDSynOptions;
    function HashKey(Str: PWideChar): Cardinal;
    function FuncAnd(Index: Integer): TtkTokenKind;
    function FuncArray(Index: Integer): TtkTokenKind;
    function FuncAt(Index: Integer): TtkTokenKind;
    function FuncBool(Index: Integer): TtkTokenKind;
    function FuncBy(Index: Integer): TtkTokenKind;
    function FuncByte(Index: Integer): TtkTokenKind;
    function FuncCase(Index: Integer): TtkTokenKind;
    function FuncConst(Index: Integer): TtkTokenKind;
    function FuncConstant(Index: Integer): TtkTokenKind;
    function FuncDate(Index: Integer): TtkTokenKind;
    function FuncDate95and95time(Index: Integer): TtkTokenKind;
    function FuncDint(Index: Integer): TtkTokenKind;
    function FuncDo(Index: Integer): TtkTokenKind;
    function FuncDt(Index: Integer): TtkTokenKind;
    function FuncDword(Index: Integer): TtkTokenKind;
    function FuncElse(Index: Integer): TtkTokenKind;
    function FuncElsif(Index: Integer): TtkTokenKind;
    function FuncEnd95case(Index: Integer): TtkTokenKind;
    function FuncEnd95const(Index: Integer): TtkTokenKind;
    function FuncEnd95for(Index: Integer): TtkTokenKind;
    function FuncEnd95function(Index: Integer): TtkTokenKind;
    function FuncEnd95function95block(Index: Integer): TtkTokenKind;
    function FuncEnd95if(Index: Integer): TtkTokenKind;
    function FuncEnd95program(Index: Integer): TtkTokenKind;
    function FuncEnd95repeat(Index: Integer): TtkTokenKind;
    function FuncEnd95struct(Index: Integer): TtkTokenKind;
    function FuncEnd95type(Index: Integer): TtkTokenKind;
    function FuncEnd95var(Index: Integer): TtkTokenKind;
    function FuncEnd95while(Index: Integer): TtkTokenKind;
    function FuncExit(Index: Integer): TtkTokenKind;
    function FuncF95edge(Index: Integer): TtkTokenKind;
    function FuncFalse(Index: Integer): TtkTokenKind;
    function FuncFint(Index: Integer): TtkTokenKind;
    function FuncFor(Index: Integer): TtkTokenKind;
    function FuncFunction(Index: Integer): TtkTokenKind;
    function FuncFunction95block(Index: Integer): TtkTokenKind;
    function FuncIf(Index: Integer): TtkTokenKind;
    function FuncInt(Index: Integer): TtkTokenKind;
    function FuncLint(Index: Integer): TtkTokenKind;
    function FuncLreal(Index: Integer): TtkTokenKind;
    function FuncLword(Index: Integer): TtkTokenKind;
    function FuncMod(Index: Integer): TtkTokenKind;
    function FuncNot(Index: Integer): TtkTokenKind;
    function FuncOf(Index: Integer): TtkTokenKind;
    function FuncOr(Index: Integer): TtkTokenKind;
    function FuncProgram(Index: Integer): TtkTokenKind;
    function FuncR95edge(Index: Integer): TtkTokenKind;
    function FuncReal(Index: Integer): TtkTokenKind;
    function FuncRepeat(Index: Integer): TtkTokenKind;
    function FuncRetain(Index: Integer): TtkTokenKind;
    function FuncReturn(Index: Integer): TtkTokenKind;
    function FuncSint(Index: Integer): TtkTokenKind;
    function FuncString(Index: Integer): TtkTokenKind;
    function FuncStruct(Index: Integer): TtkTokenKind;
    function FuncThen(Index: Integer): TtkTokenKind;
    function FuncTime(Index: Integer): TtkTokenKind;
    function FuncTime95of95day(Index: Integer): TtkTokenKind;
    function FuncTo(Index: Integer): TtkTokenKind;
    function FuncTod(Index: Integer): TtkTokenKind;
    function FuncTrue(Index: Integer): TtkTokenKind;
    function FuncType(Index: Integer): TtkTokenKind;
    function FuncUdint(Index: Integer): TtkTokenKind;
    function FuncUint(Index: Integer): TtkTokenKind;
    function FuncUlint(Index: Integer): TtkTokenKind;
    function FuncUntil(Index: Integer): TtkTokenKind;
    function FuncUsint(Index: Integer): TtkTokenKind;
    function FuncVar(Index: Integer): TtkTokenKind;
    function FuncVar95acces(Index: Integer): TtkTokenKind;
    function FuncVar95external(Index: Integer): TtkTokenKind;
    function FuncVar95global(Index: Integer): TtkTokenKind;
    function FuncVar95in95out(Index: Integer): TtkTokenKind;
    function FuncVar95input(Index: Integer): TtkTokenKind;
    function FuncVar95output(Index: Integer): TtkTokenKind;
    function FuncWhile(Index: Integer): TtkTokenKind;
    function FuncWord(Index: Integer): TtkTokenKind;
    function FuncWstring(Index: Integer): TtkTokenKind;
    function FuncXor(Index: Integer): TtkTokenKind;
    procedure AtSymbolProc;
    procedure CRProc;
    procedure ColonProc;
    procedure CommaProc;
    procedure DirectiveProc;
    procedure EqualProc;
    procedure GreaterProc;
    procedure IdentProc;
    procedure LFProc;
    procedure LowerProc;
    procedure MinusProc;
    procedure NullProc;
    procedure NumberProc;
    procedure PlusProc;
    procedure PointProc;
    procedure RoundCloseProc;
    procedure RoundOpenProc;
    procedure SemiColonProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure SquareCloseProc;
    procedure SquareOpenProc;
    procedure StarProc;
    procedure StringProc;
    procedure UnicodeStringProc;
    procedure UnknownProc;
    function AltFunc(Index: Integer): TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PWideChar): TtkTokenKind;
    procedure DoCommentProc;
    procedure DoDirectiveProc;
    procedure DoVMAsmProc;
    procedure DoSpecialProcProc;
    procedure DoVerifDirectProc;
  protected
    function GetSampleSource: UnicodeString; override;
    function IsFilterStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetFriendlyLanguageName: UnicodeString; override;
    class function GetLanguageName: string; override;
    function GetRange: Pointer; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    function GetDefaultAttribute(Index: Integer): TSynHighlighterAttributes; override;
    function GetEol: Boolean; override;
    function GetKeyWords(TokenKind: Integer): UnicodeString; override;
    function GetTokenID: TtkTokenKind;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: Integer; override;
    function IsIdentChar(AChar: WideChar): Boolean; override;
    procedure Next; override;
  published
    property BasicTypeAttri: TSynHighlighterAttributes read fBasicTypeAttri write fBasicTypeAttri;
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri write fCommentAttri;
    property DelimiterAttri: TSynHighlighterAttributes read fDelimiterAttri write fDelimiterAttri;
    property DirectiveAttri: TSynHighlighterAttributes read fDirectiveAttri write fDirectiveAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property ImmConstantAttri: TSynHighlighterAttributes read fImmConstantAttri write fImmConstantAttri;
    property InvalidAttri: TSynHighlighterAttributes read fInvalidAttri write fInvalidAttri;
    property KeywordAttri: TSynHighlighterAttributes read fKeywordAttri write fKeywordAttri;
    property OperatorAttri: TSynHighlighterAttributes read fOperatorAttri write fOperatorAttri;
    property SpecialProcAttri: TSynHighlighterAttributes read fSpecialProcAttri write fSpecialProcAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri write fStringAttri;
    property VarLocDescAttri: TSynHighlighterAttributes read fVarLocDescAttri write fVarLocDescAttri;
    property VerifDirectAttri: TSynHighlighterAttributes read fVerifDirectAttri write fVerifDirectAttri;
    property VMAsmAttri: TSynHighlighterAttributes read fVMAsmAttri write fVMAsmAttri;
    property WhiteSpaceAttri: TSynHighlighterAttributes read fWhiteSpaceAttri write fWhiteSpaceAttri;
    property Options : JTSynSTCPDSynOptions read fOptions write fOptions;
  end;

implementation

uses
  SynEditStrConst;

resourcestring
  SYNS_FilterST_61131 = 'All files (*.*)|*.*';
  SYNS_LangST_61131 = 'ST_61131';
  SYNS_FriendlyLangST_61131 = 'ST_61131';
  SYNS_AttrBasicType = 'BasicType';
  SYNS_FriendlyAttrBasicType = 'BasicType';
  SYNS_AttrDelimiter = 'Delimiter';
  SYNS_FriendlyAttrDelimiter = 'Delimiter';
  SYNS_AttrImmConstant = 'ImmConstant';
  SYNS_FriendlyAttrImmConstant = 'ImmConstant';
  SYNS_AttrInvalid = 'Invalid';
  SYNS_FriendlyAttrInvalid = 'Invalid';
  SYNS_AttrKeyword = 'Keyword';
  SYNS_FriendlyAttrKeyword = 'Keyword';
  SYNS_AttrSpecialProc = 'SpecialProc';
  SYNS_FriendlyAttrSpecialProc = 'SpecialProc';
  SYNS_AttrVarLocDesc = 'VarLocDesc';
  SYNS_FriendlyAttrVarLocDesc = 'VarLocDesc';
  SYNS_AttrVerifDirect = 'VerifDirect';
  SYNS_FriendlyAttrVerifDirect = 'VerifDirect';
  SYNS_AttrVMAsm = 'VMAsm';
  SYNS_FriendlyAttrVMAsm = 'VMAsm';
  SYNS_AttrWhiteSpace = 'WhiteSpace';
  SYNS_FriendlyAttrWhiteSpace = 'WhiteSpace';

const
  // as this language is case-insensitive keywords *must* be in lowercase
  KeyWords: array[0..76] of UnicodeString = (
    'and', 'array', 'at', 'bool', 'by', 'byte', 'case', 'const', 'constant', 
    'date', 'date_and_time', 'dint', 'do', 'dt', 'dword', 'else', 'elsif', 
    'end_case', 'end_const', 'end_for', 'end_function', 'end_function_block', 
    'end_if', 'end_program', 'end_repeat', 'end_struct', 'end_type', 'end_var', 
    'end_while', 'exit', 'f_edge', 'false', 'fint', 'for', 'function', 
    'function_block', 'if', 'int', 'lint', 'lreal', 'lword', 'mod', 'not', 'of', 
    'or', 'program', 'r_edge', 'real', 'repeat', 'retain', 'return', 'sint', 
    'string', 'struct', 'then', 'time', 'time_of_day', 'to', 'tod', 'true', 
    'type', 'udint', 'uint', 'ulint', 'until', 'usint', 'var', 'var_acces', 
    'var_external', 'var_global', 'var_in_out', 'var_input', 'var_output', 
    'while', 'word', 'wstring', 'xor' 
  );

  KeyIndices: array[0..226] of Integer = (
    -1, 26, -1, -1, 42, -1, -1, -1, -1, -1, -1, -1, -1, 9, -1, -1, -1, -1, -1, 
    -1, 16, -1, -1, -1, 47, 32, 5, -1, -1, 37, 30, 33, -1, 69, 64, -1, 4, -1, 
    -1, -1, -1, -1, -1, -1, -1, -1, 46, -1, 70, -1, 45, -1, 18, 44, -1, 48, -1, 
    -1, -1, 10, -1, 31, -1, -1, -1, -1, -1, -1, -1, -1, -1, 61, 1, -1, -1, -1, 
    23, -1, -1, 0, 57, -1, -1, 8, -1, -1, -1, -1, -1, 68, 41, 56, 54, -1, 72, 
    59, 66, -1, -1, -1, 34, -1, -1, -1, 24, 65, -1, -1, -1, -1, 62, -1, -1, 15, 
    -1, 7, -1, -1, -1, -1, 28, 21, 6, 11, 22, -1, -1, 20, 19, -1, -1, -1, -1, 
    63, 40, -1, -1, -1, -1, -1, -1, -1, 27, -1, 55, -1, -1, -1, -1, -1, 36, -1, 
    -1, -1, -1, 75, 49, -1, -1, -1, 17, -1, 39, 53, -1, 67, 14, -1, 3, -1, 43, 
    -1, -1, -1, -1, -1, 2, 58, 12, -1, -1, -1, -1, 73, -1, 38, 13, 29, -1, 71, 
    60, -1, -1, -1, -1, 35, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 76, 51, 
    -1, -1, 52, 25, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 74, 50, -1, -1 
  );

procedure TSynSTCPDSyn.InitIdent;
var
  i: Integer;
begin
  for i := Low(fIdentFuncTable) to High(fIdentFuncTable) do
    if KeyIndices[i] = -1 then
      fIdentFuncTable[i] := AltFunc;

  fIdentFuncTable[79] := FuncAnd;
  fIdentFuncTable[72] := FuncArray;
  fIdentFuncTable[176] := FuncAt;
  fIdentFuncTable[168] := FuncBool;
  fIdentFuncTable[36] := FuncBy;
  fIdentFuncTable[26] := FuncByte;
  fIdentFuncTable[122] := FuncCase;
  fIdentFuncTable[115] := FuncConst;
  fIdentFuncTable[83] := FuncConstant;
  fIdentFuncTable[13] := FuncDate;
  fIdentFuncTable[59] := FuncDate95and95time;
  fIdentFuncTable[123] := FuncDint;
  fIdentFuncTable[178] := FuncDo;
  fIdentFuncTable[186] := FuncDt;
  fIdentFuncTable[166] := FuncDword;
  fIdentFuncTable[113] := FuncElse;
  fIdentFuncTable[20] := FuncElsif;
  fIdentFuncTable[160] := FuncEnd95case;
  fIdentFuncTable[52] := FuncEnd95const;
  fIdentFuncTable[128] := FuncEnd95for;
  fIdentFuncTable[127] := FuncEnd95function;
  fIdentFuncTable[121] := FuncEnd95function95block;
  fIdentFuncTable[124] := FuncEnd95if;
  fIdentFuncTable[76] := FuncEnd95program;
  fIdentFuncTable[104] := FuncEnd95repeat;
  fIdentFuncTable[212] := FuncEnd95struct;
  fIdentFuncTable[1] := FuncEnd95type;
  fIdentFuncTable[142] := FuncEnd95var;
  fIdentFuncTable[120] := FuncEnd95while;
  fIdentFuncTable[187] := FuncExit;
  fIdentFuncTable[30] := FuncF95edge;
  fIdentFuncTable[61] := FuncFalse;
  fIdentFuncTable[25] := FuncFint;
  fIdentFuncTable[31] := FuncFor;
  fIdentFuncTable[100] := FuncFunction;
  fIdentFuncTable[195] := FuncFunction95block;
  fIdentFuncTable[150] := FuncIf;
  fIdentFuncTable[29] := FuncInt;
  fIdentFuncTable[185] := FuncLint;
  fIdentFuncTable[162] := FuncLreal;
  fIdentFuncTable[134] := FuncLword;
  fIdentFuncTable[90] := FuncMod;
  fIdentFuncTable[4] := FuncNot;
  fIdentFuncTable[170] := FuncOf;
  fIdentFuncTable[53] := FuncOr;
  fIdentFuncTable[50] := FuncProgram;
  fIdentFuncTable[46] := FuncR95edge;
  fIdentFuncTable[24] := FuncReal;
  fIdentFuncTable[55] := FuncRepeat;
  fIdentFuncTable[156] := FuncRetain;
  fIdentFuncTable[224] := FuncReturn;
  fIdentFuncTable[208] := FuncSint;
  fIdentFuncTable[211] := FuncString;
  fIdentFuncTable[163] := FuncStruct;
  fIdentFuncTable[92] := FuncThen;
  fIdentFuncTable[144] := FuncTime;
  fIdentFuncTable[91] := FuncTime95of95day;
  fIdentFuncTable[80] := FuncTo;
  fIdentFuncTable[177] := FuncTod;
  fIdentFuncTable[95] := FuncTrue;
  fIdentFuncTable[190] := FuncType;
  fIdentFuncTable[71] := FuncUdint;
  fIdentFuncTable[110] := FuncUint;
  fIdentFuncTable[133] := FuncUlint;
  fIdentFuncTable[34] := FuncUntil;
  fIdentFuncTable[105] := FuncUsint;
  fIdentFuncTable[96] := FuncVar;
  fIdentFuncTable[165] := FuncVar95acces;
  fIdentFuncTable[89] := FuncVar95external;
  fIdentFuncTable[33] := FuncVar95global;
  fIdentFuncTable[48] := FuncVar95in95out;
  fIdentFuncTable[189] := FuncVar95input;
  fIdentFuncTable[94] := FuncVar95output;
  fIdentFuncTable[183] := FuncWhile;
  fIdentFuncTable[223] := FuncWord;
  fIdentFuncTable[155] := FuncWstring;
  fIdentFuncTable[207] := FuncXor;
end;

{$Q-}
function TSynSTCPDSyn.HashKey(Str: PWideChar): Cardinal;
begin
  Result := 0;
  while IsIdentChar(Str^) do
  begin
    Result := Result * 475 + Ord(Str^) * 501;
    inc(Str);
  end;
  Result := Result mod 227;
  fStringLen := Str - fToIdent;
end;
{$Q+}

function TSynSTCPDSyn.FuncAnd(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOperator
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncArray(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncAt(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncBool(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncBy(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncByte(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncCase(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncConst(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncConstant(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncDate(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncDate95and95time(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncDint(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncDo(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncDt(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncDword(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncElse(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncElsif(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95case(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95const(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95for(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95function(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95function95block(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95if(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95program(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95repeat(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95struct(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95type(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95var(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncEnd95while(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncExit(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncF95edge(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncFalse(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncFint(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    begin
      if jtsUseFINTAsType in fOptions
                            then
                              Result := tkBasicType
                            else
                              Result := tkIdentifier;
    end
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncFor(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncFunction(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncFunction95block(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncIf(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncInt(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncLint(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncLreal(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncLword(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncMod(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOperator
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncNot(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOperator
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncOf(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncOr(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOperator
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncProgram(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncR95edge(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncReal(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncRepeat(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncRetain(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncReturn(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncSint(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncString(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncStruct(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncThen(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncTime(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncTime95of95day(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncTo(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncTod(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncTrue(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncType(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncUdint(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncUint(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncUlint(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncUntil(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncUsint(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncVar(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncVar95acces(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncVar95external(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncVar95global(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncVar95in95out(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncVar95input(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncVar95output(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncWhile(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkKeyword
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncWord(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncWstring(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkBasicType
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.FuncXor(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOperator
  else
    Result := tkIdentifier;
end;

function TSynSTCPDSyn.AltFunc(Index: Integer): TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TSynSTCPDSyn.IdentKind(MayBe: PWideChar): TtkTokenKind;
var
  Key: Cardinal;
begin
  fToIdent := MayBe;
  Key := HashKey(MayBe);
  if Key <= High(fIdentFuncTable) then
    Result := FIdentFuncTable[Key](KeyIndices[Key])
  else
    Result := tkIdentifier;
end;

procedure TSynSTCPDSyn.NullProc;
begin
  FTokenId := tkNull;
  //? inc(Run); //?
end;

{procedure TSynSTCPDSyn.CRProc;
begin
  FTokenId := tkUnknown;
  inc(Run);
  if FLine[Run] = #10 then
    inc(Run);
end;

procedure TSynSTCPDSyn.LFProc;
begin
  FTokenId := tkUnknown;
  inc(Run);
end;
}

constructor TSynSTCPDSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fCaseSensitive := False;

  fBasicTypeAttri := TSynHighLighterAttributes.Create(SYNS_AttrBasicType, SYNS_FriendlyAttrBasicType);
  fBasicTypeAttri.Style := [fsBold];
  fBasicTypeAttri.Foreground := $00002080;
  AddAttribute(fBasicTypeAttri);

  fCommentAttri := TSynHighLighterAttributes.Create(SYNS_AttrComment, SYNS_FriendlyAttrComment);
  fCommentAttri.Style := [fsItalic];
  fCommentAttri.Foreground := clGreen;
  AddAttribute(fCommentAttri);

  fDelimiterAttri := TSynHighLighterAttributes.Create(SYNS_AttrDelimiter, SYNS_FriendlyAttrDelimiter);
  fDelimiterAttri.Foreground := $00008080;
  fDelimiterAttri.Background := $00F0F0F0;
  AddAttribute(fDelimiterAttri);

  fDirectiveAttri := TSynHighLighterAttributes.Create(SYNS_AttrDirective, SYNS_FriendlyAttrDirective);
  fDirectiveAttri.Foreground := $00F0F0F0;
  fDirectiveAttri.Background := $00AA0D04;
  AddAttribute(fDirectiveAttri);

  fIdentifierAttri := TSynHighLighterAttributes.Create(SYNS_AttrIdentifier, SYNS_FriendlyAttrIdentifier);
  AddAttribute(fIdentifierAttri);

  fImmConstantAttri := TSynHighLighterAttributes.Create(SYNS_AttrImmConstant, SYNS_FriendlyAttrImmConstant);
  fImmConstantAttri.Foreground := $0000AFAF;
  fImmConstantAttri.Background := clWhite;
  AddAttribute(fImmConstantAttri);

  fInvalidAttri := TSynHighLighterAttributes.Create(SYNS_AttrInvalid, SYNS_FriendlyAttrInvalid);
  fInvalidAttri.Foreground := $001040A0;
  fInvalidAttri.Background := clSilver;
  AddAttribute(fInvalidAttri);

  fKeywordAttri := TSynHighLighterAttributes.Create(SYNS_AttrKeyword, SYNS_FriendlyAttrKeyword);
  fKeywordAttri.Style := [fsBold];
  fKeywordAttri.Foreground := clBlue;
  AddAttribute(fKeywordAttri);

  fOperatorAttri := TSynHighLighterAttributes.Create(SYNS_AttrOperator, SYNS_FriendlyAttrOperator);
  fOperatorAttri.Foreground := clNavy;
  AddAttribute(fOperatorAttri);

  fSpecialProcAttri := TSynHighLighterAttributes.Create(SYNS_AttrSpecialProc, SYNS_FriendlyAttrSpecialProc);
  fSpecialProcAttri.Foreground := clSilver;
  fSpecialProcAttri.Background := clBlack;
  AddAttribute(fSpecialProcAttri);

  fStringAttri := TSynHighLighterAttributes.Create(SYNS_AttrString, SYNS_FriendlyAttrString);
  fStringAttri.Foreground := $00004000;
  fStringAttri.Background := $00FFFF00;
  AddAttribute(fStringAttri);

  fVarLocDescAttri := TSynHighLighterAttributes.Create(SYNS_AttrVarLocDesc, SYNS_FriendlyAttrVarLocDesc);
  fVarLocDescAttri.Foreground := clDkGray;
  fVarLocDescAttri.Background := $D0D0D0;
  AddAttribute(fVarLocDescAttri);

  fVerifDirectAttri := TSynHighLighterAttributes.Create(SYNS_AttrVerifDirect, SYNS_FriendlyAttrVerifDirect);
  fVerifDirectAttri.Foreground := clYellow;
  fVerifDirectAttri.Background := clTeal;
  AddAttribute(fVerifDirectAttri);

  fVMAsmAttri := TSynHighLighterAttributes.Create(SYNS_AttrVMAsm, SYNS_FriendlyAttrVMAsm);
  fVMAsmAttri.Foreground := clDkGray;
  fVMAsmAttri.Background := clYellow;
  AddAttribute(fVMAsmAttri);

  fWhiteSpaceAttri := TSynHighLighterAttributes.Create(SYNS_AttrWhiteSpace, SYNS_FriendlyAttrWhiteSpace);
  AddAttribute(fWhiteSpaceAttri);

  SetAttributesOnChange(DefHighlightChange);
  InitIdent;
  fDefaultFilter := SYNS_FilterST_61131;
  FRange := rsUnknown;
end;

procedure TSynSTCPDSyn.AtSymbolProc;
begin
  fTokenID := tkOperator;
  inc(Run);
end;

procedure TSynSTCPDSyn.CRProc;
begin
  fTokenID := tkWhiteSpace;
  Case FLine[Run + 1] of
    #10: inc(Run, 2);
  else inc(Run);
  end;
end;

procedure TSynSTCPDSyn.ColonProc;
begin
  fTokenID := tkOperator;
  inc(Run);
end;

procedure TSynSTCPDSyn.CommaProc;
begin
  inc(Run);
  fTokenID := tkDelimiter;
end;

procedure TSynSTCPDSyn.DirectiveProc;
begin
  fTokenID := tkImmConstant;
  Inc(Run);
  case FLine[Run] of
      #0,
      #39,
      #34: exit;
  end;
  repeat
    case FLine[Run] of
      #0, #9, #10, #13, #32, '(', ')', '[', ']', ';', ',', '{', '}' : break;
    end;
    inc(Run);
  until FLine[Run] = #0;
end;

procedure TSynSTCPDSyn.EqualProc;
begin
  fTokenID := tkOperator;
  inc(Run);
end;

procedure TSynSTCPDSyn.GreaterProc;
begin
  fTokenID := tkOperator;
  inc(Run);
end;

procedure TSynSTCPDSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  //? while Identifiers[fLine[Run]] do inc(Run); //?
end;

procedure TSynSTCPDSyn.LFProc;
begin
  fTokenID := tkWhiteSpace;
  inc(Run);
end;

procedure TSynSTCPDSyn.LowerProc;
begin
  fTokenID := tkOperator;
  inc(Run);
end;

procedure TSynSTCPDSyn.MinusProc;
begin
  inc(Run);
  fTokenID := tkDelimiter;
end;

procedure TSynSTCPDSyn.NumberProc;
var hasDot : boolean;
    hasExponent: boolean;
begin
  inc(Run);
  fTokenID := tkImmConstant;
  hasDot := false;
  hasExponent := false;
  while FLine[Run] <> #0 do
  begin
    case FLine[Run] of
      '0'..'9',
      '#', '_': begin end;
      '.': if hasDot then
           begin
            Dec(run);
            break;
           end
           else begin
            hasDot := true;
            if FLine[Run + 1] = '.' then break;
           end;
      'e','E':
           if hasExponent then
            begin
             Dec(run);
             break;
            end
           else begin
            hasExponent := true;
            if (FLine[Run + 1] = '+') or (FLine[Run + 1] =  '-') then Inc(Run, 1);
           end;
{      '+', '-':
           if hasExponent then
           begin
             if heSign then
              begin
               Dec(Run);
               break;
              end
             else
               heSign := true;
           end
           else
           begin
            Dec(Run);
            break;
           end;}
         else
           break;
    end;
    inc(Run);
  end;
end;

procedure TSynSTCPDSyn.PlusProc;
begin
  inc(Run);
  fTokenID := tkOperator;
end;

procedure TSynSTCPDSyn.PointProc;
begin
  if (FLine[Run + 1] = '.') then
    begin                              {ellipse}
      inc(Run, 2);
      fTokenID := tkOperator;
    end
  else                                 {point}
    begin
      inc(Run);
      fTokenID := tkDelimiter;
    end;
end;

procedure TSynSTCPDSyn.RoundCloseProc;
begin
  inc(Run);
  fTokenID := tkDelimiter;
end;

procedure TSynSTCPDSyn.RoundOpenProc;
begin
  if (FLine[Run + 1] = '*') then 
   begin
    if (FLine[Run + 2] = '$') then
      begin
       inc(Run, 3);
       fTokenID := tkDirective;
      end
    else
      begin
       inc(Run, 2);
       fTokenID := tkComment;
      end; 
    while fLine[Run] <> #0 do
          case fLine[Run] of
            '*':
              if fLine[Run + 1] = ')' then
              begin
                inc(Run, 2);
                break;
              end else inc(Run);
          else inc(Run);
          end;  
   end
 else 
   begin
    inc(Run);
    FTokenID := tkDelimiter;
   end;
end;

procedure TSynSTCPDSyn.SemiColonProc;
begin
  fTokenID := tkDelimiter;
  inc(Run);
end;

procedure TSynSTCPDSyn.SlashProc;
begin
  fTokenID := tkOperator;
  inc(Run);
end;

procedure TSynSTCPDSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkWhiteSpace;
  while (FLine[Run] = #9) or (FLine[Run] = #32) do inc(Run);
end;

procedure TSynSTCPDSyn.SquareCloseProc;
begin
  fTokenID := tkDelimiter;
  inc(Run);
end;

procedure TSynSTCPDSyn.SquareOpenProc;
begin
  fTokenID := tkDelimiter;
  inc(Run);
end;

procedure TSynSTCPDSyn.StarProc;
begin
  inc(Run);
  fTokenID := tkOperator;
end;

procedure TSynSTCPDSyn.StringProc;
begin
  fTokenID := tkString;
  if (FLine[Run + 1] = #39) and (FLine[Run + 2] = #39) then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
      '$': if FLine[Run + 1] = #39 then Inc(Run, 1);
    end;
    inc(Run);
  until FLine[Run] = #39;
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TSynSTCPDSyn.UnicodeStringProc;
begin
  fTokenID := tkString;
  if (FLine[Run + 1] = #34) and (FLine[Run + 2] = #34) then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
      '$': if FLine[Run + 1] = #34 then Inc(Run, 1);
    end;
    inc(Run);
  until FLine[Run] = #34;
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TSynSTCPDSyn.UnknownProc;
begin
  inc(Run);
  FTokenId := tkUnknown;
end;

procedure TSynSTCPDSyn.Next;
begin
  fTokenPos := Run;
  case fRange of
   rsComment: DoCommentProc;
   rsDirective: DoDirectiveProc;
   rsVMAsm: DoVMAsmProc;
   rsSpecialProc: DoSpecialProcProc;
   rsVerifDirect: DoVerifDirectProc;
   else
  case FLine[Run] of
    #0: NullProc;
    #10: LFProc;
    #13: CRProc;
    '@': AtSymbolProc;
    ':': ColonProc;
    ',': CommaProc;
    '#': DirectiveProc;
    '=': EqualProc;
    '>': GreaterProc;
    'A'..'Z', 'a'..'z', '_': IdentProc;
    '<': LowerProc;
    '-': MinusProc;
    '0'..'9' : NumberProc;
    '+': PlusProc;
    '.': PointProc;
    ')': RoundCloseProc;
    '(': RoundOpenProc;
    ';': SemiColonProc;
    '/': SlashProc;
    #9, #32: SpaceProc;
    ']': SquareCloseProc;
    '[': SquareOpenProc;
    '*': StarProc;
    #39: StringProc;
    #34: UnicodeStringProc;
  else
    UnknownProc;
  end;
  end;
  inherited;
end;

function TSynSTCPDSyn.GetDefaultAttribute(Index: Integer): TSynHighLighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT: Result := FCommentAttri;
    SYN_ATTR_IDENTIFIER: Result := FIdentifierAttri;
    SYN_ATTR_STRING: Result := FStringAttri;
  else
    Result := nil;
  end;
end;

function TSynSTCPDSyn.GetEol: Boolean;
begin
  Result := Run = FLineLen + 1;
end;

function TSynSTCPDSyn.GetKeyWords(TokenKind: Integer): UnicodeString;
begin
  Result := 
    'AND,ARRAY,AT,BOOL,BY,BYTE,CASE,CONST,CONSTANT,DATE,DATE_AND_TIME,DINT' +
    ',DO,DT,DWORD,ELSE,ELSIF,END_CASE,END_CONST,END_FOR,END_FUNCTION,END_FU' +
    'NCTION_BLOCK,END_IF,END_PROGRAM,END_REPEAT,END_STRUCT,END_TYPE,END_VAR' +
    ',END_WHILE,EXIT,F_EDGE,FALSE,FINT,FOR,FUNCTION,FUNCTION_BLOCK,IF,INT,L' +
    'INT,LREAL,LWORD,MOD,NOT,OF,OR,PROGRAM,R_EDGE,REAL,REPEAT,RETAIN,RETURN' +
    ',SINT,STRING,STRUCT,THEN,TIME,TIME_OF_DAY,TO,TOD,TRUE,TYPE,UDINT,UINT,' +
    'ULINT,UNTIL,USINT,VAR,VAR_ACCES,VAR_EXTERNAL,VAR_GLOBAL,VAR_IN_OUT,VAR' +
    '_INPUT,VAR_OUTPUT,WHILE,WORD,WSTRING,XOR';
end;

function TSynSTCPDSyn.GetTokenID: TtkTokenKind;
begin
  Result := FTokenId;
end;

function TSynSTCPDSyn.GetTokenAttribute: TSynHighLighterAttributes;
begin
  case GetTokenID of
    tkBasicType: Result := FBasicTypeAttri;
    tkComment: Result := FCommentAttri;
    tkDelimiter: Result := FDelimiterAttri;
    tkDirective: Result := FDirectiveAttri;
    tkIdentifier: Result := FIdentifierAttri;
    tkImmConstant: Result := FImmConstantAttri;
    tkInvalid: Result := FInvalidAttri;
    tkKeyword: Result := FKeywordAttri;
    tkOperator: Result := FOperatorAttri;
    tkSpecialProc: Result := FSpecialProcAttri;
    tkString: Result := FStringAttri;
    tkVarLocDesc: Result := FVarLocDescAttri;
    tkVerifDirect: Result := FVerifDirectAttri;
    tkVMAsm: Result := FVMAsmAttri;
    tkWhiteSpace: Result := FWhiteSpaceAttri;
    tkUnknown: Result := FIdentifierAttri;
  else
    Result := nil;
  end;
end;

function TSynSTCPDSyn.GetTokenKind: Integer;
begin
  Result := Ord(FTokenId);
end;

function TSynSTCPDSyn.IsIdentChar(AChar: WideChar): Boolean;
begin
  case AChar of
    '_', '0'..'9', 'a'..'z', 'A'..'Z':
      Result := True;
    else
      Result := False;
  end;
end;

function TSynSTCPDSyn.GetSampleSource: UnicodeString;
begin
  Result := 
    'VAR_GLOBAL '#13#10 +
    ' B AT %0000 : INT;'#13#10 +
    'END_VAR'#13#10 +
    #13#10 +
    'PROGRAM P1;'#13#10 +
    'VAR C : BOOL;'#13#10 +
    'VAR_EXTERNAL'#13#10 +
    ' B : INT; (*$READ*)'#13#10 +
    'END_VAR'#13#10 +
    #13#10 +
    'B := B + 1;'#13#10 +
    'C := B > 0 AND B < 200; '#13#10 +
    'END_PROGRAM';
end;

function TSynSTCPDSyn.IsFilterStored: Boolean;
begin
  Result := FDefaultFilter <> SYNS_FilterST_61131;
end;

class function TSynSTCPDSyn.GetFriendlyLanguageName: UnicodeString;
begin
  Result := SYNS_FriendlyLangST_61131;
end;

class function TSynSTCPDSyn.GetLanguageName: string;
begin
  Result := SYNS_LangST_61131;
end;

procedure TSynSTCPDSyn.ResetRange;
begin
  FRange := rsUnknown;
end;

procedure TSynSTCPDSyn.SetRange(Value: Pointer);
begin
  FRange := TRangeState(Value);
end;

function TSynSTCPDSyn.GetRange: Pointer;
begin
  Result := Pointer(FRange);
end;

procedure TSynSTCPDSyn.DoCommentProc;
begin
 fTokenID := tkComment;
 case FLine[Run] of
    #0:
      begin
        NullProc;
        exit;
      end;
    #10:
      begin
        LFProc;
        exit;
      end;
    #13:
      begin
        CRProc;
        exit;
      end;
  end;

  while FLine[Run] <> #0 do
    case FLine[Run] of
{      '(':   //begin comment {
        begin
          if fLine[Run + 1] = '*'
            then
              Inc(fCommentDeep);
          Inc(Run);
        end; //end comment }
      '*':
        if fLine[Run + 1] = ')'
        then
         begin
          inc(Run, 2);
 {         Dec(fCommentDeep); //begin comment {
          if fCommentDeep = 0 then
           begin
            fRange := rsUnKnown;
            break;
           end; //end comment }
           fRange := rsUnKnown;
           break;
         end
        else
          inc(Run);
      #10: break;
      #13: break;
    else inc(Run);
    end;
end;

procedure TSynSTCPDSyn.DoDirectiveProc;
begin
 fTokenID := tkDirective;
 case FLine[Run] of
    #0:
      begin
        NullProc;
        exit;
      end;
    #10:
      begin
        LFProc;
        exit;
      end;
    #13:
      begin
        CRProc;
        exit;
      end;
  end;

  while FLine[Run] <> #0 do
    case FLine[Run] of
{      '(': //begin comment {
        begin
          if fLine[Run + 1] = '*'
            then
             Inc(fCommentDeep);
          Inc(Run);
        end; //end comment }
      '*':
        if fLine[Run + 1] = ')'
        then
         begin
          inc(Run, 2);
{          Dec(fCommentDeep); //begin comment {
          if fCommentDeep = 0 then
           begin
            fRange := rsUnKnown;
            break;
           end; //end comment }
          fRange := rsUnKnown;
          break;
         end
        else
          inc(Run);
      #10: break;
      #13: break;
    else inc(Run);
    end;
end;

procedure TSynSTCPDSyn.DoVMAsmProc;
begin
 fTokenID := tkVMAsm;
 case FLine[Run] of
    #0:
      begin
        NullProc;
        exit;
      end;
    #10:
      begin
        LFProc;
        exit;
      end;
    #13:
      begin
        CRProc;
        exit;
      end;
  end;

  while FLine[Run] <> #0 do
    case FLine[Run] of
{      '(':
        begin
          if fLine[Run + 1] = '*'
            then
              Inc(fCommentDeep);
          Inc(Run);
        end;}
      '*':
        if fLine[Run + 1] = ')'
        then
         begin
          inc(Run, 2);
{          Dec(fCommentDeep);
          if fCommentDeep = 0 then
           begin
            fRange := rsUnKnown;
            break;
           end}
           fRange := rsUnKnown;
           break;
         end
        else
          inc(Run);
      #10: break;
      #13: break;
    else inc(Run);
    end;
end;

procedure TSynSTCPDSyn.DoSpecialProcProc;
begin
 fTokenID := tkSpecialProc;
 case FLine[Run] of
    #0:
      begin
        NullProc;
        exit;
      end;
    #10:
      begin
        LFProc;
        exit;
      end;
    #13:
      begin
        CRProc;
        exit;
      end;
  end;

  while FLine[Run] <> #0 do
    case FLine[Run] of
{      '(': //begin comment {
        begin
          if fLine[Run + 1] = '*'
            then
             Inc(fCommentDeep);
          Inc(Run);
        end; //end comment }
      '*':
        if fLine[Run + 1] = ')'
        then
         begin
          inc(Run, 2);
{          Dec(fCommentDeep); //begin comment {
          if fCommentDeep = 0 then
           begin
            fRange := rsUnKnown;
            break;
           end; //end comment }
          fRange := rsUnKnown;
          break;
         end
        else
          inc(Run);
      #10: break;
      #13: break;
    else inc(Run);
    end;
end;

procedure TSynSTCPDSyn.DoVerifDirectProc;
begin
 fTokenID := tkVerifDirect;
 case FLine[Run] of
    #0:
      begin
        NullProc;
        exit;
      end;
    #10:
      begin
        LFProc;
        exit;
      end;
    #13:
      begin
        CRProc;
        exit;
      end;
  end;

  while FLine[Run] <> #0 do
    case FLine[Run] of
{      '(': //begin comment {
        begin
          if fLine[Run + 1] = '*'
            then
             Inc(fCommentDeep);
          Inc(Run);
        end; //end comment }
      '*':
        if fLine[Run + 1] = ')'
        then
         begin
          inc(Run, 2);
{          Dec(fCommentDeep); //begin comment {
          if fCommentDeep = 0 then
           begin
            fRange := rsUnKnown;
            break;
           end; //end comment }
          fRange := rsUnKnown;
          break;
         end
        else
          inc(Run);
      #10: break;
      #13: break;
    else inc(Run);
    end;
end;


initialization
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynSTCPDSyn);
{$ENDIF}
end.
