# Iteration

## What you should learn
* What is an *index* variable?
  * indices start at zero
* How do you write a `while` loop?
* How do you use the `each` method to iterate over elements of an
  array?
* How do you use `each_with_index` to iterate through elements along
  with indices?
* How do you use `times` to execute a block of code several times?
* What is a *range*?
* How can you nest loops?

* break?
* don't use for loops

## While loops

The most primitive loop is the `while` loop. It repeats a section, or
*block* of code repeatedly as long as a condition is true. For
instance,

    while true
      puts "Infinite loop!"
    end

will spin round and around repeatedly, forever. Most loops eventually
stop, however:

    i = 0
    while i < 5
      puts "Repeat 5 times!"
      
      i += 1
    end
    
    puts "Merry Christmas, loop is over!"

This is a very traditional loop. `i` is called the *index*, and it
keeps track of how many times we've gone through the loop.

`i` starts at zero, because we've gone through the loop zero
times. The loop will keep running so long as `i < 5`; that is, we'll
keep looping until we've executed the code block (the stuff between
the while and the end lines) five times. Each time around, at the end
of the loop block, one is added to `i`. After the first time through
the block, `i` is set to one, and the program jumps back to the top of
the `while`. Since one is still less than five, the loop repeats.

`i` takes on, or *iterates* through the values 0,1,2,3,4,5. After the
fifth time around the loop, `i` is set to five (not four, not six;
convince yourself of this).

The loop finally comes back around for the *sixth* time to the while
test. Remember, `i` has just been set to five. `i < 5` is no longer
true. So the code block is not executed and the loop exits, so that
the code following the loop's `end` is run.

This is the most basic loop. If all else fails, you can always fall
back on this. All the other loop forms are just more convenient forms
of this basic loop style.

** SCRNCST: step through a while loop, printing values of index each time **

### Indices start at zero

We could have changed our loop ever so slightly:

    i = 1
    while i <= 5
      puts "Repeat 5 times!"
      
      i += 1
    end

This would do the same thing as our previous loop; verify this for
yourself.

Don't write loops with indices starting at one; you'll confuse other
programmers. Indices have started at zero for a long time, and it's
what other programmers are used to. This is called an *idiom*; idioms
are coding conventions that are commonly used. They are a good thing,
because conventions we've seen before are easier to understand when we
see them again.

As the Japanese say, "the nail that sticks out gets hammered down."

** SCRNCST: can also do a while without an index **

## Break

Let's search an array of numbers for a favorite number.

    my_favorite_numer = 42
    numbers_to_search = [1, 5, 7, 42, 8, 42]
    
    i = 0
    while i < numbers_to_search.count
      current_number = numbers_to_search[i]
      
      if my_favorite_number == current_number
        puts "List contains favorite number!"
        break
      end
    end

The `break` keyword jumps out of the loop. This means that the loop
will end as soon as we find our favorite number. In this case, we save
extra cycles going through the loop, and we make sure we print out
"Found my..." at most once.

## Iterating through arrays with each

If you have an array, and want to loop through all the items, you
could write:

    musicians = ['George', 'Paul', 'John', 'Ringo']
    
    i = 0
    while i < musicians.length
      puts musicians[i]
      i += 1
    end

Instead, you should write:

    musicians.each do |musician|
      puts musician
    end

Here, you are *iterating* over the elements of the array. The lines
between the do and end are the code block to repeat. For each element
in the array, the `each` method sets the musician variable to the
current element, then executes the code block.

The biggest advantage of `each` is that you don't have to keep track
of an index variable. This may not seem like a big deal, but every
line of code you don't have to write is one less to debug.

In particular, one of the most common programming errors is to forget
to increment the index variable aech time:

    i = 0
    while i < 5
      puts "Do this five times"
      
      # forgot: i += 1
    end

### each vs for

Ruby also has a `for` loop construct:

    for item in items
      # ...
    end

For boring reasons, `for` is not recommended for use. You should use
`each` to do the same thing:

    items.each do |item|
    end

## each_with_index

`each` is preferable to `while` when you can use it; sometimes you
need an array index, though. In many of these cases, `each_with_index`
will serve you well.

For example, say we want to find the indices of all the occurences of
my favorite number:

    my_favorite_number = 42
    numbers = [42, 3, 42, 5]
    
    favorite_indices = []
    
    i = 0
    while i < numbers.count
      if numbers[i] == my_favorite_nmber
        favorite_indices << i
      end
      
      i += 1
    end

There has to be a better way:

    my_favorite_number = 42
    numbers = [42, 3, 42, 5]
    
    favorite_indices = []
    numbers.each_with_index do |number, index|
      if number == my_favorite_number
        favorite_indices << index
      end
    end

This lets us get access to the index, but avoids the nuisance (and
bugs) of having to increment the index ourselves.

## Iterating with times

If all you want to do is repeat some code several times, use Ruby's
`times` method:

    5.times do
      puts 'King of the streets; child at play'
    end

Again, you get to avoid an index variable.

## Range

A range is exactly what it sounds like:

    (1..10)
    
represents all the numbers from 1 through 10. We can iterate over
ranges just like we iterated over arrays:

    (1..10).each do |i|
      puts i * i
    end

## Nesting loops

Loops can be placed inside each other, or *nested*. Here's some nested
loops that prints out a times table:

    (1..10).each do |i|
      multiples = []
      (1..10).each do |j|
        multiples << i * j
      end
      
      p multiples
    end

Note, when you have two indices, `i` and `j` are conventional
names. However, they are often the lazy way out: unclear, abstract
index names are a major source of confusino and bugs. Here names like
`num1` and `num2` would make things clearer.

*Avoid deep nesting*. Nested code should be split out into
methods. Two levels deep is usually okay, more is almost always
bad. For instance, we could change our times table code like this:

    def multiples(i)
      ms = []
      (1..10).each do |j|
        ms << i * j
      end

      ms
    end

    (1..10).each do |i|
      p multiples(i)
    end

## Exercises

* Print out the first 100 squares
* Loop through all the numbers, stopping when you encounter a number
  that is (a) >250 and (b) divisible by 7. Print it down!
* Print out all the factors for the numbers 1 through 100.
* Bubble sort

> Bubble sort, sometimes incorrectly referred to as sinking sort, is a
> simple sorting algorithm that works by repeatedly stepping through
> the list to be sorted, comparing each pair of adjacent items and
> swapping them if they are in the wrong order. The pass through the
> list is repeated until no swaps are needed, which indicates that the
> list is sorted. The algorithm gets its name from the way smaller
> elements "bubble" to the top of the list. Because it only uses
> comparisons to operate on elements, it is a comparison
> sort. Although the algorithm is simple, most other algorithms are
> more efficient for sorting large lists.

* Given a string, print all the substrings.
  * Next download a dictionary from [here](http://wordlist.sourceforge.net/)
  * Read in the dictionary
    * Learn how to read a file [here]().
    * You may need to use String's chomp method.
  * Now print out only those substrings that are words

## Resources

* http://www.tutorialspoint.com/ruby/ruby_loops.htm
* http://www.skorks.com/2009/09/a-wealth-of-ruby-loops-and-iterators/
