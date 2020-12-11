@echo off
echo "Loading maven properties:"

rem eol stops comments from being parsed
rem otherwise split lines at the = char into two tokens
for /F "eol=# delims== tokens=1,*" %%a in (maven.properties) do (

    rem proper lines have both a and b set
    rem if okay, assign property to some kind of namespace
    rem so some.property becomes maven.some.property in batch-land
    if NOT "%%a"=="" if NOT "%%b"=="" set maven.%%a=%%b
)

rem debug namespace maven.
set maven

echo "Done loading properties."

set /p filename="Enter filename: "
set /p issnapshot="Snapshot release (y/n): "


rem get version and type
set versionAndExtension=%filename:*_=%
echo %versionAndExtension%

for /f "tokens=1 delims=_" %%a in ("%filename%") do (
  set artifactId=%%a
)

rem parse version and type
for /f "tokens=1-3 delims=." %%a in ("%versionAndExtension%") do (
	set "major=%%a"
        set "minor=%%b"
        set "fileType=%%c"
)

echo "Parsed filename: [%major%] [%minor%] [%fileType%]"

if %issnapshot%==y (
	set releasetype=-SNAPSHOT
	set repoURL=%maven.snapshot-repositoryURL%
	set repoID=%maven.snapshot-repositoryId%
) else (
	set releasetype=
	set repoURL=%maven.release-repositoryURL%
	set repoID=%maven.release-repositoryId%
)

call mvn deploy:deploy-file -DgroupId=%maven.default-groupId% -DartifactId=%artifactId% -Dversion=%major%.%minor%%releasetype% -Dpackaging=%fileType% -Dfile=%filename% -DrepositoryId=%repoID% -Durl=%repoURL%

rem cleanup namespace maven.
rem nul redirection stops error output if no test. var is set
for /F "tokens=1 delims==" %%v in ('set test. 2^>nul') do (
    set %%v=
)

pause

