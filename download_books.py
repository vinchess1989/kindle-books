import os
import urllib.request

def download_file(url, folder, filename):
    if not os.path.exists(folder):
        os.makedirs(folder)
    
    filepath = os.path.join(folder, filename)
    print(f"Downloading {filename}...")
    try:
        # Use a user-agent to avoid 403 Forbidden errors on some sites
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req) as response, open(filepath, 'wb') as out_file:
            data = response.read()
            out_file.write(data)
        print(f"Successfully downloaded to {filepath}")
    except Exception as e:
        print(f"Failed to download {filename}: {e}")

books = [
    {
        "title": "Alice's Adventures in Wonderland",
        "url": "https://www.gutenberg.org/ebooks/11.epub.images",
        "filename": "Alices_Adventures_in_Wonderland.epub"
    },
    {
        "title": "The Wonderful Wizard of Oz",
        "url": "https://www.gutenberg.org/ebooks/55.epub.images",
        "filename": "The_Wonderful_Wizard_of_Oz.epub"
    },
    {
        "title": "Treasure Island",
        "url": "https://www.gutenberg.org/ebooks/120.epub.images",
        "filename": "Treasure_Island.epub"
    },
    {
        "title": "Peter Pan",
        "url": "https://www.gutenberg.org/ebooks/16.epub.images",
        "filename": "Peter_Pan.epub"
    },
    {
        "title": "The Secret Garden",
        "url": "https://www.gutenberg.org/ebooks/113.epub.images",
        "filename": "The_Secret_Garden.epub"
    }
]

download_folder = "Books_for_10_Year_Old"

for book in books:
    download_file(book['url'], download_folder, book['filename'])

print("\nAll downloads finished!")
