# CS4337 Project 2 – Prolog Maze Solver

**Author:** Arath Brosig  
**Course:** CS4337 – Programming Language Paradigms  
**Language:** Prolog (SWI-Prolog 9.x)

---

## Project Description

This project implements a **maze solver in Prolog** via the predicate:

```prolog
find_exit(+Maze, ?Actions).
The maze is represented as a list of rows, each a list of cells:

s — start position (exactly one)

e — exit cell (one or more)

f — floor (walkable)

w — wall (blocked)

The Actions argument is a list of moves:

left, right, up, down

The solver can:

Verify a given sequence of actions (Actions is bound).

Generate a valid sequence of actions (Actions is unbound), up to a bounded path length based on maze size.

Project Structure

paradigms_project_02/
│
├── src/
│   ├── project2.pl     % implementation of find_exit/2
│   ├── example.pl      % provided sample mazes + display_map/1
│   └── test.pl         % gen_map/4 random maze generator
│
├── test/
│   └── sample-run.txt  % Example Prolog sessions / queries
│
└── docs/
    ├── README.md
    └── devlog.md       % Development log

How to Run
From the project root (paradigms_project_02/):

bash
swipl src/example.pl src/test.pl src/project2.pl

You should then see the Prolog prompt:

prolog
?- 

Example Queries
1. Simple Map (from example.pl)

prolog
?- simple_map(M), display_map(M), find_exit(M, Actions).

Expected behavior:

Displays a small 1×3 maze.

Binds Actions to a valid path, e.g.:

prolog
Actions = [right, right] ;
false.

You can also verify a specific path:

prolog
?- simple_map(M), find_exit(M, [right, right]).
true.

?- simple_map(M), find_exit(M, [right]).
false.

2. Basic Map

prolog
?- basic_map(M), display_map(M).
?- basic_map(M), find_exit(M, Actions).
Typical result:

prolog
Actions = [down, down, left] ;
...

The first solution is usually a short valid path; pressing ; asks Prolog to search for alternative paths (potentially longer, with loops).

3. Invalid / “Bad” Maps
The file example.pl defines several malformed mazes:

prolog
?- bad_map(M), find_exit(M, _).
false.

?- bad_map2(M), find_exit(M, _).
false.

?- bad_map3(M), find_exit(M, _).
false.

?- bad_map4(M), find_exit(M, _).
false.

These fail because they violate the validity rules enforced by valid_maze/1 (wrong number of s/e, inconsistent row length, etc.).

4. Random Maze Generation (test.pl)
test.pl defines:

prolog
gen_map(+Iterations, +Rows, +Cols, -Maze).
Example:

prolog
?- gen_map(4, 10, 10, M), display_map(M).

To attempt finding a path with bounded length:

prolog
?- gen_map(4, 10, 10, M), find_exit(M, Actions).

Or, using the explicit helper:

prolog
?- gen_map(4, 8, 8, M), find_exit_upto(M, 20, Actions).

If a path exists within the bound, Actions will be unified with a sequence such as:

prolog
Actions = [down, right, right, up, ...] ;

Otherwise, the query eventually fails.

Design Notes
Key predicates in project2.pl:

valid_maze/1

Ensures rectangular shape (all rows same length).

Checks that all cells are one of f, w, s, e.

Enforces exactly one s and at least one e.

cell/4

Accesses elements by (Row, Col) using nth0/3.

start_position/3

Locates the unique s cell.

step/5

Encodes how actions (left, right, up, down) change coordinates.

legal_position/3

Ensures a position is inside the maze and not a wall (w).

follow_actions/4

Recursively applies a list of actions from a starting coordinate.

Requires ending on a cell marked e.

find_exit/2

Orchestrates validation, starting position, and path following.

In verification mode (Actions bound), it simply checks.

In generation mode (Actions unbound), it uses a bounded search over action lists whose length is limited by maze_max_path_length/2.