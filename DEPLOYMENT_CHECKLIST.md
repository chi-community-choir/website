# Deployment Checklist for Handoff

Use this checklist to ensure a smooth handoff to the choir members.

## Phase 1: Account Setup (Before Deployment)

### GitHub Account for Choir
- [x] Decide on account email (choir-owned, not personal)
  - Option A: Create `webmaster@chicommunitychoir.com`
  - Option B: Use Caroline's email: `caroline@chicommunitychoir.com`
- [x] Create GitHub account at https://github.com/signup
  - Username suggestion: `chichester-community-choir` or `chi-comm-choir`
- [ ] Enable 2FA (two-factor authentication)
- [ ] Save recovery codes in secure location
- [ ] Document credentials in password manager

### Vercel Account for Choir
- [x] Sign up at https://vercel.com using GitHub account (easier)
  - OR create separate Vercel account with choir email
- [ ] Enable 2FA
- [ ] Save recovery codes
- [ ] Document credentials

## Phase 2: Code Preparation

### Repository Setup
- [x] Create repository on choir's GitHub account
- [x] Repository name: `chi-comm-choir` or `website`
- [x] Set to Public (or Private if preferred)
- [x] Add description: "Chichester Community Choir website"

### Push Code
```bash
# Add remote (update with actual GitHub username)
git remote add origin https://github.com/[choir-username]/chi-comm-choir.git

# Push to main branch
git push -u origin main
```

- [ ] Verify code is on GitHub
- [ ] Check all files are present (including content/posts/)

## Phase 3: Vercel Deployment

### Import Project
- [ ] Log into Vercel (choir account)
- [ ] Click "Add New Project"
- [ ] Import from GitHub
- [ ] Select `chi-comm-choir` repository
- [ ] Framework preset: Next.js (should auto-detect)
- [ ] Build settings:
  - Build Command: `npm run build` or `bun run build`
  - Output Directory: (leave default)
  - Install Command: `npm install` or `bun install`

### Deploy
- [ ] Click "Deploy"
- [ ] Wait for build (2-3 minutes)
- [ ] Check for green "✓" success
- [ ] Get deployment URL: `chi-comm-choir.vercel.app`
- [ ] Test deployment URL - verify site loads

### Initial Testing
- [ ] Homepage loads correctly
- [ ] Navigation works (click all nav links)
- [ ] Events page shows sample post
- [ ] Individual event post loads
- [ ] All static pages render (About, Find Us, etc.)
- [ ] Images load from CDN
- [ ] Mobile responsive (test on phone)

## Phase 4: DNS Configuration (Cloudflare)

### Cloudflare DNS Settings
- [ ] Log into Cloudflare account
- [ ] Select domain: `chicommunitychoir.com`
- [ ] Go to DNS settings

### Add CNAME Records
- [ ] Add record for apex domain:
  ```
  Type: CNAME
  Name: @ (or chicommunitychoir.com)
  Target: cname.vercel-dns.com
  Proxy: ON (orange cloud icon)
  TTL: Auto
  ```
- [ ] Add record for www:
  ```
  Type: CNAME
  Name: www
  Target: cname.vercel-dns.com
  Proxy: ON (orange cloud icon)
  TTL: Auto
  ```
- [ ] Delete any conflicting A or CNAME records for @ and www

### Configure Vercel Domain
- [ ] In Vercel: Project Settings → Domains
- [ ] Click "Add Domain"
- [ ] Enter: `chicommunitychoir.com`
- [ ] Click "Add"
- [ ] Add second domain: `www.chicommunitychoir.com`
- [ ] Wait for verification (may take 5-10 minutes)
- [ ] Check for green "✓" next to both domains

### SSL Configuration
- [ ] Cloudflare: SSL/TLS → Overview → Set to "Full" or "Full (strict)"
- [ ] Wait 10-15 minutes for SSL certificate
- [ ] Test: https://chicommunitychoir.com (should show padlock)
- [ ] Test: https://www.chicommunitychoir.com (should redirect or show site)

