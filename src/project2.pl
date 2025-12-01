% =========================================
% CS4337 Project 2 - Maze Solver in Prolog
% Author: Arath Brosig
%
% Main goal:
%   find_exit(+Maze, ?Actions)
%
% Maze:
%   - A list of rows, each being a list of cells.
%   - Cells: f (floor), w (wall), s (start), e (exit).
%
% Actions:
%   - A list of moves: left, right, up, down.
%
% This file currently contains scaffolding only.
% We will fill in each predicate step-by-step.
% =========================================

% -----------------------------------------
% Public predicates
% -----------------------------------------

% find_exit(+Maze, ?Actions)
%  - Succeeds if Actions leads from 's' to an 'e'.
%  - If Actions is unbound, will eventually generate solutions (once implemented).
find_exit(_Maze, _Actions) :-
    % TODO: implement full solver
    fail.

% Convenience wrapper:
% allows queries like: find_exit(Maze).
find_exit(Maze) :-
    find_exit(Maze, _).

% -----------------------------------------
% Maze validation (to be implemented)
% -----------------------------------------

% valid_maze(+Maze)
%  - Will ensure exactly one 's', at least one 'e',
%    rectangular shape, and valid symbols.
valid_maze(_Maze) :-
    % TODO: implement
    fail.

% -----------------------------------------
% Start / exit position finding (to be implemented)
% -----------------------------------------

% start_position(+Maze, -Row, -Col)
%  - Will locate the 's' cell in the maze.
start_position(_Maze, _Row, _Col) :-
    % TODO: implement
    fail.

% exit_position(+Maze, -Row, -Col)
%  - Optional helper to find 'e' cells.
exit_position(_Maze, _Row, _Col) :-
    % TODO: implement (if needed)
    fail.

% -----------------------------------------
% Movement and legality (to be implemented)
% -----------------------------------------

% step(+Action, +Row, +Col, -NewRow, -NewCol)
%  - Will define how each action changes coordinates.
step(_Action, _Row, _Col, _NewRow, _NewCol) :-
    % TODO: implement
    fail.

% legal_position(+Maze, +Row, +Col)
%  - Will check bounds and walls ('w').
legal_position(_Maze, _Row, _Col) :-
    % TODO: implement
    fail.

% -----------------------------------------
% Following actions (to be implemented)
% -----------------------------------------

% follow_actions(+Maze, +Row, +Col, +Actions)
%  - Will apply Actions starting at (Row,Col)
%    and succeed if the final cell is 'e'.
follow_actions(_Maze, _Row, _Col, _Actions) :-
    % TODO: implement
    fail.
