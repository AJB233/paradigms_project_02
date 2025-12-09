% =========================================
% CS4337 Project 2 - Maze Solver in Prolog
% Author: Arath Brosig
% =========================================

% -----------------------------------------
% Public predicates
% -----------------------------------------

% find_exit(+Maze, ?Actions)
%  - Succeeds if Actions leads from 's' to an 'e'.
%  - If Actions is unbound, Prolog can generate valid action lists.
find_exit(Maze, Actions) :-
    valid_maze(Maze),
    start_position(Maze, StartRow, StartCol),
    follow_actions(Maze, StartRow, StartCol, Actions).

% Convenience wrapper:
% allows queries like: find_exit(Maze).
find_exit(Maze) :-
    find_exit(Maze, _).

% -----------------------------------------
% Maze validation
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
% Movement and legality
% -----------------------------------------

% step(+Action, +Row, +Col, -NewRow, -NewCol)
% Actions: left, right, up, down.
step(left,  Row, Col, Row, NewCol) :- NewCol is Col - 1.
step(right, Row, Col, Row, NewCol) :- NewCol is Col + 1.
step(up,    Row, Col, NewRow, Col) :- NewRow is Row - 1.
step(down,  Row, Col, NewRow, Col) :- NewRow is Row + 1.

% legal_position(+Maze, +Row, +Col)
% True if (Row,Col) is inside the maze and not a wall 'w'.
legal_position(Maze, Row, Col) :-
    Row >= 0,
    Col >= 0,
    cell(Maze, Row, Col, Cell),  % fails if out-of-bounds
    Cell \= w.

% follow_actions(+Maze, +Row, +Col, +Actions)
% Succeeds if applying Actions starting at (Row,Col)
% ends on a cell marked 'e'.

% Base case: no actions left; must be on an exit.
follow_actions(Maze, Row, Col, []) :-
    cell(Maze, Row, Col, e).

% Recursive case: apply one action, check legality, then continue.
follow_actions(Maze, Row, Col, [Action|Rest]) :-
    step(Action, Row, Col, NewRow, NewCol),
    legal_position(Maze, NewRow, NewCol),
    follow_actions(Maze, NewRow, NewCol, Rest).