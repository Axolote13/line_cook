# GitHub Issues for Line Cook

Copy-paste these into GitHub Issues at: https://github.com/Axolote13/line_cook/issues/new

---

## Issue 1: BUG 1.2: Greedy matching exploit in completion engine

**Title**: BUG 1.2: Greedy matching exploit in completion engine  
**Labels**: `bug`, `critical`

### Description

## CRITICAL: Game-breaking exploit

A single plated item can be claimed by multiple tickets simultaneously due to greedy matching without locking.

### Reproduction Steps
1. Start a game
2. Place 2+ burger tickets on the plating area
3. Drag ONE patty to grill, cook, then plate it
4. Send-out multiple burgers before their completion requirements are met
5. Single patty registers as 'complete' for 4 different burger tickets

### Root Cause
`getCompletions()` in game.html (lines ~739-777) uses a greedy algorithm:
- Checks if entire dish is complete
- Uses globalUsed Set to prevent double-claiming
- **FLAW**: Set is only consulted AFTER entire dish validation, allowing same item to satisfy multiple incomplete tickets

### Impact
- Players can exploit by ordering multiple of same dish, plating one item, claiming all tickets complete
- Breaks game economy (unlimited tips)
- Makes scoring meaningless

### Fix Recommendation
Redesign completion engine to:
1. Lock items per partial match (not just full dish)
2. Use a per-ticket reservation system before validation
3. Validate atomic completion before adding to globalUsed
4. Estimated effort: 60-90 minutes

See LOGIC_AUDIT_REPORT.md for detailed analysis.

---

## Issue 2: BUG 1.1: Race condition in plating system

**Title**: BUG 1.1: Race condition in plating system  
**Labels**: `bug`, `critical`

### Description

## CRITICAL: Data loss on rapid plating

Two mouseup events in rapid succession (< 50ms) can both write to the same empty plating slot, causing item overwrite and data loss.

### Reproduction Steps
1. Start game with plating area visible
2. Rapidly drag 2 different ingredients to the SAME plating slot (within ~50ms)
3. Both items briefly appear in slot
4. Second item overwrites first; first item's state is lost
5. Completion engine fails to track the overwritten item

### Root Cause
`placeOnPlating()` in game.html (lines ~983-998):
- No atomic check-and-set operation
- Doesn't verify slot is empty before writing
- Two rapid drop handlers execute before first one's state propagates

### Impact
- Players lose food items unexpectedly
- Completion state becomes out-of-sync with rendered items
- Tickets marked 'complete' but plating area is empty
- Frustrating UX, breaking game logic

### Fix Recommendation
1. Add temporary hold/claim state before confirming placement
2. Use atomic check-and-set pattern (or Promise-based reservation)
3. Validate slot still empty before writing
4. Estimated effort: 10-15 minutes

See LOGIC_AUDIT_REPORT.md for detailed analysis.

---

## Issue 3: BUG 1.3: Combo multiplier doesn't apply to first send-out

**Title**: BUG 1.3: Combo multiplier doesn't apply to first send-out  
**Labels**: `bug`, `critical`

### Description

## CRITICAL: Combo feature broken on initial rapid send

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
`handleSendOut()` in game.html (lines ~804-850):
- Checks `comboActive` AFTER incrementing `comboCount`
- Logic reads: 'check if combo is active, then increment counter'
- First send-out: comboCount = 0, comboActive = false, so NO multiplier
- Second send-out: comboCount = 1, comboActive = true (from first send), so YES multiplier

### Current Code Flow
```javascript
if (comboActive) {
  // ... apply multiplier (only on SECOND+ sends)
}
comboCount++;
```

### Fix Recommendation
Reorder logic to:
1. Increment comboCount FIRST
2. Check if comboCount >= 2 AND within time window
3. Apply multiplier if condition is true
4. Start combo timer on first send
5. Estimated effort: 5 minutes

See LOGIC_AUDIT_REPORT.md for detailed analysis.

---

## Instructions

1. Visit: https://github.com/Axolote13/line_cook/issues/new
2. For each issue above:
   - Copy the **Title** and paste it in the issue title field
   - Copy the **Description** section (starting after "### Description") and paste it in the body
   - Add the **Labels** (click "Labels" button and type `bug`, `critical`)
   - Click "Submit new issue"
3. All 3 issues will be created with full context from the audit report

---

**Alternatively, use GitHub CLI** (if authenticated):

```bash
gh issue create --repo Axolote13/line_cook \
  --title "BUG 1.2: Greedy matching exploit in completion engine" \
  --body "..." \
  --label "bug,critical"
```

See each issue description above for the full body text.
