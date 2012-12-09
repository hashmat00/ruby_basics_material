# Blocks and Procs

## The big ideas

## Blocks! Blocks! Blocks!

Blocks, more than anything, are what makes Ruby unique. Blocks are
chunks of code that get passed into methods. Methods then *call* the
block to customize their own behavior.

For instance, take `Enumerable#map`:

    [1, 2, 3].map { |num| num + 1 } # => [2, 3, 4]

`map` applies a block to each element of the array. What it does with
each element depends on the block. For instance, instead of adding one
to each element, we could square them:

    [1, 2, 3].map { |num| num * num } # => [1, 4, 9]

Fundamentally, methods often take blocks to allow the user to
customize what the method will do.

## Block syntax

Blocks are either wrapped in curly braces, or with a "do" and
"end". We could write the previous example as:

    [1, 2, 3].map do |num|
      num * num
    end # => [1, 4, 9]

Blocks are passed to a method, but they do not appear in the list of
arguments. They come after the closing parentheses, if there are any:

    3.times { puts "Hey, friend!" } # don't need parens when no args
    3.times() { puts "Hey, friend!" } # if parens used block is given outside parens

Blocks may take arguments, just like methods do. The argument names
are wrapped in '|' (called *pipes*).

    [1, 2, 3].map { |num| num * num }

Here `map` is going to call the block repeatedly; it will pass in each
of the elements. Each time, the element (1, 2, or 3) will be *bound*
to the `num` argument declared between the pipes.

When should you use the braces, and when do-end? Use braces for short,
single-line blocks. *Always use do-end for longer blocks*.

## Writing a method that takes a block

Blocks are passed to methods mostly like other arguments. Let's write
a method, `maybe` that will call a block only if its argument is
true. It should work like this:

    maybe(true) { puts "Hello!" } # runs block, since passed true
    maybe(false) { puts "Goodbye!" } # doesn't run block

Here's how we would define maybe:

    def maybe(flag, &blk)
      blk.call if flag
    end

Notice the `&blk` argument? The ampersand is a special symbol that
signifies that `blk` should hold a block. The block, if passed, gets
passed in the `blk` variable; else, `blk` is set to `nil`.

`blk` holds a `Proc` object. A block is the Ruby code you write; Ruby
then creates an object that will store your block so that you can call
it later. You can create a `Proc` object yourself:

    my_proc = Proc.new { "Hey, friend!" }
    my_proc.call # calls the block, which returns: "Hey, friend!"
    my_proc.call # calls it again

`Proc#call` calls the block. Any arguments you pass to `call` will be
passed on to the block.

    my_new_proc = Proc.new { |name| puts "Hello #{name}" }
    my_proc.call("Zimmy")

If a method takes a block argument, but one is not passed, then the
block variable is set to `nil`.

Finally, we can pass a `Proc` explicitly to a method:

    my_proc = Proc.new { puts "Hey, friend!" }
    maybe(true, my_proc) # no block, proc is passed explicitly

## yield

Ruby has a special syntax which simplifies passing blocks. You may use
the keyword `yield` to call the passed block without using a block
variable. Let's rewrite `maybe`:

    def maybe(flag)
      yield if flag
    end

We cannot pass an explicit `Proc` object in this case, so it is
somewhat less flexible.

## Avoid return inside a block

Blocks return values like Ruby methods; the last value is implicitly
returned from the block.

    add_one = Proc.new { |num| num + 1 } # num + 1 is returned
    two = add_one.call(1)

Ruby also lets you use `return` inside a method definition to
explicitly exit a method and return the value.

    def maybe(flag)
      return unless flag # return right away if flag is false
      yield
    end

Calling `return` in a block is tricky: it will return right away from
the block, but also from the method you called the block from. Example time:

    def log_task(task_name)
      puts "Beginning #{task_name}"
      yield
      puts "Completed #{task_name}"
    end
    
    log_task("silly block") do
      return 2 + 2
    end
    
This will print "Beginning silly block", begin running the block, but
then return from both the block *and* the `log_task` method. The
completion statement won't be printed.

Returning from blocks can be tricky; don't do it unless you have a
good reason. Normally it's just fine to let the last value be
returned.

** TODO: unexpected return error? **

## Symbols and blocks

It's very, very common to have blocks that take an argument and call a
single method:

    ["a", "b", "c"].map { |str| str.upcase } # upcase all strings
    [1, 2, 5].select { |num| num.odd? }

In this case, we can use a shortcut:

    ["a", "b", "c"].map(&:upcase)
    [1, 2, 5].select(&:odd?)

What is `&:upcase`? `:upcase` is a symbol which is the name of
`String`'s `upcase` method; in Ruby, we use symbols instead of strings
for method names. '&' calls `Symbol#to_proc`. So we turn the symbol
into a proc like this:

    &:upcase # => Proc.new { |str| str.upcase }
    :upcase.to_proc # same

Since `&:upcase` is a proc, we can pass it as an explicit argument to
`map`.

## Exercises
## References
http://www.robertsosinski.com/2008/12/21/understanding-ruby-blocks-procs-and-lambdas/
