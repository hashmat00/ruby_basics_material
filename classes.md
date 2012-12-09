# Objects and Classes

## Packaging data in Hashes

It's common to have sets of related data. For instance, a cat has a
name, age, and home city. We could store these three values in three
different variables:

    cat_name = "Breakfast"
    cat_age = 8
    cat_home_city = "San Francisco"

What if we want to work with two cats? Clearly it would get messy to
have six variables: `cat1_name`, `cat2_name`, `cat1_age`, ...

One solution is to use aligned arrays:

    cat_names = ["Breakfast", "Earl"]
    cat_ages = [8, 2]
    cat_home_cities = ["San Francisco", "San Francisco"]

Here all the values at position 0 correspond to one cat, all the
values at position 1 correspond to the second cat.

This is a tedious and unpleasant solution; we have to be careful that
we don't mix up the different positions in the array. And what if we
want to pass just one cat to a method? We have to pull all the data
for one cat out of the three arrays, then pass it to the method in
three variables.

*Avoid aligned arrays*; you will rarely want to do this. Instead,
collect data in hashes:

    cat = {
      :name => "Breakfast",
      :age => 8,
      :home_city => "San Francisco"
    }

All the related values for a single cat are stored in one object,
which is itself saved to a single variable. One hash represents one
cat. You can easily pass around the hashes.

When you have multiple objects -- say multiple cats -- store them in
an array:

    cats = [{
      :name => "Breakfast",
      :age => 8,
      :home_city => "San Francisco"
    }, {
      :name => "Earl",
      :age => 2,
      :home_city => "San Francisco"
    }]

Now each object in the array is a hash representing a cat.

*Protip*: don't proliferate variables. Having more variables means
more possibility for errors. Example: in the aligned array example, we
had three arrays stored in three variables. To delete a cat we need to
remember to delete the field from each array. And if we forget to do
so, the arrays will become misaligned.

With the one array, we just delete the one hash from the array.

*Use a hash to collect variables that go together.*

## Use classes to add methods

As we've seen, we can use a Hash to represent data. To actually do
things with that data, we need a method:

    def age_one_year(cat)
      cat[:age] += 1
    end

This will work, at least until we have two things that can age:

    def age_one_year(house)
      house[:age] += 1
      house[:value] = 1.07 * house[:value] # house appreciates in value
    end

Uh-oh, two different types of things can `age_one_year`; we want two
different methods, but they'd have the same name. We could solve this
by creating two different methods:

    def age_cat_one_year(cat)
      #...
    end
    def age_house_one_year(house)
      #...
    end

Ugh; too verbose. Instead, we can define a *class*, which is a way to
represent both data, and methods to modify that data. In technical
jargon, we would say that classes combine *state* (data, fields) and
*behavior* (methods).

## Our first class

### Class vs Instance

Let's define a class to represent our cat. Ruby predefines many
built-in classes (`String`, `Array`, `Hash`); by defining a class
ourselves, we add a new object type which will represent a
cat. *Instances* (an occurence of an object) of this `Cat` class
represent individual cats. Two `Cat` instances will share the same set
of attributes (state) and methods; they may contain different
attribute values, however.

    # Cat is our class; the type of thing we are creating
    # cat1 holds an instance of Cat representing a cat named Breakfast
    cat1 = Cat.new("Breakfast", 8, "San Francisco")
    # cat2 holds another instance of Cat representing a cat named Earl
    cat2 = Cat.new("Earl", 2, "San Francisco")

Check out the class type of your favorite Ruby objects:

    > "my string".class
    => String

Now you try in irb with arrays, hashes, etc!

### `initialize` and `new`

Here's the start of our cat class:

    class Cat
      def initialize(name, age, location)
        # save variables...
      end
      
      # more methods here...
    end

To begin defining the class `Cat`, we start with the keyword class and
then the class name. Note that class names are always capitalized and
CamelCase.

Between the class name and the `end`, all methods defined in this
block of code will be `Cat` methods.

The `initialize` method is special. It is called when an object is
first created. To create a `Cat` object, we write:

    Cat.new("Breakfast", 8, "San Francisco")

Every class has a `new` 'class method' (a method called on a class,
instead of an object); the `new` method creates a new object and then
calls the `initialize` method, passing the arguments given to
`new` on to `initialize`.

The `initialize` method is responsible for setting up the object. For
`Cat`, we store the vital cat data. The `initialize` method should
take enough arguments so that it can fully setup the initial state of
the `Cat` so that the `Cat` object we get back is fully functional and
ready-to-go. Don't write code like this:

    # ugly; too many lines; have to write 3 lines every time we want
    # to create a new cat; what if I forget some fields?
    cat1 = Cat.new
    cat1.name = "Breakfast"
    cat1.age = 8
    cat1.home_city = "San Francisco"

### Instance Methods

Instance methods define the behavior to be exhibited by instances of
the associated class. A class defines the behavior of the instance
methods, which is common to all instances of the class.

    class Cat
      # ...
      
      def speak
        puts "Meow!"
      end
    end

    cat1 = Cat.new("Breakfast", 8, "San Francisco")
    cat2 = Cat.new("Earl", 2, "San Francisco")
    cat1.speak # Breakfast speaks
    cat2.speak # Earl speaks

Notice that to call a method, we first give the instance, then a '.',
then the name of the method.

An instance method can interact with the instance's state, which means
that calling the same method on different instances can end up doing
different things. To see how this works, we're going to need to learn
about storing object state in instance variables first.

