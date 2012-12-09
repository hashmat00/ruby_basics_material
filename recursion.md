# Recursion

Recursion is the technique of solving a problem by reducing it to
smaller instances of the same problem.

## Recursive methods

A recursive method is one that calls itself. Each time the method
calls itself, it tries to solve a smaller *subproblem*. Think of this
as breaking a large problem into smaller problems. Each of these may
be divided again into smaller problems.

The subproblems keep getting smaller and smaller, until they are small
enough to solve trivially. These small subproblems are called *base
cases*.

The factorial operation is one example of a problem that can be solved
recursively. Recall that five factorial is:

    5! = 5 * 4 * 3 * 2 * 1
    n! = n * (n - 1) * (n - 2) * ... * 1

We can also define factorial *recursively*:

    1! = 1
    n! = n * (n - 1)!

Let's implement this recursive definition:

    def factorial(n)
      if n == 1 # the base case
        1
      else # the recursive case
        n * factorial(n - 1)
      end
    end

Let's walk through how this method is evaluated for `factorial(3)`

    factorial(3)
    => 3 * factorial(2)
    => 3 * 2 * factorial(1)
    => 3 * 2 * 1
    => 6

## Recursion vs iteration

Recursive methods can always be written *iteratively*: using loops
and no recursion. Let's try our hand at the factorial method:

    def factorial(n)
      result = 1
      (1..n).each do |i|
        result *= i
      end
      
      result
    end

In fact, any recursive method can always be written
iteratively. However, the iterative form can sometimes be
significantly more complicated. When choosing whether to solve a
problem recursively or iteratively, you should think about which
solution is more natural to your own mind.

## Exercises

* Test First Ruby XML parser
* Write the following methods both recursively and iteratively
  * fibonacci
  * sum of an array
  * binary search: bsearch(array, target)
  * exponent

Write two versions of exponent that use two different recursions:

    exp(b, 0) = 1
    exp(b, n) = b * exp(b, n - 1)

    exp(b, 0) = 1
    exp(b, 1) = b
    exp(b, n) = exp(b, floor(n / 2)) * exp(b, ceil(n / 2))

Which one do you think runs more quickly?

## Resources

[Wikipedia: Recursion](http://en.wikipedia.org/wiki/Recursion_(computer_science))
