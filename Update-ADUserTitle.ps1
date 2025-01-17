#This script would grab each user from an OU Searchbase and check the Title against the description, if the Title is different (which is correct)
#It will take the Title and replace the description, this is for BU's that use the Description field as a replacement for Title.
$OU = Read-Host "Please enter the OU that you want to work on" 
Write-host "You Selected OU - $OU" -ForegroundColor yellow -BackgroundColor green
$Users = Get-aduser -filter * -Searchbase "$OU" -properties Title, Description | Select Name, Samaccountname, Description, Title


Foreach ($User in $Users){

    if($($User.Description) -ne ($User.Title)){

        Write-Host "Updating $($User.Name) from $($User.Description) to $($User.Title). `n" -ForegroundColor Green
        Set-aduser -identity "$($User.SamAccountName)" -Description $($User.Title). #-whatif

    }else {

        Write-Host "$($User.Name)'s description ($($User.Description)) is accurate to their title ($($User.Title)), No changes have been made. `n" -ForegroundColor Yellow
    }
}