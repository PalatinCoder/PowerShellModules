function Get-ExternalIP {

    <#
    .SYNOPSIS
    Gets the computer's external IP Address by calling ifconfig.co

    .PARAMETER Version

    Wheter to use IPv4 or IPv6. If omitted, no particular protocol version is forced
    Possible Values are "4" or "6"

    .EXAMPLE
    Get-ExternalIP
    203.0.113.2

    Get your external IP Address, using the preferred protocol

    .EXAMPLE
    Get-ExternalIP -Version 4
    203.0.113.4

    Get your public IPv4 address by forcing it

    .EXAMPLE
    Get-ExternalIP -Version 6
    2001:DB8::c0fe:babe


    Get your public IPv6 address by forcing it

    #>

    Param(
        [parameter(Mandatory=$false)]
        [ValidatePattern("[4|6]")]
        [String]
        $Version
    )

    $Subdomain = "";
    if ($Version -eq "6") { $Subdomain = "v6." }
    if ($Version -eq "4") { $Subdomain = "v4." }

    Write-Debug "Using endpoint $($Subdomain)ifconfig.co"

	(Invoke-WebRequest "$($Subdomain)ifconfig.co/ip").Content
}

Export-ModuleMember -Function Get-ExternalIP
