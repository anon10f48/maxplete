#Connect Exchange Server PS Session

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://cgeexcp05/PowerShell/
Import-PSSession $Session -DisableNameChecking -AllowClobber
