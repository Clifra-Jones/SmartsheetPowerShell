
$script:BaseURI = "https://api.smartsheet.com/2.0"

#Private function
function Read-Config () {
    $ConfigPath = "$home/.smartsheet/config.json"
    $config = Get-Content -Raw -Path $ConfigPath | ConvertFrom-Json
    return $config
}

function ConvertTo-UTime () {
    Param(
        [datetime]$DateTime
    )

    $uTime = ([System.DateTimeOffset]$DateTime).ToUnixTimeMilliseconds() / 1000

    return $Utime
}

function ConvertFrom-UTime() {
    Param(
        [decimal]$Utime
    )

    [DateTime]$DateTime = [System.DateTimeOffset]::FromUnixTimeMilliseconds(1000 * $Utime).LocalDateTime

    return $DateTime
}

function Get-Headers() {
    $config = Read-Config
    $Authorization = "Bearer {0}" -f $Config.APIKey
    $Headers = @{
        "Authorization" = $Authorization
        "Content-Type" = 'application/json'
    }
    return $Headers
}