### Project 2 Initialization

**Date:** November 24, 2025
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

**Date:** November 24, 2025
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
