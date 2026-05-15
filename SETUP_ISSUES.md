# Creating GitHub Issues for Critical Bugs

The Line Cook game has **3 critical bugs** that need to be tracked as GitHub issues. Choose one of the methods below:

## Method 1: Automated Script (Recommended)

### Step 1: Get Your GitHub Personal Access Token

1. Visit: https://github.com/settings/personal-access-tokens/new
2. Under **Permissions**, click **Add permissions**
3. Select **Copilot Requests** permission
4. Generate token and **copy it** (save it somewhere safe)

### Step 2: Run the Script

```bash
cd /Users/hazael/TMP/GITHUB_CLI/CH0
GH_TOKEN=ghp_your_token_here ./create_issues.sh
```

Replace `ghp_your_token_here` with your actual token.

**Expected Output:**
```
Creating GitHub issues for Line Cook bugs...

Creating Issue 1: BUG 1.2 - Greedy matching exploit...
✓ Issue 1 created

Creating Issue 2: BUG 1.1 - Race condition in plating...
✓ Issue 2 created

Creating Issue 3: BUG 1.3 - Combo multiplier timing bug...
✓ Issue 3 created

✅ All GitHub issues created successfully!
```

---

## Method 2: Manual Creation via GitHub UI

If you prefer to create issues manually:

1. Open: https://github.com/Axolote13/line_cook/issues/new
2. For each of the 3 issues below, create a new issue:
   - Copy the **Title**
   - Paste it in the issue title field
   - Copy the **Body** section from GITHUB_ISSUES.md
   - Add labels: `bug`, `critical`
   - Click "Submit new issue"

See `GITHUB_ISSUES.md` in this repo for all issue details and bodies.

---

## Method 3: Using GitHub CLI (if already authenticated)

If you already have `gh` authenticated:

```bash
cd /Users/hazael/TMP/GITHUB_CLI/CH0
bash create_issues.sh
```

(The script auto-detects your authentication)

---

## Issues to Be Created

### Issue 1: BUG 1.2 - Greedy Matching Exploit
**Status**: Not yet created  
**Severity**: CRITICAL 🔴  
**Location**: game.html, lines ~739-777 (getCompletions function)  
**Impact**: Game-breaking exploit allowing unlimited tips

### Issue 2: BUG 1.1 - Race Condition in Plating
**Status**: Not yet created  
**Severity**: CRITICAL 🔴  
**Location**: game.html, lines ~983-998 (placeOnPlating function)  
**Impact**: Data loss on rapid plating, corrupted completion state

### Issue 3: BUG 1.3 - Combo Multiplier Timing
**Status**: Not yet created  
**Severity**: CRITICAL 🔴  
**Location**: game.html, lines ~804-850 (handleSendOut function)  
**Impact**: Combo bonus not applied to first send-out

---

## Verification

After creating the issues, you should see all 3 at:
https://github.com/Axolote13/line_cook/issues

Each issue will have:
- Full reproduction steps
- Root cause analysis
- Fix recommendations
- Links to LOGIC_AUDIT_REPORT.md for detailed analysis

---

## Next Steps After Creating Issues

Once issues are created:

1. **Fix the bugs** (recommended order):
   - Start with BUG 1.1 (10-15 min, simplest)
   - Then BUG 1.3 (5 min)
   - Finally BUG 1.2 (60-90 min, most complex)

2. **Create a branch** for bug fixes:
   ```bash
   git checkout -b fix/critical-bugs
   ```

3. **Reference issues in commits**:
   ```bash
   git commit -m "Fix BUG 1.1: Add atomic check-and-set to plating

   Fixes #1 (replace with actual issue number)"
   ```

4. **Test thoroughly** before pushing

---

## Need Help?

- **Audit Report**: See `LOGIC_AUDIT_REPORT.md` for technical details on all 10 bugs
- **Audit Summary**: See `AUDIT_SUMMARY.txt` for quick reference
- **Game Code**: See `game.html` (1346 lines, fully commented)

---

Generated: 2026-05-15
Repository: https://github.com/Axolote13/line_cook
