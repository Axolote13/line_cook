# Line Cook 🍳

A fast-paced restaurant kitchen management game built with vanilla JavaScript, HTML5, and Web Audio API. Run a busy kitchen during dinner rush, manage multiple cooking stations, and maximize your tips by delivering dishes quickly and accurately.

## Play Now

Simply open `game.html` in any modern web browser — **no installation, no internet required**.

```bash
# Option 1: Open in your default browser
open game.html

# Option 2: Double-click the file in your file manager
```

## Game Overview

You're the head chef running a kitchen during a dinner rush. Tickets come in continuously with customer orders. You must:

- **Manage 5 cooking stations**: Grill, Sauté, Fryer, Salad, and Plating
- **Drag ingredients** from the ingredient bar to cooking stations
- **Wait for food to cook** (watch the timers!)
- **Avoid burning**: Food burns if left too long on heat
- **Plate dishes** in the correct order
- **Send out completed plates** to earn tips
- **Beat the clock** as the rush intensifies

### Game Mechanics

**Recipes** (6 dishes):
- Burger (beef patty, toasted bun)
- Salmon (grilled filet, sauce)
- Pasta (cooked noodles, sauce)
- Salad (greens, dressing)
- Steak (grilled meat, sauce)
- Soup (broth, garnish)

**Ingredients**: 8 types available in unlimited supply

**Cooking Stations**: Each handles specific ingredient types and has timers

**Difficulty**: 3 phases ramping up from casual to intense
- Phase 1 (0–60s): Slow ticket arrival, forgiving customers
- Phase 2 (60–120s): Moderate pace, impatient customers
- Phase 3 (120–180s): Rush mode, angry customers, tight deadlines

**Scoring System**:
- Tips increase with each delivered plate (~$3–5 base, up to +50% bonus)
- Combo multiplier: 1.5× bonus for 2+ tickets sent within 25 seconds
- Accuracy bonus: Perfect execution adds 10% per ticket
- Penalty: Burned food = –$2, expired customers = –$1

**Duration**: Each round is 3 minutes (180 seconds)

## Features

- ✅ **100% Vanilla JavaScript** — No frameworks, no libraries, no build tools
- ✅ **Offline-first** — Works without internet connection
- ✅ **Touch & Mouse Support** — Play on desktop or mobile (drag-and-drop on both)
- ✅ **Sound Effects** — Web Audio API for cooking, plating, and scoring sounds
- ✅ **Responsive Design** — Adapts to any screen size
- ✅ **Custom SVG Graphics** — All assets are vector-based for crisp rendering
- ✅ **Real-time Feedback** — Timers, customer patience bars, combo alerts

## Controls

### Desktop
- **Drag & Drop**: Drag ingredients from the bottom bar to cooking stations
- **Right-Click on Plated Items**: Remove a mistakenly plated dish
- **Click Send Button**: Send out a completed plate to earn tips

### Mobile / Touch
- **Tap & Drag**: Tap and hold an ingredient, drag to a station
- **Long-Press on Plated Items** (1.5s): Remove a mistakenly plated dish
- **Tap Send Button**: Send out a completed plate

## Browser Compatibility

- ✅ Chrome/Edge 60+
- ✅ Firefox 55+
- ✅ Safari 12+
- ✅ Mobile browsers (iOS Safari, Chrome Android)

## File Structure

```
line_cook/
├── game.html          # Complete game (self-contained, 61 KB)
└── README.md          # This file
```

## Technical Highlights

### Architecture
- **DOM-based rendering** for responsive drag-drop interactions
- **Single requestAnimationFrame loop** for all timers and animations
- **State machine** for game phases and ticket lifecycle
- **Delta-time accumulation** for frame-rate independent timing

### Key Systems
1. **Ticket System**: Customers place orders with patience meters
2. **Cooking Engine**: Tracks cook time, burn time, and completion state
3. **Plating Logic**: Manages 8 plating slots as a global resource
4. **Combo System**: Detects rapid sends for bonus multiplier
5. **Audio Synthesis**: Procedural sound generation using Web Audio API

### Known Limitations
- Very rapid drag-drops (< 50ms apart) on slow devices may cause timing glitches
- Mobile browsers on very old devices (pre-2015) may experience frame drops during peak rushes
- No persistent leaderboard (scores reset on page reload)

## Future Ideas

- Leaderboard with localStorage
- Different difficulty modes (sandbox, time trials)
- More recipes and ingredient types
- Multiplayer kitchen (shared plating area)
- Custom ingredient editor
- Sound on/off toggle
- Accessibility improvements (keyboard-only mode)

## Development Notes

This game was built as a single-file HTML5 application with:
- **Vanilla JavaScript** (no dependencies)
- **HTML5 Canvas** for graphics rendering (SVG icons for UI)
- **Web Audio API** for sound effects
- **CSS Grid/Flexbox** for responsive layout
- **Touch Events API** for mobile support

All game logic is self-contained in `game.html`. No build process, no external files needed.

## License

This project is open source. Feel free to fork, modify, and build on it!

---

**Enjoy the rush! 🚀**
