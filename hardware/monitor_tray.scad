// ═══════════════════════════════════════════════════════════════════
//  KAAMOS — monitor tray v1
//  15.6" portable USB-C monitor, desk-optimized
//  ~355mm wide × ~225mm tall × ~10mm thick
//
//  Colour map (Kaamos palette → PLA/PETG):
//    tyhjyys   #0c0c0c  →  Matte Black PLA     (body, legs, base)
//    meripihka #f0a030  →  Amber / Pumpkin PLA (end caps — small, print 2)
//    norsunluu #dfd0b0  →  Natural / Ivory PETG (grip strips — print 2)
//
//  RENDER switch:
//    0  →  main body   (Matte Black PLA)  — orient flat-base-down, no support needed
//    1  →  end cap     (Amber PLA)        — print 2, mirror one in slicer
//    2  →  grip strip  (Natural PETG)     — print 2
// ═══════════════════════════════════════════════════════════════════

RENDER = 0;

// ── monitor ──────────────────────────────────────────────────────────
MON_W   = 355;   // monitor width (mm)
MON_T   = 10;    // monitor thickness (mm) — measure your unit; 10 is typical

// ── channel (front lip) ──────────────────────────────────────────────
FIT     = 0.8;   // total clearance inside channel (loose enough to insert/remove)
WALL    = 3.5;   // wall thickness throughout
LIP_H   = 22;    // how high the front channel rises (captures bottom of monitor)
CH_W    = MON_T + FIT;                // channel inner width
LIP_D   = CH_W  + WALL * 2;          // front lip outer depth

// ── base ─────────────────────────────────────────────────────────────
LEN     = MON_W + 10;   // tray total length (5mm each end before caps)
BASE_D  = 82;            // base depth front to back
BASE_T  = 3;             // base plate thickness

// ── rear support wall ────────────────────────────────────────────────
TILT    = 12;            // degrees monitor leans back from vertical
RW_T    = 4;             // rear wall thickness
RW_H    = 58;            // rear wall height (supports monitor ~80mm up from base)

// ── end cap (amber accent) ────────────────────────────────────────────
CAP_L   = 13;            // cap depth (how far it slides over channel end)
CAP_T   = 2.5;           // cap wall thickness

// ── grip strip (natural PETG) ─────────────────────────────────────────
GRIP_L  = LEN - WALL * 2 - 6;
GRIP_W  = 5;
GRIP_T  = 1.6;

$fn = 48;

// ════════════════════════════════════════════════════════════════════
//  BODY GEOMETRY
// ════════════════════════════════════════════════════════════════════

module base_plate() {
    cube([LEN, BASE_D, BASE_T]);
}

module front_channel() {
    // U-profile rising from front edge of base
    translate([0, 0, BASE_T])
    difference() {
        cube([LEN, LIP_D, LIP_H]);
        // hollow — open top
        translate([WALL, WALL, WALL])
            cube([LEN - WALL*2, CH_W, LIP_H + 1]);
        // cable exit slot, centred at bottom of channel
        translate([LEN/2 - 12, WALL, -BASE_T])
            cube([24, CH_W, BASE_T + WALL + 1]);
    }
}

module rear_wall() {
    // angled wall the monitor face rests against
    // pivots from the rear edge of the base, leans backward TILT degrees
    translate([WALL, BASE_D, BASE_T])
    rotate([-TILT, 0, 0])
    cube([LEN - WALL*2, RW_T, RW_H]);
}

module gusset(x_pos) {
    // triangular brace connecting rear wall to base plate
    // side profile: right triangle — horizontal leg = BASE_D - LIP_D, vertical = RW_T
    gus_run = BASE_D - LIP_D - 4;
    gus_w   = 8;
    translate([x_pos, LIP_D + 2, BASE_T])
    linear_extrude(RW_T)
    polygon([
        [0, 0],
        [gus_w, 0],
        [gus_w, gus_run],
        [0, gus_run]
    ]);
}

module main_body() {
    union() {
        base_plate();
        front_channel();
        rear_wall();
        gusset(WALL + 2);
        gusset(LEN - WALL - 10);
    }
}

// ════════════════════════════════════════════════════════════════════
//  END CAP  (amber accent — print 2, mirror one in slicer)
// ════════════════════════════════════════════════════════════════════

module end_cap() {
    // press-fits over either end of the front channel
    outer_h = LIP_H + BASE_T;
    difference() {
        cube([CAP_L, LIP_D, outer_h]);
        translate([CAP_T, CAP_T, CAP_T])
            cube([CAP_L, LIP_D - CAP_T*2, outer_h]);
    }
}

// ════════════════════════════════════════════════════════════════════
//  GRIP STRIP  (natural PETG — print 2: one front wall, one rear wall)
// ════════════════════════════════════════════════════════════════════

module grip_strip() {
    // sits in the channel against the wall the monitor face touches
    // adds friction and protects monitor edge from scratching
    translate([WALL + 3, 0, 0])
    cube([GRIP_L, GRIP_W, GRIP_T]);
}

// ════════════════════════════════════════════════════════════════════
//  RENDER
// ════════════════════════════════════════════════════════════════════

if (RENDER == 0) {
    color("#111008") main_body();
    // export as: monitor_tray_body.stl
    // orient: flat base down — no supports required
}

if (RENDER == 1) {
    color("#f0a030") end_cap();
    // export as: monitor_tray_cap.stl — print 2, mirror one in slicer
    // orient: open face down
}

if (RENDER == 2) {
    color("#dfd0b0") grip_strip();
    // export as: monitor_tray_grip.stl — print 2 (PETG)
    // press into channel front and back walls after printing body
}
