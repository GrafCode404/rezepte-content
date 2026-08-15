$ErrorActionPreference = "Stop"
$recipesDir = Join-Path $PSScriptRoot "recipes"
$output = Join-Path $recipesDir "index.json"

function ConvertTo-JsonEscaped([string]$s) {
    $sb = New-Object System.Text.StringBuilder ($s.Length + 16)
    foreach ($c in $s.ToCharArray()) {
        switch ($c) {
            '"'  { [void]$sb.Append('\"') }
            '\'  { [void]$sb.Append('\\') }
            "`b" { [void]$sb.Append('\b') }
            "`f" { [void]$sb.Append('\f') }
            "`n" { [void]$sb.Append('\n') }
            "`r" { [void]$sb.Append('\r') }
            "`t" { [void]$sb.Append('\t') }
            default {
                if ([int]$c -lt 0x20) {
                    [void]$sb.Append('\u' + ([int]$c).ToString('X4'))
                } else {
                    [void]$sb.Append($c)
                }
            }
        }
    }
    return $sb.ToString()
}

$parts = @()
Get-ChildItem -LiteralPath $recipesDir -Filter "*.md" | Sort-Object Name | ForEach-Object {
    $content = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8
    $parts += ('{"name":"' + (ConvertTo-JsonEscaped $_.Name) + '","content":"' + (ConvertTo-JsonEscaped $content) + '"}')
}

$json = "[" + ($parts -join ",") + "]"
[System.IO.File]::WriteAllText($output, $json, (New-Object System.Text.UTF8Encoding($false)))
Write-Output "Geschrieben: $output ($($parts.Count) Rezepte)"
