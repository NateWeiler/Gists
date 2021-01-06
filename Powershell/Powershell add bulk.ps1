#import the AD module
Import-Module activedirectory

#Tu will import from csv
$ ADUsers = Import-csv C: \ Users \ Administrator \ Desktop \ users.csv

#i we loop for every user
foreach ($ User in $ ADUsers)
{
		
	$ Username = $ User.username
	$ Password = $ User.password
	$ Firstname = $ User.firstname
	$ Lastname = $ User.lastname
	$ OU = $ User.ou


	# to see if a user already exists in AD
	if (Get-ADUser -F {SamAccountName -eq $ Username})
	{
		 #If user does exist, give a warning
		 Write-Warning "Account with username $ Username already exists in AD"
	}
	else
	{
		New-ADUser `
            -SamAccountName $ Username `
            -UserPrincipalName "$Username@professional.local" `#here you edit the domain
            -Name "$ Firstname $ Lastname" `
            -GivenName $ Firstname `
            -Surname $ Lastname `
            -Enabled $ True `
            -DisplayName "$ Lastname, $ Firstname" `
            -Path $ OU `
            -AccountPassword (convertto-securestring $ Password -AsPlainText -Force) -ChangePasswordAtLogon $ True # I decided that changing the password at login will be the best option
            
	}
}

#Mr. Richard Stallman, bless my code