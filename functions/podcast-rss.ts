
  export async function onRequestGet({ params }) {
    const res = await fetch(`https://objectstorage.us-ashburn-1.oraclecloud.com/p/44k0LXGNmgD40Qfd8kiJaNQQpYz1VvdGCXN5CGTm62roMSKcAR4kYzOn-vvGCUj6/n/idjjtwzuv8so/b/fbcwh-podcasts/o/rss.xml`);
    const data = await res.text();
    
    const myHeaders = new Headers({
      'Content-Type': 'text/xml'
    });
    return new Response(data, {headers: myHeaders});
  }