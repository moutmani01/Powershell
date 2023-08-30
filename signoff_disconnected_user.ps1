I apologize for the inconvenience. It seems like there might be compatibility issues or variations in the `query user` command output based on the Windows version or locale.

As an alternative, you could consider using PowerShell, which provides more reliable ways to handle this task across different Windows environments. Here's a PowerShell script that should log off all disconnected users and display messages for each logoff:

```powershell
$queryResult = quser
$disconnectedUsers = $queryResult | Where-Object { $_ -match "Disc" }

foreach ($userLine in $disconnectedUsers) {
    $sessionId = $userLine -replace '\s+', ' ' -split ' ')[2]
    logoff $sessionId
    Write-Host "User $sessionId has been logged off."
}
```

To use this script, open PowerShell and run it. It should log off disconnected users and display messages accordingly. Remember to test it in a controlled environment before using it in a production setting.