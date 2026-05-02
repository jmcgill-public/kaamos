# Monitor — shopping plan and tray spec

## Design constraints

| parameter     | value                | source                        |
|---------------|----------------------|-------------------------------|
| width target  | 355mm                | Keychron K8 width             |
| form factor   | 15.6" portable       | derived from width + tilt calc |
| resolution    | 1920×1080            | SER3 native, ~137 PPI at size  |
| tilt          | 12° from vertical    | monitor_tray.scad TILT param  |
| connection    | Mini HDMI preferred  | avoid USB-C troubleshooting   |
| price range   | $65–$135             |                               |

USB-C noted as problematic: cable spec matters, audio interference risk, negotiation failures with Lepow/InnoView units. Prefer HDMI + separate power where available.

---

## Candidates

### ViewSonic VA1655 — **top pick**
- **Price:** ~$110
- **Panel:** 15.6" IPS, 1920×1080, 60Hz, 250 nits
- **Dimensions:** 358 × 226 × 18mm (width almost exactly matches K8 355mm)
- **Weight:** 0.7kg
- **Ports:** 60W USB-C, Mini HDMI
- **Notes:** Known quantity, good driver support on Linux/Windows, built-in stand (redundant with tray but harmless), comes with protective sleeve
- [ViewSonic product page](https://www.viewsonic.com/us/va1655-15-6-portable-1080p-ips-monitor-with-usb-c-and-mini-hdmi.html)
- [Amazon](https://www.amazon.com/ViewSonic-VA1655-Portable-Ergonomics-Protective/dp/B09237LL5Q)
- [B&H](https://www.bhphotovideo.com/c/product/1674989-REG/viewsonic_va1655_16_full_hd_ips.html)

### Kado 15.6"
- **Price:** ~$85–$95
- **Panel:** 15.6" IPS, 1920×1080, 45W reverse charging
- **Ports:** USB-C, Mini HDMI
- **Notes:** Newer brand, 180° kickstand, slim
- [Amazon](https://www.amazon.com/Kado-Ultra-Slim-1920x1080-Kickstand-Connectivity/dp/B0DLW7JXK4)

### KYY 15.6"
- **Price:** ~$70–$90
- **Panel:** 15.6" IPS, 1920×1080, HDR
- **Ports:** USB-C (×2), Mini HDMI
- **Notes:** Budget end, includes screen protector and cover. Mixed cable reliability reports — verify Mini HDMI works before relying on USB-C
- [Amazon](https://www.amazon.com/Portable-Monitor-15-6inch-Computer-Protector/dp/B088D8JG3L)

---

## SCAD parameters to update on arrival

Open `monitor_tray.scad` and measure the physical unit before printing:

```
MON_W   = 355;   // actual panel + bezel width (mm) — measure with calipers
MON_T   = 10;    // actual thickness at thickest point (mm) — measure edge
FIT     = 0.8;   // increase to 1.2 if insertion is tight after test print
LIP_H   = 22;    // increase if monitor has bottom rubber feet that add height
```

Also measure:
- Does the monitor have a bottom lip / rubber feet? (affects channel floor clearance)
- Exact thickness at the corners vs center (some units taper)
- Cable port positions at the bottom edge (verify cable slot width of 24mm clears them)

---

## Gridfinity note

`BASE_T = 3` and `BASE_D = 82` give enough floor geometry to add a Gridfinity base.
Add gridfinity params when tray spec is confirmed.
Standard Gridfinity unit: 42mm × 42mm grid, 4.65mm stacking lip.
Tray footprint at 365 × 82mm = approximately 9 × 2 Gridfinity units.