### Instance variables

Object state is stored in *instance variables*. Instance variable
names are prefixed with an ampersand ('@'). Each object instance has
its own separate copies of the instance variables. The variables are
stored for the life of the object. Just like we store information in a
Hash under a key, we can set and lookup data with an instance variable
name.

    class Cat
      def initialize(name, age, location)
        # save the passed in values to instance variables so that we
        # can use them later.
        @name = name
        @age = age
        @location = location
      end

      # ...
    end

Instance variables are only directly accessible from inside the
object. This protects them from being exposed to the outside world. If
we do want to share them with other objects, we need to define
*setter* and *getter* methods:

    class Cat
      # ...
    
      # a *getter* method that pulls out the cat's name stored in the
      # @name instance variable. `name` is the method; `@name` is the
      # instance variable
      def name
        @name
      end
      
      # a *setter* method; method names that end with an '=' can be
      # used like this: `cat.name = "Fluffy II"`
      def name=(name)
        @name = name
      end
    end

Because setter and getter methods are so common and tedious, Ruby
gives us an easy way to define these:

    class Cat
      # attr_accessor is a class method that adds getters and setters
      # for the age and location variables
      attr_accessor :age, :location

      # attr_reader adds just a getter; looks like a cat shouldn't be
      # renamed
      attr_reader :name

      def initialize(name, age, location)
        # ...
      end
      
      # ...
    end

## Class and Instance methods

We've mostly talked about instance methods; instance methods are
defined at the class level, but they are called on an instance of a
class. Depending on the instance's state (its instance variables), the
same instance method may do different things when called on different
instances.

Class methods are not called on instances of the class; they are
called on the class itself. The most prominent example we have seen is
the `new` method:

    cat = Cat.new # call Cat's class method `new`
    cat.speak # call Cat's instance method `speak` on cat

Since class methods are not called on an object, they are not specific
to any one object. For that reason, they cannot access instance
variables; there is no object to get the instance variables from.

A common use of class methods is to create new objects (this is what
`new` does); methods that create new objects are called *factory
methods*.

When we want to be clear whether a method `meow` or `new` is an
instance or class method of `Cat`, we write `Cat#meow` and `Cat::new`
respectively.

## self

Methods may call other methods:

    class Cat
      def meow
        puts "Meow"
      end
      
      def hiss
        puts "Hiss"
      end
      
      def throw_fit
        # meow and hiss a lot
        self.meow
        self.hiss
        self.meow
      end
    end

Notice that `throw_fit` calls `self.meow` and `self.hiss`. Here,
`self` is a special variable that refers to the object the method is
called on. Using the special variable `self`, we can call methods with
the usual dot notation.

Ruby lets the user drop (or *elide*) the `self.` part when calling a
method. By default, the method will be called on `self`:

    def throw_fit
      # meow and hiss a lot
      meow
      hiss
      meow
    end

This is the preferred way to do things in Ruby.

## Defining class methods

Let's see how to define a class method. There are in fact a few ways,
but this is the most commonly used:

    class Dog
      def self.dog_years_to_human_years(age)
        age / 7.0
      end
    end
    
Though this is the preferred way, you'll also see it written this way.

    class Dog
      class << self
        def dog_years_to_human_years(age)
          age / 7.0
        end
        
        def human_years_to_dog_years(age)
          age * 7.0
        end
      end
    end

You may see this particularly when defining multiple class methods
together.

## Calling class methods from class methods

We've seen that we can call instance methods from other instance
methods. We can do the same for classes:

    class Dog
      def self.dog_years_to_human_years(age)
        age / 7.0
      end
      
      def self.human_years_to_dog_years(age)
        age * 7.0
      end
      
      def self.human_to_dog_ratios
        # get the equivalent of one dog or human year in terms of the
        # other
        dog_to_human_ratio = self.dog_years_to_human_years(1)
        human_to_dog_ratio = self.human_years_to_dog_years(1)

        { :dog_ratio => dog_to_human_ratio,
          :human_ratio => human_to_dog_ratio }
      end
    end

Notice the use of `self`. Because `human_to_dog_ratios` is called on
the `Dog` class, `self` returns the `Dog` class, the methods
`dog_years_to_human_years` and `human_years_to_dog_years` are then
called on the `Dog` class.

`self` always returns the object that the method is called on. But
isn't `Dog` a class and not an object? It's both! Everything in Ruby
is an object, even classes. Just like `Dog` objects are instances of
the `Dog` class, the `Dog` class is an instance of Ruby's `Class`
class.

As mentioned, we can get a class object by using the `.class` method:

    dog = Dog.new("August", 6, "Chicago")
    dog.class # => Dog
    dog.class.class #=> Class

Finally, note that class methods are just a special kind of instance
method:

    dog.bark # => calls `bark` method on a Dog instance
    Dog.new # => calls `new` method on a Class instance: Dog

## Exercises

* Translate a program from hashes to objects
 * Student has several personal fields: name, age, year
 * Each student has several Courses that they take
 * there's a method `add_course(student, course)`
   * change this to `student.add_course(course)`
   * do not allow a student to add a course that conflicts with an
     existing course.
 * Course has an professor, department, class days and times
 * Student has a method `schedule` that prints the schedule
 * Course has a method `conflicts_with?(course)` which says if two
   courses overlap

* Write a tic-tac-toe game
 * Abstract out a player class; choose 1, 2 or zero players
 * Computer AI will make a winning move if available; else move
   randomly

## References
