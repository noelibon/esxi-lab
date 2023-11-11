Import-Module ActiveDirectory

$users = Import-CSV -Path .\users.csv

Foreach($user in $users) {
    $username = $user.username
    $firstname = $user.firstname
    $lastname = $user.lastname
    $password = "Test1234!"
    $ou = "Users"

    if (Get-ADUser -Filter { SamAccountName -eq $username }) {
        Write-Warning "User $username already exists."
    } else {
        New-ADUser -Name "$firstname $lastname" `
            -SamAccountName $username `
            -GivenName $firstname `
            -Surname $lastname `
            -Enabled $True `
            -DisplayName "$lastname, $firstname" `
            -Path "OU=$ou,DC=l1-4,DC=lab" `
            -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
            -ChangePasswordAtLogon $false `
            -PasswordNeverExpire $True
    }
}