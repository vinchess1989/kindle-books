const https = require('https');

async function fetchMalayalamBooks() {
    const url = `https://archive.org/advancedsearch.php?q=language:%22malayalam%22+AND+mediatype:%22texts%22+AND+(title:%22katha%22+OR+title:%22kathakal%22+OR+title:%22panchatantra%22+OR+title:%22aesop%22+OR+title:%22balarama%22+OR+title:%22kuttikal%22)&fl[]=identifier,title,creator,date,description&rows=50&output=json`;
    
    try {
        const data = await new Promise((resolve, reject) => {
            https.get(url, res => {
                let body = '';
                res.on('data', chunk => body += chunk);
                res.on('end', () => resolve(JSON.parse(body)));
            }).on('error', reject);
        });
        
        const docs = data.response?.docs || [];
        const validDocs = docs.filter(d => d.identifier && !d.identifier.includes('keralalegislativeassembly') && !d.identifier.includes('incr-'));
        const selected = validDocs.slice(0, 10);
        
        const formattedBooks = selected.map(doc => {
            return `    { "title": ${JSON.stringify(doc.title || "Malayalam Book")}, "author": ${JSON.stringify(doc.creator || "Traditional")}, "url": "https://archive.org/details/${doc.identifier}", "language": "Malayalam", "year": ${JSON.stringify((doc.date || "Unknown").substring(0,4))}, "source": "Archive.org", "pages": "100", "size": "Read Online", "type": "Fiction", "themes": "Stories, Kids", "summary": ${JSON.stringify((doc.description || "Authentic Malayalam story book.").substring(0, 150).replace(/\n/g, ' '))}, "format": "Web PDF" }`;
        });
        
        console.log("[\n" + formattedBooks.join(",\n") + "\n]");
    } catch (e) {
        console.error("Error", e);
    }
}
fetchMalayalamBooks();
