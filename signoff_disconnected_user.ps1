$queryResult = quser
$disconnectedUsers = $queryResult | Select-String "Disc"
###Change the string in case you have Windows installed on different language, exemple change it to Déco for French

$currentDate = Get-Date

foreach ($userLine in $disconnectedUsers) {
    $sessionId = ($userLine -split '\s+')[2]
    $idleDate = ($userLine -split '\s+')[5]

    $lastDisconnectDate = [DateTime]::ParseExact($idleDate, 'MM/dd/yyyy', $null)

    $daysDisconnected = ($currentDate - $lastDisconnectDate).Days

    if ($daysDisconnected -gt 1) {
    ### You can change the number 1 with the number of days you want, for exemple change it to 3 to logoff only users that has been disconnected for more than 3 days
        logoff $sessionId
        Write-Host "User $sessionId has been logged off."
    }
}
