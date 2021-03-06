# Script:   Get-Remote-LocalAdmins
# Purpose:  This script print the members of a remote machine's local Admins group
# Author:   Diego Messiah | https://github.com/diegomessiah	

$Computers = Get-Content computers.txt 
ForEach ($Computer in $Computers)
{
  function get-localadmin 
  { 
    param ($strcomputer) 
    $admins = Gwmi win32_groupuser –computer $strcomputer  
    $admins = $admins |? {$_.groupcomponent –like '*"Administrators"'
   } 
    $admins |% 
    { 
   $_.partcomponent –match “.+Domain\=(.+)\,Name\=(.+)$” > $nul 
   $matches[1].trim('"') + “\” + $matches[2].trim('"') 
    } 
    }
    get-localadmin $Computer | Out-File -Append .\localadmin.txt
  }
