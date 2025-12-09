### Project 2 Initialization

**Date:** November 29, 2025
**Goal:** Begin Prolog maze solver project (Project 2).

**Process:**
- Created project directory structure.
- Added `src/`, `test/`, and `docs/` folders.
- Prepared `project2.pl` as main solver file.
- Added placeholders for README and sample run.

**Next Steps:**
- Load example.pl and test.pl into project.
- Implement initial maze validation predicates.

### Prolog Solver Scaffolding

**Date:** November 30, 2025
**Goal:** Create initial structure for the maze solver in Prolog.

**Process:**
- Created `src/project2.pl` with scaffolding for:
  - `find_exit/2` and `find_exit/1`
  - `valid_maze/1`
  - `start_position/3` and `exit_position/3`
  - `step/5`, `legal_position/3`
  - `follow_actions/4`
- Verified that `example.pl`, `test.pl`, and `project2.pl` load together in SWI-Prolog with no syntax or undefined predicate errors.
- Confirmed that current behavior is safe failure (all predicates stubbed with `fail`), ready to fill in logic incrementally.

**Next Steps:**
Implement `valid_maze/1` and `start_position/3` so the program can:
- Reject malformed mazes (bad shape, wrong number of s/e).
- Locate the starting coordinate for the solver.

### Maze Validation and Start Detection

**Date:** December 1, 2025  
**Goal:** Implement maze validation and starting position logic.

**Process:**
- Implemented `cell/4` using `nth0/3` to access maze cells by (Row, Col).
- Implemented `valid_maze/1` to enforce:
  - Non-empty maze with rectangular shape (all rows same length).
  - Only valid cell symbols: f, w, s, e.
  - Exactly one start cell `s`.
  - At least one exit cell `e`.
- Added `all_rows_same_length/2` and `valid_cell/1` helper predicates.
- Implemented `start_position/3` by searching for the unique `s` cell.
- Tested with `simple_map/1`, `basic_map/1`, and the various `bad_map*` examples from `example.pl`.
- Confirmed that valid maps succeed and malformed maps fail `valid_maze/1`.

**Next Steps:**
- Implement movement logic via `step/5` and `legal_position/3`.
- Implement `follow_actions/4` and wire it into `find_exit/2` so that action lists can be verified and eventually generated.

### Movement, Legality, and Action Following

**Date:** December 8, 2025  
**Goal:** Implement movement rules and path simulation over the maze.

**Process:**
- Implemented `step/5` to translate actions (left, right, up, down) into row/column deltas.
- Implemented `legal_position/3` to ensure moves stay within bounds and avoid walls (`w`).
- Implemented `follow_actions/4`:
  - Base case: with no actions left, current cell must be an exit (`e`).
  - Recursive case: apply one action via `step/5`, check `legal_position/3`, and recurse.
- Updated `find_exit/2` to:
  - Validate the maze via `valid_maze/1`.
  - Locate the start position via `start_position/3`.
  - Use `follow_actions/4` to simulate the `Actions` list from the start.
- Tested:
  - `simple_map/1` with `[right,right]` (success) and invalid lists (fail).
  - `basic_map/1` with paths that reach the exit and paths that hit walls or go out of bounds.

**Next Steps:**
- Enable full Prolog-style generation of `Actions` when unbound, and test with `gen_map/4` for random mazes.
- Polish comments and prepare for final demonstration / sample run.

### [Bugfix] Prevented Unbounded Action Generation

**Issue:** Calling `find_exit(Maze, Actions)` with `Actions` unbound caused Prolog to explore action lists of unbounded length, leading to stack overflow.

**Fix:**
- Updated `find_exit/2` to:
  - If `Actions` is nonvar: simply verify via `follow_actions/4`.
  - If `Actions` is var: compute a max path length using `maze_max_path_length/2`, then use `between/3` and `length/2` to bound search.
- Added `maze_max_path_length/2` to estimate a reasonable maximum path length as `Rows * Cols`.

**Result:** `find_exit/2` now safely supports both verification and generation, even for random mazes generated with `gen_map/4`, without overflowing the stack.

### Generating Actions and Random Maze Testing

**Date:** December 9, 2025  
**Goal:** Use Prolog's backtracking to generate valid action sequences and test with random mazes.

**Process:**
- Confirmed that `find_exit/2` works in two modes:
  - Verification: given a specific `Actions` list, check if it reaches an exit.
  - Generation: with `Actions` unbound, Prolog enumerates action lists via backtracking.
- Created helper predicates:
  - `find_exit_with_length/3` to constrain paths to a specific length.
  - `find_exit_upto/3` to search all paths up to a given maximum length.
- Tested:
  - `simple_map/1` and `basic_map/1` with generated `Actions`.
  - `gen_map/4` from `test.pl` with length-bounded search for random mazes.
- Added `test/sample-run.txt` documenting typical queries and expected behavior.

**Reflection:**
The solver now behaves like a proper search procedure: it can both verify and synthesize paths. Bounded search is important to prevent nontermination on large or unsolvable mazes, especially when using randomly generated maps.

**Next Steps:**
- Final polish: comments, README updates, and preparing the project for submission (zipping repo, pushing to GitHub).
