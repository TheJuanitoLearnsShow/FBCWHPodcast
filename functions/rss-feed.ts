export async function onRequest(context) {
    // Contents of context object
    const {
      request, // same as existing Worker API
      env, // same as existing Worker API
      params, // if filename includes [id] or [[path]]
      waitUntil, // same as ctx.waitUntil in existing Worker API
      next, // used for middleware or to fetch assets
      data, // arbitrary space for passing data between middlewares
    } = context;
  
    const res = await fetch(`https://idjjtwzuv8so.objectstorage.us-ashburn-1.oci.customer-oci.com/n/idjjtwzuv8so/b/fbcwh-podcasts/o/rss.xml`);
    const dataFromOracle = await res.text();
    

    const myHeaders = new Headers({
      'Content-Type': 'text/xml'
    });
    return new Response(dataFromOracle, {headers: myHeaders});
  }

