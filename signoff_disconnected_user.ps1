# PowerShell script that will help you delete sessions that have been disconnected for more than 3 days, generated by ChatGPT :
# Get the current date
$currentDate = Get-Date

# Get disconnected sessions older than 3 days
$disconnectedSessions = Get-RDUserSession | Where-Object { $_.State -eq 'Disconnected' -and ($currentDate - $_.DisconnectTime).Days -gt 3 }

# Delete the sessions
foreach ($session in $disconnectedSessions) {
    Invoke-RDUserLogoff -UnifiedSessionID $session.UnifiedSessionID -Force
}



I apologize for the confusion. You're right, the condition in the `Where-Object` might not work as expected for date comparisons. Here's a revised script that should address the issue:

```powershell
# Get the current date
$currentDate = Get-Date

# Get disconnected sessions older than 3 days
$disconnectedSessions = Get-RDUserSession | Where-Object { $_.State -eq 'Disconnected' -and ($currentDate - $_.LastConnectionTime).TotalDays -gt 3 }

# Delete the sessions
foreach ($session in $disconnectedSessions) {
    Invoke-RDUserLogoff -UnifiedSessionID $session.UnifiedSessionID -Force
}
```

In this version, I'm comparing the difference in `TotalDays` between the current date and the `LastConnectionTime` property of the session to determine if it has been disconnected for more than 3 days. This should work more accurately.