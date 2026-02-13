Miles & Smiles — Static Website

This folder contains a simple static website (HTML/CSS). Use one of the options below to deploy it publicly.

Quick options

1) GitHub Pages (recommended)
- Create a new GitHub repository (name it e.g. `miles-and-smiles-site`).
- From your local folder (C:\Users\mahad\.vscode) run:

```bash
git init
git add .
git commit -m "Initial site"
git branch -M main
git remote add origin https://github.com/<your-username>/<repo>.git
git push -u origin main
```

- The workflow `.github/workflows/deploy-pages.yml` will run on push to `main` and publish the files to GitHub Pages. The site URL will be:
  `https://<your-username>.github.io/<repo>/`

2) Netlify (drag & drop)
- Go to https://app.netlify.com/drop and drag the project folder into the page.
- Or use the Netlify CLI: `netlify deploy --dir=.`

3) Vercel
- Install Vercel CLI and run `vercel` from the project folder and follow prompts.

Notes
- If you want me to also create a Git repository and push to GitHub for you, I can prepare the repo locally but you must provide a remote (or authorize GitHub access). I cannot push to your GitHub from here without your credentials or an access token.
- For a backend-based sending (mail/WhatsApp/SMS) we can add a server; tell me which hosting/back-end you prefer.
