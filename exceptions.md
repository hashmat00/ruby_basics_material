# Exceptions

Things don't always work out the way you plan. Sometimes your code
will experience an error. Exceptions are the means of telling the
caller that your code can't do what was asked.

    def sqrt(num)
      raise ArgumentError.new "Cannot take sqrt of negative number" unless num >= 0
      
      # code to calculate square root...
    end

Since we can't take the square root of a negative number, we *raise*
an *exception* instead of returning an answer. When an exception is
raised, the method stops executing. Instead of returning, an exception
is thrown. The methods caller then gets a chance to handle the
exception:

    def main
      # run the main program in a loop
      while true
        # get an integer from the user
        puts "Please input a number"
        num = gets.to_i
        
        begin
          sqrt(num)
        rescue ArgumentError => e
          puts "Couldn't take the square root of #{num}"
          puts "Error was: #{e.message}"
        end
      end
    end

If the user feeds in a negative number, `sqrt` will raise an
exception. Because main has wrapped this code in a begin/rescue/end
block, the exception will be *caught*. The code will jump to the
rescue block that anticipates an `ArgumentError`. It will save the
exception in the variable `e`, then run this code.

If a method does not catch an exception, it continues to rise up the
*call stack*, to the method that called the method that raised the
exception. Each method in the call stack, in turn, gets an opportunity
to handle the exception.

If no method throughout the entire callstack catches the exception,
the exception is printed to the user and the program exits.

## Ensure

Sometimes there is important code that must be executed whether an
exception is raised or otherwise. In this case, we can use "ensure".

    begin
      a_dangerous_operation
    rescue StandardError => e
      puts "Something went wrong: #{e.message}"
    ensure
      puts "For better or worse, this program is over"
    end

## Exception Hierarchy

There are a number of predefined exception classes in Ruby. You can
find them [here][exceptions-classes]. You should try to choose an
appropriate class. One of the more common exceptions to use is
`ArgumentError`, which signals that an argument passed to a method is
invalid. `RuntimeError` is used for generic errors; this is probably
your other goto.

[exception-classes]: http://blog.nicksieger.com/articles/2006/09/06/rubys-exception-hierarchy

When creating an exception, you can add an error message so the user
knows what went wrong:

    raise RuntimeError.new("Didn't try hard enough")

If you want your user to be able to distinguish different failure
types, you can extend `StandardError` and write your own:

    class EngineStalledError < StandardError
    end
    class CollisionOccuredError < StandardError
    end
    
    def drive_car
      # engine may stall, collision may occur
    end
    
    begin
      drive_car
    rescue EngineStalledError => e
      puts "Rescued from engine stalled!"
    rescue CollisionOccuredError => e
      puts "Rescued from collision!"
    ensure
      puts "Car stopped."
    end

## Don't go crazy

Exceptions are a great tool for handling unexpected errors. But once
you have a hammer, you may find yourself starting to look for nails.

Writing durable, "hardened" code means thinking of everything that
could go wrong, watching out for those issues, and throwing an
exception in that case. For instance, when writing `sqrt`, we can
think ahead and recognize that negative numbers are a problem. So we
add code to check this, and throw an exception.

Likewise, durable code anticiaptes exceptions being thrown. It makes
sure that exceptions are handled properly. It avoids the program
crashing, if it is indeed possible for the program to carry on in
spite of the exception.

However, writing hardened code like this is time-intensive and
slow. There are always many, many things that could go wrong, and you
could spend a ton of time writing exception classes, raise errors,
making sure to catch them, etc.

For this reason, raise exceptions sparingly until you are hardening
writing a project. Focus on driving out the functionality first. And
don't waste your time imagining perverse scenarios; assume the
universe doesn't hate you. Just consider the things that could
reasonably go wrong. You can always add more exception-handling code
later.

Remember the maxim: *you ain't gonna need it*. Wait to implement
functionality when you need it, not when you anticipate it. Features
that aren't required yet take time away from more important
features. But more importantly, they are often poorly conceived,
because until you have a practical need for a feature, you're just
trying to imagine how that feature should work.

## Exercises
