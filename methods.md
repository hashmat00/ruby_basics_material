# Methods (Functions)

## What to learn

## Side-effects vs return values

In Ruby, **every method has a return value**. Sometimes, the return
value is meaningful, and sometimes it isn't (often the return value is
`nil` in this case). Let's take a look at a few examples to see how
this plays out:
  
Here's an example of a method that returns the square of a
number:
  
    def square(num)
      num * num
    end

Notice that there we don't say `return num * num` (an *explicit
return*). Ruby has *implicit returns*, that is, **the last evaluated
expression in a method is the return value of that method**. Because
of implicit returns, we only use explicit returns when we want an
early return, such as in the following method:

    def go_home
      return unless can_go_home? && wants_to_go_home?
      pack_bags!
      get_tickets!
      board_plane!
    end
    # See [this post](http://www.themomorohoax.com/2009/02/09/ruby-tip-return-early) for more on this example and why you might want to do this.

Often, however, we have methods that we just use for their
side-effects. When we say side-effect, we mean some sort of
modification to a non-local variable or some sort of observable
interaction with calling methods or the outside world. See the
article on [scope](#) for a more in-depth explanation, but
essentially, by *local scope* we mean the internal world of the
method, where variables live only for the duration of the method.

A great example of a method that is used just for its side-effects
is `each`. `each` returns the original array (which provides no new
information and is therefore not terribly useful) and thus is used
exclusively for its side-effects.

## Single Responsibility Principle (extended to methods)

**Each method should have a single purpose.** This purpose should be
fully realized in the method. 

This has multiple benefits. Your code communicates its intent more
clearly, and therefore becomes easier to read. Maybe most importantly,
it becomes easier to change and/or extend your code. Because each
method is atomic, and *loosely coupled* (a method has little/no
knowledge of other methods), a change will only impact one method, and
not cause other methods to break.

## Naming methods

**In a nutshell: use descriptive, consistent naming.**

The better your naming, the easier it will be to refactor, extend and
maintain your code. Naming may seem more a matter of style than
anything, but it is in fact a significant determinant of code quality.

Steve McConnell's [Code Complete](http://www.amazon.com/Code-Complete-Practical-Handbook-Construction/dp/0735619670/ref=sr_1_1?ie=UTF8&qid=1352335156&sr=8-1&keywords=code+complete) gives a few good guidelines that should help with method naming:

**Describe everything a method does**
And I mean everything. If your method name becomes too long, your
method does too much.

**Avoid meaningless, vague, or wishy-washy verbs**
Some verbs have broad meanings, and don't provide much information.
Method names such as `handle_calculation`, `perform_services`,
`process_input` or `deal_with_output` don't tell you much about what
the methods do. If you find yourself forced to give your method a
vague name because you can't think of one that encapsulates all that
the method does, your method may be doing too many things.

**Make names as long as necessary**
It's hard to give hard numbers, but names in the 15 - 20 character
range are perfectly fine. This is a very rough guideline, but as a
beginner, perhaps some guidance is useful!

**For methods that have no side-effects (i.e., the return value of the method describes the purpose of the method), try using a description of the return value**
For example, method names such as `cosine` and `square_root` are
good names that explain exactly what the method returns.
  
**For methods that do have side-effects, try using a verb followed by a noun**
A couple good examples here are `print_document` and `deposit_funds`.

**Establish conventions for common operations**
If there is a prevailing convention for a common operation, defer to
it. If not, enforce consistency in your own codebase. For example,
don't have different ways of getting an object's id: `supervisor.id`
and `employee.get_id`.
***

A few Ruby-specific guidelines:

* Use snake_case (not CamelCase) when naming methods (and variables)

* Methods that return a boolean value (i.e. `true` or `false`) should
  end with a question mark (e.g., Array#empty?)

* Methods that are potentially 'dangerous' (e.g., because they modify
  the calling object or arguments) should end with an exclamation mark
  (e.g., Array#map!)

## Exercises

* Implement a Rock, Paper, Scissors game. The method `rps` should take
  either a string (either "Rock", "Paper" or "Scissors") as a
  parameter and return the computer's choice, and the outcome of the
  match. Example:
  
    rps("Rock") # => "Paper, Lose"
    rps("Scissors") # => "Scissors, Draw"
    rps("Scissors") # => "Paper, Win"
    
* Implement a Swingers game. The method `swingers` should take an
  array of couple arrays and return the same type of data structure,
  with the couples mixed up. Assume that the first item in the couple
  array is a man, and the second item is a woman. Don't pair a person
  with someone of their own gender (sorry to ruin your fun). An
  example input:
  
    swingers([
    ["Clyde, Bonnie"]
    ["Paris, Helen"]
    ["Romeo", "Juliet"]
    ])

## Resources
[Wikipedia: Single Responsibility Principle](http://en.wikipedia.org/wiki/Single_responsibility_principle)
[Wikipedia: Side effect]http://en.wikipedia.org/wiki/Side_effect_(computer_science)
[StackExchange answer on side effecs](http://programmers.stackexchange.com/questions/40297/what-is-a-side-effect#answer-40314)
[Curly's Law](http://www.codinghorror.com/blog/2007/03/curlys-law-do-one-thing.html)

## Credit
Some exercises adapted from [RubySource](http://rubysource.com/ruby-golf/)
