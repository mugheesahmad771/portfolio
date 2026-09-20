/**
 * Dynamic rendering for search-engine/social-preview crawlers.
 *
 * Real visitors always get exactly what they got before this file existed —
 * the Flutter app, served from `env.ASSETS` untouched. The reason this
 * exists: Flutter Web paints everything to a canvas/WASM surface with no
 * real DOM text nodes, so a crawler that fetches this site — even one that
 * executes JavaScript, like Googlebot — finds an empty page once the app
 * boots. `document.body.innerText` on the live production site is 0
 * characters long even after full load; verified directly, not assumed.
 *
 * The fix (a technique Google calls "dynamic rendering", endorsed for
 * exactly this JS-heavy-SPA situation): detect known crawler/bot user
 * agents and, for those requests only, return a plain static HTML page
 * with the same real content a human would eventually see — sourced live
 * from the same backend API the Flutter app itself calls, so there's
 * nothing to keep in sync by hand for project data. Everyone else's
 * request falls straight through to `env.ASSETS.fetch()` unchanged.
 *
 * This is not cloaking — cloaking is serving *different* content to bots
 * vs. humans to manipulate rankings. What each audience sees here
 * describes the same real thing, just in a format each can use.
 */

const API_BASE = 'https://portfolio-be-ehsu.onrender.com';
const SITE_URL = 'https://portfolio.mugheesahmad771.workers.dev';
const BRAND = 'Mughees Ahmad — Flutter & Full-Stack Developer';
// Landscape (1200x630), not the portrait profile photo — LinkedIn/
// Facebook/Twitter link previews need a landscape og:image; the profile
// photo is 716x1098 portrait and silently fails their preview generator.
const OG_IMAGE = 'https://pub-9ca4a2481e534af9b41b8401fd916b81.r2.dev/a51958c312b44b3e9a1e1a77297021bf.png';

// Known search/social crawler user agents. Matching on the request's own
// path keeps this from ever intercepting an asset request (JS bundles,
// images, fonts) — only the specific page routes below are handled, so a
// bot's own subsequent requests for those assets still reach env.ASSETS
// normally, same as a human's.
const BOT_UA = /googlebot|bingbot|slurp|duckduckbot|baiduspider|yandexbot|facebookexternalhit|twitterbot|linkedinbot|slackbot|discordbot|telegrambot|whatsapp|applebot|embedly|quora link preview|pinterestbot|redditbot|ia_archiver|semrushbot|ahrefsbot/i;

function escapeHtml(value) {
  return String(value ?? '').replace(/[&<>"']/g, (c) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
  })[c]);
}

const NAV_LINKS = [
  ['/', 'Home'],
  ['/about', 'About'],
  ['/experience', 'Experience'],
  ['/projects', 'Projects'],
  ['/skills', 'Skills'],
  ['/resume', 'Resume'],
  ['/contact', 'Contact'],
];

function renderPage({ title, description, path, bodyHtml, jsonLd }) {
  const url = `${SITE_URL}${path}`;
  const nav = NAV_LINKS.map(
    ([href, label]) => `<a href="${href}">${escapeHtml(label)}</a>`,
  ).join(' · ');

  return `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${escapeHtml(title)}</title>
<meta name="description" content="${escapeHtml(description)}">
<meta name="robots" content="index, follow">
<meta name="google-site-verification" content="wRCNoTPOfvIbOEthdx0b4MK9gTGqiRpKib2BtofNvzk" />
<meta name="msvalidate.01" content="0AA717FA8A7A4C063718853F922CF966" />
<link rel="canonical" href="${url}">
<meta property="og:title" content="${escapeHtml(title)}">
<meta property="og:description" content="${escapeHtml(description)}">
<meta property="og:type" content="website">
<meta property="og:url" content="${url}">
<meta property="og:image" content="${OG_IMAGE}">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="${escapeHtml(title)}">
<meta name="twitter:description" content="${escapeHtml(description)}">
<meta name="twitter:image" content="${OG_IMAGE}">
${jsonLd ? `<script type="application/ld+json">${JSON.stringify(jsonLd)}</script>` : ''}
</head>
<body>
<header><nav aria-label="Site">${nav}</nav></header>
<main>
${bodyHtml}
</main>
</body>
</html>`;
}

