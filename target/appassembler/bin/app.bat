@REM ----------------------------------------------------------------------------
@REM  Copyright 2001-2006 The Apache Software Foundation.
@REM
@REM  Licensed under the Apache License, Version 2.0 (the "License");
@REM  you may not use this file except in compliance with the License.
@REM  You may obtain a copy of the License at
@REM
@REM       http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM  Unless required by applicable law or agreed to in writing, software
@REM  distributed under the License is distributed on an "AS IS" BASIS,
@REM  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM  See the License for the specific language governing permissions and
@REM  limitations under the License.
@REM ----------------------------------------------------------------------------
@REM
@REM   Copyright (c) 2001-2006 The Apache Software Foundation.  All rights
@REM   reserved.

@echo off

set ERROR_CODE=0

:init
@REM Decide how to startup depending on the version of windows

@REM -- Win98ME
if NOT "%OS%"=="Windows_NT" goto Win9xArg

@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" @setlocal

@REM -- 4NT shell
if "%eval[2+2]" == "4" goto 4NTArgs

@REM -- Regular WinNT shell
set CMD_LINE_ARGS=%*
goto WinNTGetScriptDir

@REM The 4NT Shell from jp software
:4NTArgs
set CMD_LINE_ARGS=%$
goto WinNTGetScriptDir

:Win9xArg
@REM Slurp the command line arguments.  This loop allows for an unlimited number
@REM of arguments (up to the command line limit, anyway).
set CMD_LINE_ARGS=
:Win9xApp
if %1a==a goto Win9xGetScriptDir
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto Win9xApp

:Win9xGetScriptDir
set SAVEDIR=%CD%
%0\
cd %0\..\.. 
set BASEDIR=%CD%
cd %SAVEDIR%
set SAVE_DIR=
goto repoSetup

:WinNTGetScriptDir
set BASEDIR=%~dp0\..

:repoSetup


if "%JAVACMD%"=="" set JAVACMD=java

if "%REPO%"=="" set REPO=%BASEDIR%\repo

set CLASSPATH="%BASEDIR%"\etc;"%REPO%"\org\springframework\spring-context\3.1.1.RELEASE\spring-context-3.1.1.RELEASE.jar;"%REPO%"\org\springframework\spring-aop\3.1.1.RELEASE\spring-aop-3.1.1.RELEASE.jar;"%REPO%"\aopalliance\aopalliance\1.0\aopalliance-1.0.jar;"%REPO%"\org\springframework\spring-beans\3.1.1.RELEASE\spring-beans-3.1.1.RELEASE.jar;"%REPO%"\org\springframework\spring-core\3.1.1.RELEASE\spring-core-3.1.1.RELEASE.jar;"%REPO%"\commons-logging\commons-logging\1.1.1\commons-logging-1.1.1.jar;"%REPO%"\org\springframework\spring-expression\3.1.1.RELEASE\spring-expression-3.1.1.RELEASE.jar;"%REPO%"\org\springframework\spring-asm\3.1.1.RELEASE\spring-asm-3.1.1.RELEASE.jar;"%REPO%"\mysql\mysql-connector-java\5.1.9\mysql-connector-java-5.1.9.jar;"%REPO%"\org\springframework\spring-jdbc\3.1.1.RELEASE\spring-jdbc-3.1.1.RELEASE.jar;"%REPO%"\org\springframework\spring-tx\3.1.1.RELEASE\spring-tx-3.1.1.RELEASE.jar;"%REPO%"\org\cloudfoundry\cloudfoundry-runtime\0.8.1\cloudfoundry-runtime-0.8.1.jar;"%REPO%"\org\cloudfoundry\cloudfoundry-client-lib\0.8.1\cloudfoundry-client-lib-0.8.1.jar;"%REPO%"\org\springframework\spring-webmvc\3.0.7.RELEASE\spring-webmvc-3.0.7.RELEASE.jar;"%REPO%"\org\springframework\spring-context-support\3.0.7.RELEASE\spring-context-support-3.0.7.RELEASE.jar;"%REPO%"\org\springframework\spring-web\3.0.7.RELEASE\spring-web-3.0.7.RELEASE.jar;"%REPO%"\org\springframework\security\oauth\spring-security-oauth2\1.0.0.RC1\spring-security-oauth2-1.0.0.RC1.jar;"%REPO%"\org\springframework\security\spring-security-core\3.1.0.RELEASE\spring-security-core-3.1.0.RELEASE.jar;"%REPO%"\org\springframework\security\spring-security-crypto\3.1.0.RELEASE\spring-security-crypto-3.1.0.RELEASE.jar;"%REPO%"\org\springframework\security\spring-security-config\3.1.0.RELEASE\spring-security-config-3.1.0.RELEASE.jar;"%REPO%"\org\springframework\security\spring-security-web\3.1.0.RELEASE\spring-security-web-3.1.0.RELEASE.jar;"%REPO%"\commons-codec\commons-codec\1.3\commons-codec-1.3.jar;"%REPO%"\commons-httpclient\commons-httpclient\3.1\commons-httpclient-3.1.jar;"%REPO%"\org\codehaus\jackson\jackson-core-asl\1.6.2\jackson-core-asl-1.6.2.jar;"%REPO%"\org\codehaus\jackson\jackson-mapper-asl\1.6.2\jackson-mapper-asl-1.6.2.jar;"%REPO%"\commons-io\commons-io\2.1\commons-io-2.1.jar;"%REPO%"\commons-dbcp\commons-dbcp\1.4\commons-dbcp-1.4.jar;"%REPO%"\commons-pool\commons-pool\1.5.4\commons-pool-1.5.4.jar;"%REPO%"\org\springframework\batch\spring-batch-core\2.1.7.RELEASE\spring-batch-core-2.1.7.RELEASE.jar;"%REPO%"\org\springframework\batch\spring-batch-infrastructure\2.1.7.RELEASE\spring-batch-infrastructure-2.1.7.RELEASE.jar;"%REPO%"\com\thoughtworks\xstream\xstream\1.3\xstream-1.3.jar;"%REPO%"\xpp3\xpp3_min\1.1.4c\xpp3_min-1.1.4c.jar;"%REPO%"\org\codehaus\jettison\jettison\1.1\jettison-1.1.jar;"%REPO%"\com\mkyong\common\SpringExample\1.0-SNAPSHOT\SpringExample-1.0-SNAPSHOT.jar
set EXTRA_JVM_ARGUMENTS=
goto endInit

@REM Reaching here means variables are defined and arguments have been captured
:endInit

%JAVACMD% %JAVA_OPTS% %EXTRA_JVM_ARGUMENTS% -classpath %CLASSPATH_PREFIX%;%CLASSPATH% -Dapp.name="app" -Dapp.repo="%REPO%" -Dbasedir="%BASEDIR%" com.mkyong.common.App %CMD_LINE_ARGS%
if ERRORLEVEL 1 goto error
goto end

:error
if "%OS%"=="Windows_NT" @endlocal
set ERROR_CODE=%ERRORLEVEL%

:end
@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" goto endNT

@REM For old DOS remove the set variables from ENV - we assume they were not set
@REM before we started - at least we don't leave any baggage around
set CMD_LINE_ARGS=
goto postExec

:endNT
@REM If error code is set to 1 then the endlocal was done already in :error.
if %ERROR_CODE% EQU 0 @endlocal


:postExec

if "%FORCE_EXIT_ON_ERROR%" == "on" (
  if %ERROR_CODE% NEQ 0 exit %ERROR_CODE%
)

exit /B %ERROR_CODE%
