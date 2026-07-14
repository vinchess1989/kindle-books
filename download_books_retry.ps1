$books = @(
    @{ title="The_Wonderful_Wizard_of_Oz.epub"; url="https://www.gutenberg.org/ebooks/55.epub.images" },
    @{ title="Peter_Pan.epub"; url="https://www.gutenberg.org/ebooks/16.epub.images" },
    @{ title="The_Secret_Garden.epub"; url="https://www.gutenberg.org/ebooks/113.epub.images" }
)

$folder = "Books_for_10_Year_Old"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

foreach ($book in $books) {
    $filepath = Join-Path $folder $book.title
    $success = $false
    $retries = 3
    while (!$success -and $retries -gt 0) {
        try {
            Write-Host "Downloading $($book.title) (Retries left: $retries)..."
            Start-Sleep -Seconds 2
            Invoke-WebRequest -Uri $book.url -OutFile $filepath -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36" -TimeoutSec 120
            $success = $true
            Write-Host "Saved to $filepath"
        } catch {
            Write-Host "Failed, retrying..."
            $retries--
            Start-Sleep -Seconds 3
        }
    }
}
Write-Host "All remaining downloads finished!"
