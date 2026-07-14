$books = @(
    @{ title="Alices_Adventures_in_Wonderland.epub"; url="https://www.gutenberg.org/ebooks/11.epub.images" },
    @{ title="The_Wonderful_Wizard_of_Oz.epub"; url="https://www.gutenberg.org/ebooks/55.epub.images" },
    @{ title="Treasure_Island.epub"; url="https://www.gutenberg.org/ebooks/120.epub.images" },
    @{ title="Peter_Pan.epub"; url="https://www.gutenberg.org/ebooks/16.epub.images" },
    @{ title="The_Secret_Garden.epub"; url="https://www.gutenberg.org/ebooks/113.epub.images" }
)

$folder = "Books_for_10_Year_Old"
if (!(Test-Path $folder)) {
    New-Item -ItemType Directory -Path $folder | Out-Null
}

foreach ($book in $books) {
    $filepath = Join-Path $folder $book.title
    Write-Host "Downloading $($book.title)..."
    Invoke-WebRequest -Uri $book.url -OutFile $filepath -UserAgent "Mozilla/5.0"
    Write-Host "Saved to $filepath"
}
Write-Host "All downloads finished!"
