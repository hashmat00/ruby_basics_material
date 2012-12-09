# Input/Output

## Standard IO

The most basic IO methods are `Kernel#gets` and `Kernel#puts`:

    input = gets
    puts input # put it back out

`gets` will read a line from the *standard input*, which is usually
the terminal the user is typing into. It returns the string the user
typed, including the *newline character* (newline character is the
'return' character, written `"\n"`)

    input = gets # I type Hello world!, and press enter
    # input == "Hello world!\n"

Because the newline is often undesired, frequently we use
`String#chomp` to remove it

    input = gets.chomp
    # get a string from the input, chop off the newline, store it in
    # input

`print` converts its argument to a string by calling `Object#to_s`,
then it writes it out to the standard output.

    print "this that other" # prints 'this that other' to console
    print [1, 2, 3] # prints '[1, 2, 3]' to console

`print` doesn't add a newline after it prints output, which means
consecutive calls to `print` all print to the same line.

    print "this"
    print "that" # => prints "thisthat"
    print "\n" # => adds a newline
    print "I'm on a new line"

Since it's common to want to add newlines to the end, Ruby has another
method `puts`. It's pretty simple:

    puts "this" # => prints "this" with a newline
    puts [1, 2, 3] # => prints "1\n2\n3\n"

Notice that `puts` adds newlines after each object in an array.

Finally, there is the `Kernel#p` method, which is like `puts`, but is
used for debugging and the REPL (REPL means *read-eval-print loop*;
irb is the standard Ruby REPL). Instead of calling `Object#to_s`, `p`
calls `Object#inspect`. The main difference is:

    puts "this" # => prints "this" with a newline
    p "this" # => prints '"this"' with a newline; note the quotes

## File IO

You often want to read data in from files, rather than the console.

## Opening a file

The typical way to open a file is as follows:

    File.open("movie-times.txt") do |f|
      line = f.gets
      # ...
    end

The class method `File::open` opens a file. You pass a block, and the
block will be called with `File` object passed in.

To read data from a file, you can call `File#gets`, which works like
`Kernel#gets`, but reads from the file, rather than console.

If, as is often the case, you want to do something once for each line:

    File.foreach("movie-times.txt") do |line|
      # ...
    end

Finally, if you'd like to read the entire file into one long string,
you may write

    contents = File.read("movie-times.txt")

## Writing a file

To open a file for writing, you need to pass `"w"` to `File.open` for
write mode:

    File.open("cool-things.txt", "w") do |f|
      f.puts "Race cars"
      f.puts "Lasers"
      f.puts "Aeroplanes"
    end

It is often more common to use `File#<<` to write to the file:

    File.open("cool-things.txt", "w") do |f|
      f << "Race cars"
      f << "Lasers"
      f << "Aeroplanes"
    end

This saves some lines, and because `f << "Race cars"` returns `f`
again, you can chain the method:

    f << "Race cars" << "Lasers" << "Aeroplanes"

## Standard Output and Input

We've seen the methods `Kernel#puts` and `Kernel#gets` as well as
`File#puts` and `File#gets`. Surprise! They're related!

In \*nix operating systems (like Linux, BSD, and OS X), the console
input and output are just special files. You can read and write to
them like any other file. These are called *standard input* and
*standard output*.

In Ruby, you can access standard input and output through the global
variables `$stdout` and `$stdin`. These variables just hold typical
`File` objects. In particular, `Kernel#gets` and `Kernel#puts` just
call `$stdin.gets` and `$stdout.puts`.

## Exercises

* Write a number guessing game. The computer should choose a number
  between one and 100. It should prompt the user for guesses. Each
  time, it will prompt the user for a guess; it will return too high
  or too low. It should track the number of guesses the player took
* REPL for RPN calculator
* Write a program that stores a restaurant review in a file. It can
  pull a restaurant review out of the file.
* Hangman: read in a dictionary downloaded from
  [here](http://wordlist.sourceforge.net/). Have the computer choose a
  word. Have the user guess letters one-by-one. Keep track of
  previously guessed letters, show them to the user. Draw a stick
  figure bit by bit until you lose
  (http://openbookproject.net/pybiblio/practice/wilson/hangman.php).