## Phase 5: Verification

### URL Testing
Test all these URLs in incognito/private window:
- [ ] https://chicommunitychoir.com ✅
- [ ] http://chicommunitychoir.com → redirects to HTTPS ✅
- [ ] https://www.chicommunitychoir.com ✅
- [ ] http://www.chicommunitychoir.com → redirects to HTTPS ✅

### Functionality Testing
- [ ] Click all navigation links
- [ ] Test adding a new blog post on GitHub
- [ ] Wait 3 minutes for auto-deploy
- [ ] Verify new post appears on Events page
- [ ] Test editing an existing post
- [ ] Verify edit appears after auto-deploy
- [ ] Check footer links (email, etc.)
- [ ] Test on mobile device

### Performance Testing
- [ ] Run PageSpeed Insights: https://pagespeed.web.dev/
- [ ] Score should be 90+ on mobile and desktop
- [ ] Check all pages load in < 2 seconds

## Phase 6: Monitoring Setup

### Vercel Notifications
- [ ] Vercel: Project Settings → Notifications
- [ ] Enable "Deployment Succeeded"
- [ ] Enable "Deployment Failed"
- [ ] Add email: Caroline's email
- [ ] Test: trigger deployment, check email received

### Uptime Monitoring (Optional)
- [ ] Sign up for UptimeRobot: https://uptimerobot.com
- [ ] Add monitor: https://chicommunitychoir.com
- [ ] Check interval: 5 minutes
- [ ] Add email alert: Caroline's email

## Phase 7: Documentation & Handoff

### Prepare Documentation
- [ ] Review HANDOFF.md - ensure accurate
- [ ] Update DEPLOYMENT.md with actual account details
- [ ] Update README.md with correct URLs
- [ ] Add developer contact info to all docs
- [ ] Create PDF versions for offline access (optional)

### Credential Handoff
- [ ] Create secure document with:
  - GitHub credentials + 2FA codes
  - Vercel access info (via GitHub)
  - Cloudflare credentials + 2FA codes
  - DigitalOcean Spaces keys
- [ ] Use password manager export OR encrypted PDF
- [ ] **Never send passwords via plain email**

### Training Session (Recommended)
- [ ] Schedule 30-minute video call with Caroline
- [ ] Walk through:
  - Adding a blog post
  - Editing existing content
  - Checking deployment status
  - What to do if something breaks
- [ ] Share screen and watch them add a test post
- [ ] Answer questions

### Final Checks
- [ ] Old Gleam site taken down or archived
- [ ] Database backup saved (if needed)
- [ ] All choir members have access to HANDOFF.md
- [ ] Emergency contact info provided
- [ ] Calendar reminder: check-in in 2 weeks

## Phase 8: Post-Handoff Support

### Week 1
- [ ] Monitor deployment emails
- [ ] Check site daily for issues
- [ ] Be available for quick questions

### Week 2-4
- [ ] Respond to questions within 24 hours
- [ ] Help with any content additions
- [ ] Address any bugs discovered

### Month 2+
- [ ] Move to emergency support only
- [ ] Set expectations: respond within 48-72 hours
- [ ] Only for critical issues (site down, major bugs)

## Emergency Rollback Plan

If something goes wrong:

1. **Via Vercel Dashboard**:
   - Deployments tab
   - Find last working deployment
   - Click "..." → "Promote to Production"

2. **Via DNS** (if domain issue):
   - Temporarily point DNS back to old server
   - Or set Cloudflare to "Development Mode"

3. **Contact Developer**:
   - [Your contact info]

---

## Quick Command Reference

```bash
# Test build locally
bun run build

# Run dev server
bun run dev

# Push changes
git add .
git commit -m "Description of changes"
git push

# Check deployment status
# → Go to Vercel dashboard
```

---

**Status**: ☐ Not Started | ⏳ In Progress | ✅ Complete

**Deployment Date**: __________
**Handed Off To**: __________
**Next Check-in**: __________
