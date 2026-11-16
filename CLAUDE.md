# Kill The Cockroach (watchOS)

What it is: `README.md`.

## Code map (read first)

`.claude/codemap/` saves tokens: `ARCHITECTURE.md` (the shape) and `index.json` (per file:
SHA-256 prefix, one-line purpose, types, imports, project types it uses; `+T` = extension of `T`).
1. Read the map before opening sources (in a large map, `grep` it for a path or type); open only the files the task needs.
2. `Scripts/codemap.py --changed` lists files whose hash differs from the map: re-read only those;
   a file you read this session whose hash is unchanged needs no second read.
3. After editing, run `Scripts/codemap.py` (rescans changed files only) and commit the map with
   the change. Fix a `purpose` by hand when a file's role changes; new files with no header comment are listed.
- Structure questions (who uses what, dependencies): ask the graphify MCP (`.mcp.json`; graph in git-ignored `graphify-out/`). Re-run `graphify` after big changes.
