# Define connection string
$serverName = "SQL"
$databaseName = "SQL"
$connectionString = "Server=$serverName;Database=$databaseName;Integrated Security=True;"

# Create a new SqlConnection object
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

# Open the connection
$connection.Open()

# Check if the connection is open
if ($connection.State -eq [System.Data.ConnectionState]::Open) {
    Write-Output "Connection successful!"
} else {
    Write-Output "Failed to connect."
}

# Close the connection
$connection.Close()
