#!/bin/bash

# Script to create GitHub issues for Line Cook bugs
# Usage: GH_TOKEN=your_token_here ./create_issues.sh

if [ -z "$GH_TOKEN" ]; then
    echo "ERROR: GH_TOKEN environment variable not set"
    echo "Usage: GH_TOKEN=your_github_token ./create_issues.sh"
    echo ""
    echo "To get a token:"
    echo "1. Visit: https://github.com/settings/personal-access-tokens/new"
    echo "2. Select 'Copilot Requests' permission"
    echo "3. Generate token and copy it"
    echo "4. Run: GH_TOKEN=ghp_xxxxxxxxxxxx ./create_issues.sh"
    exit 1
fi

REPO="Axolote13/line_cook"

echo "Creating GitHub issues for Line Cook bugs..."
echo ""

# Issue 1: BUG 1.2
echo "Creating Issue 1: BUG 1.2 - Greedy matching exploit..."
gh issue create --repo "$REPO" \
  --title "BUG 1.2: Greedy matching exploit in completion engine" \
  --body "## CRITICAL: Game-breaking exploit

A single plated item can be claimed by multiple tickets simultaneously due to greedy matching without locking.

### Reproduction Steps
1. Start a game
2. Place 2+ burger tickets on the plating area
3. Drag ONE patty to grill, cook, then plate it
4. Send-out multiple burgers before their completion requirements are met
5. Single patty registers as 'complete' for 4 different burger tickets

### Root Cause
\`getCompletions()\` in game.html (lines ~739-777) uses a greedy algorithm:
- Checks if entire dish is complete
- Uses globalUsed Set to prevent double-claiming
- **FLAW**: Set is only consulted AFTER entire dish validation

### Impact
- Players can exploit by ordering multiple of same dish, plating one item, claiming all tickets complete
- Breaks game economy (unlimited tips)
- Makes scoring meaningless

### Fix Recommendation
Redesign completion engine to lock items per partial match.
Estimated effort: 60-90 minutes

See LOGIC_AUDIT_REPORT.md for detailed analysis." \
  --label "bug,critical" || echo "Failed to create Issue 1"

echo "✓ Issue 1 created"
echo ""

# Issue 2: BUG 1.1
echo "Creating Issue 2: BUG 1.1 - Race condition in plating..."
gh issue create --repo "$REPO" \
  --title "BUG 1.1: Race condition in plating system" \
  --body "## CRITICAL: Data loss on rapid plating

Two mouseup events in rapid succession (< 50ms) can both write to the same empty plating slot, causing item overwrite and data loss.

### Reproduction Steps
1. Start game with plating area visible
2. Rapidly drag 2 different ingredients to the SAME plating slot (within ~50ms)
3. Both items briefly appear in slot
4. Second item overwrites first; first item's state is lost
5. Completion engine fails to track the overwritten item

### Root Cause
\`placeOnPlating()\` in game.html (lines ~983-998):
- No atomic check-and-set operation
- Doesn't verify slot is empty before writing
- Two rapid drop handlers execute before first one's state propagates

### Impact
- Players lose food items unexpectedly
- Completion state becomes out-of-sync with rendered items
- Frustrating UX, breaking game logic

### Fix Recommendation
Add atomic check-and-set pattern with temporary hold/claim state.
Estimated effort: 10-15 minutes

See LOGIC_AUDIT_REPORT.md for detailed analysis." \
  --label "bug,critical" || echo "Failed to create Issue 2"

echo "✓ Issue 2 created"
echo ""

# Issue 3: BUG 1.3
echo "Creating Issue 3: BUG 1.3 - Combo multiplier timing bug..."
gh issue create --repo "$REPO" \
  --title "BUG 1.3: Combo multiplier doesn't apply to first send-out" \
  --body "## CRITICAL: Combo feature broken on initial rapid send

When sending 2+ tickets rapidly (within 25s), only the SECOND and subsequent sends receive the 1.5× combo bonus. First send-out gets NO bonus.

### Reproduction Steps
1. Start game
2. Complete 2 tickets quickly (within 25 seconds of each other)
3. Send out FIRST ticket
   - Observe: No combo indication, no 1.5× multiplier applied
4. Send out SECOND ticket within 25s window
   - Observe: 'Combo: 1' appears, 1.5× multiplier IS applied
5. Expected: BOTH sends should receive combo bonus

### Root Cause
\`handleSendOut()\` in game.html (lines ~804-850):
- Checks \`comboActive\` AFTER incrementing \`comboCount\`
- First send-out: comboCount = 0, comboActive = false, so NO multiplier
- Second send-out: comboCount = 1, comboActive = true, so YES multiplier

### Fix Recommendation
Reorder logic to increment comboCount FIRST, then check if comboCount >= 2.
Estimated effort: 5 minutes

See LOGIC_AUDIT_REPORT.md for detailed analysis." \
  --label "bug,critical" || echo "Failed to create Issue 3"

echo "✓ Issue 3 created"
echo ""
echo "✅ All GitHub issues created successfully!"
