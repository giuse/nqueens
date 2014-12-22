# N-Queens puzzle solver - version 4.2

Places `n` chess queens on an `n x n` chessboard without conflicts.

### Approach

This puzzle can be seen as enforcing two conditions over a set of `n` coordinates on a `n`-by-`n` chessboard:
- There should be no orthogonal crossing (no two coords sharing row/column), 
- There should be no diagonal crossing (no two coords on same diagonal).

I satisfy the first by building candidate solutions from permutations of rows and columns, to grant their uniqueness. I verify the second condition by rotating the reference system by PI/4 radians, then checking the common rows/columns.

### Optimization

Explicitly searching a permutation space is extremely inefficient. In order to reduce its size, I fix the order of the queens description, without loss of generality: the first queen is always on the first row, the second on the second row, etc. This means I can describe a solution as a permutation of column positions, rather than the (more common) approach of row/column permutations.

This method is extremely efficient in both CPU and RAM usage. My laptop finds all solutions (including mirrored) for the classic 8 queens in half a second, and 9 queens in less than 6 seconds, with a ram occupation of few KB since each solution is evaluated (and usually discarded) upon construction.

... And this is a good example of why I prefer approaching a hard problem with a high-level language and optimize the algorithm, rather than lose myself in making a highly optimized language solve a complex problem.

### Further work

I'm very tempted to bring it to 3D-chess :) only the terminal pretty printing won't cut it out anymore.
