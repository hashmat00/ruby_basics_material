# Inheritance

Inheritance is a way to establish a subtype from an existing class in
order to reuse code. Let's look at an example:

    class Vehicle
      attr_accessor :hp, :torque

      def drive
        puts "Go!"
      end
    end

    class Car < Vehicle    
    end

Here we use '<' to denote that the `Car` class *inherits* from the
`Vehicle` class. That means that the `Car` class gets all of the
methods of the `Vehicle` class! We say that `Vehicle` is the *parent
class* or *superclass*, and that `Car` is the *child class* or
*subclass*. So we can write code like so:

    c = Car.new
    c.drive # => "Go!"
    c.hp = 40
    c.hp # => 40

But `Car` isn't restricted to the methods of the `Vehicle` class; it
can have its own methods; it can even *override* `Vehicle`'s methods!
Let's see this play out:

    class Car < Vehicle
      attr_accessor :make
      
      def drive
        puts "Vroom!"
      end
    end

We define getter and setter methods (that are not available on
`Vehicle`) for `make` with `attr_accessor`. Let's see what this leads
to:

    c = Car.new
    c.make = "DeLorean"
    c.make # => "DeLorean"
    v = Vehicle.new
    v.make = "DeLorean" # ERROR, undefined method 'make=' for Vehicle
    
    c.drive # => 'Vroom!' # Notice that drive makes the car say "Vroom!", not "Go!"
    

Note that **a class can only inherit from one superclass**.

The above example is a bit contrived; we say that inheritance helps us
reuse code, but don't get to see that in action. Imagine that we had
the following two classes:

    class Magazine
      attr_accessor :editor
    end
    
    class Book
      attr_accessor :editor
    end

We see code being duplicated: a bad sign. We can use inheritance to
solve this problem like so:

    class Publication
      attr_accessor :editor
    end
    
    class Magazine < Publication
    end
    
    class Book < Publication
    end

## Exercises

### Employee and Manager

Write a class `Employee` that has attributes that return the
employee's name, title, salary, and boss.

Write another class, `Manager`, that extends `Employee`. `Manager`
should have an attribute that holds an array of all employees assigned
to the manager. Add a method to assign a new employee to a manager; it
should set the employee's manager attribute and add the employee to
the manager's employee list. Note that managers can be assigned to
higher level managers, of course.

Add a method, `calculate_bonus(multiplier)` to `Employee`. Employees
should get a bonus like this

    bonus = employee salary * multiplier

Managers should get a bonus based on the salary of their whole team:

    bonus = (total salary of all employees and sub employees) * multiplier

## Credit

[Wikipedia: Inheritance](http://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming))
