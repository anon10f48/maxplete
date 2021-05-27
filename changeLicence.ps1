[CmdletBinding()]
Param(
 [Parameter(Mandatory=$true)]
   [string]$filename =""
   )

$license = import-csv $filename
foreach ($user in $license)
{
    $recipient = get-recipient $user.email
    if ($recipient.recipienttypedetails -eq "RemoteUserMailbox")
    {
        Set-remotemailbox $($user.email) -customattribute15 $($user.newlic) -CustomAttribute14 $Null
    }
    else
    {
        Set-mailbox $($user.email) -customattribute15 $($user.newlic) -CustomAttribute14 $Null
    }
    if ($user.PBI -eq "X")
    {
        Add-ADGroupMember G-R-Licensing-O365-E1addon-PowerBI -members $($recipient.samaccountname) 
    }
    if ($user.PP3 -eq "X")
    {
        Add-ADGroupMember G-R-Licensing-O365-P365ProPlan3 -members $($recipient.samaccountname) 
    }
    if ($user.DPD -eq "X")
    {
        Add-ADGroupMember G-R-Licensing-O365-E1addon-telephonesys -members $($recipient.samaccountname) 
    }

}