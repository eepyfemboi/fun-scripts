$ip = [System.Net.Dns]::GetHostByName($env:COMPUTERNAME).AddressList[0].ToString()
$octets = $ip.Split(".")
$number = 0

foreach ($octet in $octets) {
    $number = ($number -shl 8) + [int]$octet
}

Write-Host $number
