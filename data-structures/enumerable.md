# Enumerable

Enumerable is a Ruby *module*. A *module* is a collection of methods
(and constants). Modules can be *mixed in* to other classes; this just
means that the module's methods are available in the class that it is
mixed into.

Enumerable is one of the most powerful modules in Ruby; it holds methods such
as *map*, *inject* and *each*. Because Enumerable is mixed into Array and Hash
(as well as other classes), these Enumerable methods are available on both
Array and Hash.

Let's take a look at some of the most commonly used and powerful methods in
the Enumerable module.

***

### Enumerable#each:

You've already seen this before! If you want a refresher, just look at
the [Hash](hash.md#each) and [Array](array.md#each) pages. You'll want
to use `each` when you want to run some code (block) for each element
in an Array (or Hash).

***

### Enumerable#map (synonymous to Enumerable#collect)

Map returns a new array with the results of running the called block once
for each element. For example:

    integers = [1, 2, 3, 4]
    integers.map { |i| i*i }
    # => [1, 4, 9, 16]

    nato = {:a => "alpha", :b => "bravo"}
    nato.map { |key, value| value.upcase }
    # => ["ALPHA", "BRAVO"]

On the surface, `map` and `each` look the same. They aren't! `each`
returns the **original array**, while `map` returns a **new
array**. **Neither method modifies the original array.** To
illustrate:

    integers = [1, 2, 3, 4]

    map_return_value = integers.map { |i| i*i }
    map_return_value # => [1, 4, 9, 16]

    each_return_value = integers.each { |i| i*i }
    each_return_value # => [1, 2, 3, 4]

This is the source of **many** programming bugs, so watch out! Like `each`,
you'll want to use `map` when you want to run some code (block) for each element
in an Array (or Hash). Whether you'll prefer `each` or `map` in a given situation
will depend on what return value you'd like.

    # Write a method that takes an array of the integers from 1 - 10 and
    returns an array with the array elements multiplied by 2. Next, change the
    method so that it returns the original array, but stores the array
    elements multiplied by 2 in an array named 'double_the_fun'.

***

### Enumerable#inject (synonymous to Enumerable#reduce):

Enumerable#inject is a bit complicated, but once you get the hang of it,
you'll love it for its power and concision.

Generally, you want to use inject when you are trying to build up an object
piece by piece.

Let's start by looking at an example of how you'd use inject to sum all the
elements in an array:

    nums = [1, 2, 3, 4, 5]
    nums.inject do |acc, element| 
      acc + element
    end
    
    # Write a method that takes nums and, using inject, returns the product of
    all of the elements.

For each element in `nums`, the code block (i.e., `acc + element`) is
passed an accumulator value (`acc`) and the element itself. The result
of the code block becomes the `acc` for the next element in
`nums`. This continues until we run out of elements; then the final
value of `acc` is returned.

`inject` is handy and powerful, but it doesn't come up as often as
`map` or `each`.

***

### Enumerable#select (synonymous to Enumerable#find_all)

`select` returns an array with all the elements for which the called code block
returns true. Let's look at an example:

    nums = (1..10)
    # nums is a Range. Ruby's Range class also mixes in Enumerable!

    nums.select do |i|
      i % 3 == 0
    end
    # => [3, 6, 9]
    
    # Write a method that takes a range of the integers from 1 to 100 and
    uses select to return an array of those that are perfect squares.

***

### Enumerable#count

Enumerable#count returns the number of items in the collection it's called on.
For example:

    nums = [1, 4, 5, 6, 7]
    nums.count # => 5

    elements = {:first => "hydrogen", :second => 'helium', :third => 'lithium'}
    elements.count # => 3

In a hash, `count` returns the number of key-value pairs.

***

### Enumerable#include?

Enumerable#include?(obj) takes an object as a parameter and returns true if
any item in the collection is equal to that object. Let's see it in action:

    nums = [1, 4, 5, 6, 7]

    nums.include?(3) # => false
    nums.include?(4) # => true

***

### Enumerable#any?

Enumerable#any? returns true if the code block returns true for any of the
members of the collection. Here's an example of how we can check to see if a
given array has any even numbers:

    nums = [2, 3, 5, 7]

    nums.any? do |i|
      i % 2 == 0
    end
    # => true
    
    # Using any?, verify that the range of integers from 1 to 5 does include
    at least one odd number

The methods `all?` and `none?` work similarly.

## Exercises

* Write a method that finds the median of a given array of
  integers. If the array has an odd number of integers, return the
  middle item from the sorted array. If the array has an even number
  of integers, return the average of the middle two items from the
  sorted array.

## Resources
[Ruby Doc on Enumerable](http://ruby-doc.org/core-1.9.3/Enumerable.html)

** TODO: More long exercises + resources required. Also, what you should learn **
