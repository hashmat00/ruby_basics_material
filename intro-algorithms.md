# Intro to Algorithms: Trees

Ruby provides an Array class which is a "linear" collection of
elements. But there are other ways to represent collections and
organize data.

*Trees* store data in a hierarchy of layers. An element, or *node* at
each layer can have links to lower level nodes. One simple example is
a filesystem:

* /
  * Users
    * ruggeri
      * Desktop
      * Documents
      * Downloads
    * patel
      * Desktop
      * Downloads
  * System
    * Library

The top-level *node*, '/', is called the *root*. The *children* of a
node are the nodes one level deeper. The children of 'Users' are
'ruggeri' and 'patel'. The lowest level nodes (the ones with no
children) are called *leaves*.

In general, nodes can have any number of children. In the special case
of *binary trees*, nodes can have at most two children. These children
are typically called the *left* and *right* children.

** TODO: define a binary Tree class exercise **

## Depth First Search (DFS)

One common way to traverse (i.e., visit all the nodes) a tree is depth
first search. The nodes are numbered in the order that we visit them:

          1
         / \
        2   5
       /   / \
      3   6   9
     /   / \
    4   7   8

Each time, we try to visit the left child, if it exists and hasn't
been visited yet. If it has, we try to visit the right child, if it
exists and hasn't been visited yet. If all the children have been
visited, then we move up one level and repeat.

Implement depth first search yourself. Write a method for `TreeNode`
that takes a block, which returns true when a node meats the user's
criteria.

The canonical way to do so is to use a stack (first in, last out).

    1. Push the root node onto the stack
    2. while stack is not empty
      3. pop node off stack
      4. if node  matches the criteria, done
      5. else push right then left children onto stack
    6. Ran out of nodes; no satisfying node found. Done.

### Breadth first search

Breadth first search is an alternative to depth-first search.

          1
         / \
        2   3
       /   / \
      4   5   6
     /   / \
    7   8   9

To implement breadth first search, simply change the above algorithm
from using a stack (last in, first out) to a queue (first in, first
out).

An advantage of breadth-first search is that it considers shallower
nodes before deeper ones.

## Search problems

### Knight's Travails

Write a method that finds a path for a knight between two positions
on a chess board.

You can represent sequences of knight moves with a tree. Each
parent-child connection represents one move. The root is the knight's
starting position.

So if the knight starts in the middle of the board (e.g., e4), the
root node has eight children representing the eight possible knight
moves.

You want to perform a search through this tree. Be careful not to get
stuck in cycles; you'll need to keep track of positions you've already
visited.

Return the shortest path between the two positions. To do this, what
kind of tree traversal will you use?

### Tic-tac-toe AI

Extend the Tic-tac-toe game that you made in the Classes unit. Write
an AI that only wins or ties games. It should look ahead in a
[game tree](http://en.wikipedia.org/wiki/Game_tree) to make sure that
it can always avoid losses, no matter what move the opponent makes.
