Param
(
	[Parameter(Mandatory=$true)]
	[string]$InputFile =""
)

#Import AD Module
Import-Module ActiveDirectory

$OutputFile = "$InputFile.out"

$users = Import-Csv $InputFile

foreach ($user in $users)
{
	$UserEmail = $user.email
	get-aduser -filter {emailaddress -eq $UserEmail} -properties emailaddress, extensionAttribute15, extensionAttribute14, samaccountname | select-object emailaddress,extensionAttribute15, extensionAttribute14, samaccountname | export-csv -Path $OutputFile -Append -NoTypeInformation
}