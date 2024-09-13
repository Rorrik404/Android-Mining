# PowerShell script to query ccminer API

param (
    [string]$cmd = "hwinfo",
    [string]$address = "192.168.1.154",
    [int]$port = 4068
)

# Create a TCP client to connect to the specified address and port
try {
    $tcpClient = New-Object System.Net.Sockets.TcpClient
    $tcpClient.Connect($address, $port)
    
    $networkStream = $tcpClient.GetStream()
    
    # Send the command to the server
    $commandBytes = [System.Text.Encoding]::ASCII.GetBytes($cmd + "`n")
    $networkStream.Write($commandBytes, 0, $commandBytes.Length)
    
    # Read the response from the server
    $streamReader = New-Object System.IO.StreamReader($networkStream, [System.Text.Encoding]::ASCII)
    $response = $streamReader.ReadToEnd()
    
    # Close the network stream and TCP client
    $streamReader.Close()
    $networkStream.Close()
    $tcpClient.Close()
    
    # Print the response
    Write-Output $response
}
catch {
    Write-Output "No Connection"
}