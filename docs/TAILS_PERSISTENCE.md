# Tails Persistence

Tails works differently from other distros for persistence.

## Option 1: Ventoy Persistence (limited)
Tails does NOT work with Ventoy's standard persistence files.
You can only start Tails via the .img file, not via .iso

## Option 2: Tails own persistence partition
1. Start Tails via Ventoy
2. Configure persistence via Tails' own tools
3. See: https://tails.net/doc/persistence/

## Option 3: Ventoy Plugson (not tested)
You can use Ventoy Plugson for Tails specific options
(See ventoy_src/INSTALL/VentoyPlugson.sh)

---
Note: Tails .img file is already present but has no persistence via Ventoy.