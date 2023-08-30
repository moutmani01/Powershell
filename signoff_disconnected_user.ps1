Certainly, if you only want to check the date difference and not the hours and minutes, you can simplify the script as follows:

```powershell
$queryResult = quser
$disconnectedUsers = $queryResult | Select-String "Disc"

$currentDate = Get-Date

foreach ($userLine in $disconnectedUsers) {
    $sessionId = ($userLine -split '\s+')[2]
    $idleDate = ($userLine -split '\s+')[5]

    $lastDisconnectDate = [DateTime]::ParseExact($idleDate, 'MM/dd/yyyy', $null)

    $daysDisconnected = ($currentDate - $lastDisconnectDate).Days

    if ($daysDisconnected -gt 1) {
        logoff $sessionId
        Write-Host "User $sessionId has been logged off."
    }
}
```

This script parses the date of the last disconnect from the session information, calculates the days since that date, and if the days disconnected are greater than 1, it logs off the user session.

Please give this version a try, and remember to test it before using it in a production environment.