function renderHome() {
  return renderPage({
    title: BRAND,
    description:
      'Mughees Ahmad — Senior Flutter & Full-Stack Developer at HBit Technology LLC. 3+ years building production Flutter, React Native, Angular and ASP.NET Core applications.',
    path: '/',
    bodyHtml: `
      <h1>Mughees Ahmad</h1>
      <p>Senior Flutter &amp; Full-Stack Developer at HBit Technology LLC.</p>
      <p>3+ years building production Flutter, React Native, Angular and ASP.NET Core applications — from UI to shipped, released apps.</p>
      <p><a href="mailto:mugheesahmad771@gmail.com">mugheesahmad771@gmail.com</a></p>
    `,
    jsonLd: {
      '@context': 'https://schema.org',
      '@type': 'Person',
      name: 'Mughees Ahmad',
      url: SITE_URL + '/',
      image: `${SITE_URL}/assets/assets/image/jpeg/profile.jpeg`,
      jobTitle: 'Senior Flutter & Full Stack Developer',
      worksFor: { '@type': 'Organization', name: 'HBit Technology LLC' },
      sameAs: [
        'https://github.com/mugheesahmad771',
        'https://www.linkedin.com/in/mughees-ahmad-977105414/',
      ],
    },
  });
}

function renderAbout() {
  return renderPage({
    title: `About — ${BRAND}`,
    description:
      'About Mughees Ahmad: background, engineering approach and the path to becoming a Senior Flutter & Full-Stack Developer building production mobile and web apps.',
    path: '/about',
    bodyHtml: `
      <h1>About Mughees Ahmad</h1>
      <p>I'm a Flutter developer with 3+ years of professional experience building high-quality, cross-platform mobile applications for iOS and Android. I work across the whole stack — from Flutter and React Native clients to C# ASP.NET Web APIs and Angular admin dashboards — and I take features from a UI sketch to a released, production app.</p>
      <p>Alongside mobile and full-stack work, I've been hands-on with AI-powered features, machine learning integrations and intelligent automation — always with an eye on clean, maintainable code and a smooth user experience.</p>
      <h2>Education</h2>
      <p>ADS / ADP in Computer Science — Pakistan, 14 Years of Education</p>
    `,
  });
}

function renderSkills() {
  const groups = [
    ['Mobile', ['Flutter', 'Dart', 'GetX (Advanced)', 'Provider', 'Bloc', 'Android', 'iOS']],
    ['Frontend', ['Angular 18+', 'TypeScript', 'JavaScript', 'HTML5', 'CSS3', 'React Native']],
    ['Backend / API', ['C# (.NET)', 'ASP.NET Web API', 'REST APIs', 'JSON', 'HTTP / Dio']],
    ['Data & Cloud', ['Firebase', 'SQL Server', 'SQLite']],
    ['AI / Automation', ['AI-powered features', 'ML integrations', 'Intelligent automation']],
    ['Tools & Practice', ['Git', 'GitHub', 'Postman', 'VS Code', 'Visual Studio', 'Agile/Scrum']],
  ];
  const sections = groups
    .map(
      ([category, skills]) =>
        `<h2>${escapeHtml(category)}</h2><p>${skills.map(escapeHtml).join(', ')}</p>`,
    )
    .join('\n');
  return renderPage({
    title: `Skills — ${BRAND}`,
    description:
      'Technical skills of Mughees Ahmad: Flutter, React Native, Angular, ASP.NET Core and full-stack mobile/web app development.',
    path: '/skills',
    bodyHtml: `<h1>Skills</h1>${sections}`,
  });
}

function renderResume() {
  return renderPage({
    title: `Resume — ${BRAND}`,
    description:
      'Resume of Mughees Ahmad, Senior Flutter & Full-Stack Developer at HBit Technology LLC — download the full CV as PDF.',
    path: '/resume',
    bodyHtml: `
      <h1>Resume</h1>
      <p>Mughees Ahmad — Senior Flutter &amp; Full-Stack Developer at HBit Technology LLC.</p>
      <p><a href="/Mughees_Ahmad_Flutter_CV-3.pdf">Download the full CV (PDF)</a></p>
    `,
  });
}

function renderContact() {
  return renderPage({
    title: `Contact — ${BRAND}`,
    description:
      'Get in touch with Mughees Ahmad for Flutter, React Native and full-stack development opportunities.',
    path: '/contact',
    bodyHtml: `
      <h1>Contact</h1>
      <p>Email: <a href="mailto:mugheesahmad771@gmail.com">mugheesahmad771@gmail.com</a></p>
    `,
  });
}

