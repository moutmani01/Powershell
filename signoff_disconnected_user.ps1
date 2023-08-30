Sure, here's a PowerShell script that will help you delete sessions that have been disconnected for more than 3 days:

```powershell
# Get the current date
$currentDate = Get-Date

# Get disconnected sessions older than 3 days
$disconnectedSessions = Get-RDUserSession | Where-Object { $_.State -eq 'Disconnected' -and ($currentDate - $_.DisconnectTime).Days -gt 3 }

# Delete the sessions
foreach ($session in $disconnectedSessions) {
    Invoke-RDUserLogoff -UnifiedSessionID $session.UnifiedSessionID -Force
}
