
  export async function onRequestGet({ params }) {
    const res = await fetch(`https://idjjtwzuv8so.objectstorage.us-ashburn-1.oci.customer-oci.com/n/idjjtwzuv8so/b/fbcwh-podcasts/o/rss.xml`);
    const data = await res.text();
    
    const myHeaders = new Headers({
      'Content-Type': 'text/xml'
    });
    return new Response(data, {headers: myHeaders});
  }

  