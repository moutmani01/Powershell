I'm glad to hear that the script worked for you! Here's the modified PowerShell script that will log off users who have been disconnected for more than 1 day:

```powershell
$queryResult = quser
$disconnectedUsers = $queryResult | Select-String "Disc"

$currentDate = Get-Date

foreach ($userLine in $disconnectedUsers) {
    $sessionId = ($userLine -split '\s+')[2]
    $idleTime = ($userLine -split '\s+')[4]

    $idleHours = [int]($idleTime -replace "(\d+)\:(\d+)", '$1')
    $idleMinutes = [int]($idleTime -replace "(\d+)\:(\d+)", '$2')

    $totalIdleTime = ($idleHours * 60) + $idleMinutes

    if ($totalIdleTime -gt 1440) {  # 1440 minutes = 1 day
        logoff $sessionId
        Write-Host "User $sessionId has been logged off."
    }
}
```

This script calculates the total idle time in minutes, and if it's greater than 1440 minutes (which corresponds to 1 day), it logs off the user and displays a message.

As always, make sure to test the script in a controlled environment before using it in a production setting.