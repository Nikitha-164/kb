// resolve.js
async function normalize(text) {
  return (text || '')
    .toLowerCase()
    .replace(/[^a-z0-9\s:/().-]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

async function findErrorSlug(errorText) {
  const n = await normalize(errorText);

  // Load the alias index from S3 (same bucket, path /errors/index.json)
  const resp = await fetch('/errors/index.json', { cache: 'no-cache' });
  const index = await resp.json();

  for (const entry of Object.values(index)) {
    for (const a of entry.aliases || []) {
      if (a && n.includes(a)) return entry.slug;
    }
  }
  return 'unknown-error';
}

async function resolveAndRedirect() {
  const params = new URLSearchParams(window.location.search);
  const errorText = params.get('error') || '';
  const slug = await findErrorSlug(errorText);
  window.location.replace(`/errors/${slug}.yaml`);
}

// Trigger on page load
resolveAndRedirect();