async function renderExperience() {
  const res = await fetch(`${API_BASE}/api/Experience`);
  if (!res.ok) return null;
  const items = await res.json();
  const sections = items
    .map((e) => {
      const resp = (e.responsibilities || [])
        .map((r) => `<li>${escapeHtml(r)}</li>`)
        .join('');
      return `
        <h2>${escapeHtml(e.role)} — ${escapeHtml(e.company)}</h2>
        <p>${escapeHtml(e.location)} · ${escapeHtml(e.duration)}</p>
        <ul>${resp}</ul>
      `;
    })
    .join('\n');
  return renderPage({
    title: `Experience — ${BRAND}`,
    description:
      'Professional work history of Mughees Ahmad, Senior Flutter & Full-Stack Developer — roles, companies and technologies across 3+ years in production app development.',
    path: '/experience',
    bodyHtml: `<h1>Experience</h1>${sections}`,
  });
}

async function renderProjectsList() {
  const res = await fetch(`${API_BASE}/api/Projects?pageSize=50`);
  if (!res.ok) return null;
  const data = await res.json();
  const items = data.items || data;
  const list = items
    .map(
      (p) =>
        `<li><a href="/projects/${escapeHtml(p.slug)}">${escapeHtml(p.title)}</a> — ${escapeHtml(p.shortDescription)}</li>`,
    )
    .join('');
  return renderPage({
    title: `Projects — ${BRAND}`,
    description:
      'Production Flutter, React Native and full-stack projects built by Mughees Ahmad, including enterprise work shown NDA-safe.',
    path: '/projects',
    bodyHtml: `<h1>Projects</h1><ul>${list}</ul>`,
  });
}

async function renderProjectDetail(slug) {
  const res = await fetch(`${API_BASE}/api/Projects/${encodeURIComponent(slug)}`);
  if (!res.ok) return null;
  const p = await res.json();
  const tech = (p.technologies || []).map(escapeHtml).join(', ');
  const platforms = (p.platforms || []).map(escapeHtml).join(', ');
  const features = (p.keyFeatures || [])
    .map((f) => `<li>${escapeHtml(f)}</li>`)
    .join('');
  return renderPage({
    title: `${p.title} — ${BRAND}`,
    description: p.shortDescription || p.fullDescription || '',
    path: `/projects/${slug}`,
    bodyHtml: `
      <h1>${escapeHtml(p.title)}</h1>
      <p>${escapeHtml(p.fullDescription || p.shortDescription)}</p>
      ${p.role ? `<p>Role: ${escapeHtml(p.role)}${p.canShowCompanyName && p.company ? ` at ${escapeHtml(p.company)}` : ''}</p>` : ''}
      ${tech ? `<h2>Technologies</h2><p>${tech}</p>` : ''}
      ${platforms ? `<h2>Platforms</h2><p>${platforms}</p>` : ''}
      ${features ? `<h2>Key Features</h2><ul>${features}</ul>` : ''}
    `,
  });
}

async function renderForPath(pathname) {
  if (pathname === '/' || pathname === '/home') return renderHome();
  if (pathname === '/about') return renderAbout();
  if (pathname === '/skills') return renderSkills();
  if (pathname === '/resume') return renderResume();
  if (pathname === '/contact') return renderContact();
  if (pathname === '/experience') return renderExperience();
  if (pathname === '/projects') return renderProjectsList();
  if (pathname.startsWith('/projects/')) {
    const slug = pathname.slice('/projects/'.length);
    if (slug) return renderProjectDetail(slug);
  }
  return null;
}

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const userAgent = request.headers.get('User-Agent') || '';

    if (BOT_UA.test(userAgent)) {
      try {
        const html = await renderForPath(url.pathname);
        if (html) {
          return new Response(html, {
            headers: {
              'content-type': 'text/html; charset=utf-8',
              // Edge-cached so a crawl burst doesn't hammer the backend
              // API on every request for the same route.
              'cache-control': 'public, max-age=3600',
            },
          });
        }
      } catch (err) {
        // Backend hiccup (e.g. a cold start) — fall through to the normal
        // app rather than show the bot a broken response.
      }
    }

    return env.ASSETS.fetch(request);
  },
};
