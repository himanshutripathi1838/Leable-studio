$ErrorActionPreference = "Stop"

$root = "D:\Railway_Pole_Labeling"
$imagesDir = Join-Path $root "images"
$outputFile = Join-Path $root "label_studio_tasks.json"

if (-not (Test-Path -LiteralPath $imagesDir)) {
    New-Item -ItemType Directory -Force -Path $imagesDir | Out-Null
}

$extensions = @(".jpg", ".jpeg", ".png", ".bmp", ".webp", ".tif", ".tiff")
$files = Get-ChildItem -LiteralPath $imagesDir -Recurse -File |
    Where-Object { $extensions -contains $_.Extension.ToLowerInvariant() } |
    Sort-Object FullName

$tasks = foreach ($file in $files) {
    $relativePath = $file.FullName.Substring($imagesDir.Length).TrimStart("\", "/")
    $relativePath = "images/" + ($relativePath -replace "\\", "/")
    [PSCustomObject]@{
        data = [PSCustomObject]@{
            image = "/data/local-files/?d=$relativePath"
        }
    }
}

$tasksJson = $tasks | ConvertTo-Json -Depth 10
[System.IO.File]::WriteAllText($outputFile, $tasksJson)


Write-Output "Created: $outputFile"
Write-Output "Image tasks: $($files.Count)"
