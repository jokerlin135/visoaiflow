// Simple Node.js proxy for Hugging Face API
// This protects the API token from being exposed in client-side code

const http = require('http');
const https = require('https');

const HF_TOKEN = process.env.HUGGINGFACE_API_TOKEN;
const PORT = 3000;

const server = http.createServer((req, res) => {
  // Enable CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.writeHead(200);
    res.end();
    return;
  }

  if (req.method !== 'POST') {
    res.writeHead(405);
    res.end('Method Not Allowed');
    return;
  }

  let body = [];
  req.on('data', chunk => body.push(chunk));
  
  req.on('end', () => {
    try {
      const data = JSON.parse(Buffer.concat(body).toString());
      const { model, inputs, parameters } = data;

      if (!model || !inputs) {
        res.writeHead(400);
        res.end(JSON.stringify({ error: 'Missing model or inputs' }));
        return;
      }

      // Call Hugging Face API
      const options = {
        hostname: 'api-inference.huggingface.co',
        port: 443,
        path: `/models/${model}`,
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${HF_TOKEN}`,
          'Content-Type': 'application/json',
        },
      };

      const hfReq = https.request(options, (hfRes) => {
        const chunks = [];
        
        hfRes.on('data', (chunk) => chunks.push(chunk));
        
        hfRes.on('end', () => {
          const buffer = Buffer.concat(chunks);
          
          if (hfRes.headers['content-type']?.includes('image')) {
            res.writeHead(200, { 'Content-Type': 'image/jpeg' });
            res.end(buffer);
          } else {
            res.writeHead(hfRes.statusCode, { 'Content-Type': 'application/json' });
            res.end(buffer);
          }
        });
      });

      hfReq.on('error', (error) => {
        console.error('HF API Error:', error);
        res.writeHead(500);
        res.end(JSON.stringify({ error: error.message }));
      });

      const payload = { inputs, ...(parameters && { parameters }) };
      hfReq.write(JSON.stringify(payload));
      hfReq.end();

    } catch (error) {
      res.writeHead(400);
      res.end(JSON.stringify({ error: 'Invalid JSON' }));
    }
  });
});

server.listen(PORT, () => {
  console.log(`🚀 HuggingFace Proxy running on port ${PORT}`);
});
