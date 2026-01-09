# Deployment Guide

## Overview

This site is deployed using:
- **Hosting**: Vercel (free tier, auto-deploys from GitHub)
- **DNS**: Cloudflare (manually configured by admin)
- **Content**: GitHub repository

## Initial Deployment Setup

### Prerequisites

1. **Create a Choir-Owned Email** (if not exists)
   - Example: `webmaster@chicommunitychoir.com` or use Caroline's email
   - This will be the owner of all accounts

2. **Create GitHub Account** (for the choir)
   - Go to https://github.com/signup
   - Use the choir's email address
   - Username suggestion: `chichester-community-choir`
   - Keep credentials in a secure location (password manager)

3. **Push Code to GitHub**
   ```bash
   # If not already initialized
   git remote add origin https://github.com/[choir-username]/chi-comm-choir.git
   git branch -M main
   git push -u origin main
   ```

### Vercel Setup

1. **Create Vercel Account**
   - Go to https://vercel.com/signup
   - Sign up using the choir's GitHub account (easiest)
   - This automatically links Vercel to GitHub

2. **Import Project**
   - Click "Add New Project"
   - Select "Import Git Repository"
   - Choose the `chi-comm-choir` repository
   - Framework: Next.js (auto-detected)
   - Click "Deploy"

3. **Configure Project**
   - Build Command: `bun run build` (or `npm run build`)
   - Output Directory: Leave default (Next.js auto-detects)
   - Environment Variables: None needed (static site)

4. **Get Deployment URL**
   - After deployment, you'll get: `chi-comm-choir.vercel.app`
   - Keep this for testing

### DNS Configuration (Cloudflare)

**Note**: This is done manually, not through Vercel auto-config.

1. **Log into Cloudflare**
   - Go to https://dash.cloudflare.com
   - Select your domain: `chicommunitychoir.com`

2. **Add DNS Records**

   For apex domain (chicommunitychoir.com):
   ```
   Type: CNAME
   Name: @
   Target: cname.vercel-dns.com
   Proxy: ON (orange cloud)
   ```

   For www subdomain:
   ```
   Type: CNAME
   Name: www
   Target: cname.vercel-dns.com
   Proxy: ON (orange cloud)
   ```

3. **Add Domain to Vercel**
   - Go to Vercel project → Settings → Domains
   - Add: `chicommunitychoir.com`
   - Add: `www.chicommunitychoir.com`
   - Vercel will verify DNS (may take a few minutes)

4. **SSL Certificate**
   - Cloudflare SSL: Set to "Full" or "Full (strict)"
   - Vercel automatically provides SSL
   - Wait 5-10 minutes for SSL to activate

### Verification

Test these URLs:
- ✅ https://chicommunitychoir.com
- ✅ https://www.chicommunitychoir.com
- ✅ https://chi-comm-choir.vercel.app

All should show the same website with valid SSL.

## Automatic Deployments

Once set up, deployments are automatic:

1. Edit file on GitHub (or push changes)
2. Vercel detects the change
3. Automatically builds and deploys (2-3 minutes)
4. Live site updates

**View Deployment Status**:
- Vercel Dashboard → chi-comm-choir project → Deployments
- See build logs, preview URLs, and deployment history

## Rollback (If Something Breaks)

1. Go to Vercel Dashboard → Deployments
2. Find the last working deployment (green checkmark)
3. Click "..." menu → "Promote to Production"
4. Site reverts to that version instantly

## Cost Structure

- **GitHub**: Free (public repository)
- **Vercel**: Free tier (sufficient for this site)
  - Bandwidth: 100 GB/month
  - Builds: Unlimited
  - Domains: Unlimited
- **Cloudflare**: Free tier (DNS only)

**Cost if free limits exceeded**: ~$20/month for Vercel Pro (unlikely)

## Monitoring & Alerts

**Set up email alerts** (recommended):
1. Vercel → Project Settings → Notifications
2. Enable "Deployment Notifications"
3. Add choir's email

**Monitor uptime** (optional, free):
- Use UptimeRobot: https://uptimerobot.com
- Check site every 5 minutes
- Email if down

## Handoff Checklist

Before handing off to choir:

- [ ] Push all code to GitHub
- [ ] Deploy to Vercel successfully
- [ ] DNS configured and working
- [ ] Test all pages load correctly
- [ ] Test adding a new blog post
- [ ] Document all account credentials
- [ ] Share HANDOFF.md with choir members
- [ ] Schedule a walkthrough call (optional)
- [ ] Provide emergency contact info

## Account Credentials to Hand Off

Create a secure document (1Password, LastPass, or encrypted file) with:

```
GitHub Account
- Email: [email]
- Password: [password]
- 2FA Recovery Codes: [codes]

Vercel Account
- Linked to GitHub account above
- Access via GitHub login

Cloudflare Account
- Email: [email]
- Password: [password]
- 2FA Recovery Codes: [codes]

DigitalOcean Spaces (Image CDN)
- Access Key: [key]
- Secret Key: [secret]
- Endpoint: lon1.digitaloceanspaces.com
- Bucket: chicommunitychoir
```

## Support Transition

**Handoff Plan**:
1. Week 1: Developer available for urgent issues
2. Week 2-4: Developer available for questions
3. After Month 1: Emergency contact only

**Common Issues Reference**: See HANDOFF.md

---

*For questions during deployment, contact: [Your contact info]*
