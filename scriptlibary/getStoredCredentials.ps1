# Get a list of all stored credentials using cmdkey and filter for TargetName
$credentials = cmdkey /list | Select-String "Target:"

# Display the credentials
$credentials