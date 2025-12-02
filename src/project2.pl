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
% Conditions:
%   - Maze has at least one row and each row same length.
%   - All cells are one of [f, w, s, e].
%   - Exactly one 's'.
%   - At least one 'e'.
valid_maze(Maze) :-
    Maze = [FirstRow|_],
    length(FirstRow, Width),
    Width > 0,
    all_rows_same_length(Maze, Width),
    % Collect all cells
    findall(Cell, cell(Maze, _, _, Cell), Cells),
    maplist(valid_cell, Cells),
    % Exactly one start
    findall(_, cell(Maze, _, _, s), Starts),
    length(Starts, 1),
    % At least one exit
    findall(_, cell(Maze, _, _, e), Exits),
    Exits \= [].

% all_rows_same_length(+Maze, +Width)
all_rows_same_length([], _).
all_rows_same_length([Row|Rest], Width) :-
    length(Row, Width),
    all_rows_same_length(Rest, Width).

% valid_cell(+Cell)
valid_cell(Cell) :-
    member(Cell, [f, w, s, e]).

% cell(+Maze, ?Row, ?Col, ?Cell)
% Row and Col are 0-based indices.
cell(Maze, Row, Col, Cell) :-
    nth0(Row, Maze, RowList),
    nth0(Col, RowList, Cell).


% -----------------------------------------
% Start / exit position finding
% -----------------------------------------

% start_position(+Maze, -Row, -Col)
% Because valid_maze/1 enforces exactly one 's', the cut is safe.
start_position(Maze, Row, Col) :-
    cell(Maze, Row, Col, s), !.

% exit_position(+Maze, -Row, -Col)
% (You can leave this as a helper if you want it later.)
exit_position(Maze, Row, Col) :-
    cell(Maze, Row, Col, e).

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
