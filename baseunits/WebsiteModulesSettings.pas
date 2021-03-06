unit WebsiteModulesSettings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
    TProxyType = (ptDefault, ptDirect, ptHTTP, ptSOCKS4, ptSOCKS5);

  { TProxySettings }

  TProxySettings = class(TPersistent)
  private
    FProxyHost: String;
    FProxyPassword: String;
    FProxyPort: String;
    FProxyType: TProxyType;
    FProxyUsername: String;
  published
    property ProxyType: TProxyType read FProxyType write FProxyType default ptDefault;
    property ProxyHost: String read FProxyHost write FProxyHost;
    property ProxyPort: String read FProxyPort write FProxyPort;
    property ProxyUsername: String read FProxyUsername write FProxyUsername;
    property ProxyPassword: String read FProxyPassword write FProxyPassword;
  end;

  { THTTPSettings }

  THTTPSettings = class(TPersistent)
  private
    FCookies: String;
    FProxy: TProxySettings;
    FUserAgent: String;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Cookies: String read FCookies write FCookies;
    property UserAgent: String read FUserAgent write FUserAgent;
    property Proxy: TProxySettings read FProxy write FProxy;
  end;

  { TWebsiteModuleSettings }

  TWebsiteModuleSettings = class(TPersistent)
  private
    FHTTP: THTTPSettings;
    FMaxConnectionLimit: Integer;
    FMaxTaskLimit: Integer;
    FMaxThreadPerTaskLimit: Integer;
    FUpdateListDirectoryPageNumber: Integer;
    FUpdateListNumberOfThread: Integer;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property MaxTaskLimit: Integer read FMaxTaskLimit write FMaxTaskLimit default 0;
    property MaxThreadPerTaskLimit: Integer read FMaxThreadPerTaskLimit write FMaxThreadPerTaskLimit default 0;
    property MaxConnectionLimit: Integer read FMaxConnectionLimit write FMaxConnectionLimit default 0;
    property UpdateListNumberOfThread: Integer read FUpdateListNumberOfThread write FUpdateListNumberOfThread default 0;
    property UpdateListDirectoryPageNumber: Integer read FUpdateListDirectoryPageNumber write FUpdateListDirectoryPageNumber default 0;
    property HTTP: THTTPSettings read FHTTP write FHTTP;
  end;

implementation

{ THTTPSettings }

constructor THTTPSettings.Create;
begin
  Proxy:=TProxySettings.Create;
end;

destructor THTTPSettings.Destroy;
begin
  Proxy.Free;
  inherited Destroy;
end;

{ TWebsiteModuleSettings }

constructor TWebsiteModuleSettings.Create;
begin
  HTTP:=THTTPSettings.Create;
end;

destructor TWebsiteModuleSettings.Destroy;
begin
  HTTP.Free;
  inherited Destroy;
end;

initialization
  RegisterClass(TWebsiteModuleSettings);
  RegisterClass(THTTPSettings);
  RegisterClass(TProxySettings);

end.

