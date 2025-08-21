library STCPD_Edit;

uses
  ComServ,
  STCPD_Edit_TLB in 'STCPD_Edit_TLB.pas',
  STCPD_EditorImpl in 'STCPD_EditorImpl.pas' {STCPD_Editor: TActiveForm} {STCPD_Editor: CoClass};

{$E ocx}

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,
  DllInstall;

{$R *.TLB}

{$R *.RES}

begin
end.
