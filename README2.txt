CS4337 Project 2 – Maze Solver (Prolog)
Author: Arath Brosig

========================================
HOW TO RUN THE PROJECT
========================================

This project implements the predicate:

    find_exit(+Maze, ?Actions)

which determines whether a sequence of actions moves from the
start cell 's' to an exit cell 'e' in a grid-based maze.

----------------------------------------
1. HOW TO LOAD THE PROJECT
----------------------------------------

From the project root directory:

    swipl src/example.pl src/test.pl src/project2.pl

This loads:
  - example.pl : sample mazes and the display_map/1 predicate
  - test.pl    : gen_map/4 random maze generator
  - project2.pl : the maze solver implementation

You should now see the Prolog prompt:

    ?-

----------------------------------------
2. BASIC USAGE
----------------------------------------

A) Verify and generate paths on provided example maps:

    ?- simple_map(M), display_map(M), find_exit(M, Actions).

This prints the tiny example maze and unifies Actions with a valid sequence
such as:

    Actions = [right, right] ;
    false.

(Press ENTER to accept the first solution.
 Press ';' to request further solutions.)

----------------------------------------
3. VALID MAPS VS INVALID MAPS
----------------------------------------

Valid maps succeed:

    ?- basic_map(M), find_exit(M, Actions).

Invalid maps fail:

    ?- bad_map(M), find_exit(M, _).
    false.

    ?- bad_map2(M), find_exit(M, _).
    false.

    ?- bad_map3(M), find_exit(M, _).
    false.

    ?- bad_map4(M), find_exit(M, _).
    false.

----------------------------------------
4. VERIFYING SPECIFIC ACTION LISTS
----------------------------------------

The solver can check a specific action list:

    ?- simple_map(M), find_exit(M, [right, right]).
    true.

    ?- simple_map(M), find_exit(M, [right]).
    false.

----------------------------------------
5. RANDOM MAZE GENERATION
----------------------------------------

Use gen_map/4 to create a random maze:

    ?- gen_map(4, 10, 10, M), display_map(M).

To attempt a bounded search for a path:

    ?- gen_map(4, 10, 10, M), find_exit(M, Actions).

The solver will search for action lists up to a maximum length based
on maze size (Rows * Cols).

You may also use the explicit helper:

    ?- gen_map(4, 8, 8, M), find_exit_upto(M, 20, Actions).

----------------------------------------
6. EXITING PROLOG
----------------------------------------

Press CTRL + D  (Linux/Mac)
or type:

    ?- halt.

----------------------------------------
7. FILE LIST
----------------------------------------

src/project2.pl   – Main solver implementation
src/example.pl    – Provided example mazes & display predicate
src/test.pl       – Provided random maze generator
test/sample-run.txt – Example queries and outputs
docs/README.md    – Full project documentation
docs/devlog.md    – Development log
README2.txt       – This file: quick “How to Run” instructions
