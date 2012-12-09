# Scope

Scope is the context in which a variable name is valid and can be used.

A name is *in scope* (accessible) if

- the name is defined in the current method (called a *local variable*), OR
- the name is defined at the same or higher level of the current method

In the example below, we are able to call `age_cat_one_year` from
`main` because it is defined at the same level as `main`. Therefore,
`age_cat_one_year` and `main` are in the same scope. 

We can't call `cat.age` inside `age_cat_one_year` because `cat` is not
available at the top-level scope, but only inside the `main` method.

    def main
      cat_name = gets
      cat_age = gets.to_i # convert input to integer
    
      # local variables were defined at the same level we're using them here
      cat = Cat.new(cat_name, cat_age)
      
      age_cat_one_year # WORKS: age_cat_one_year is defined at the same level as main
      puts "#{cat.name} is now #{cat.age}"
    end
    
    def age_cat_one_year
      cat.age += 1 # ERROR: can't use a variable declared in another method
    end

Variable definitions aren't visible at higher level scopes. In the
below example, `cat_age` is defined in `extract_cat_age` and not
available at the top-level scope.

    # defines a cat variable name in the global scope
    cat = {
      :name => "Breakfast",
      :age => 8
    }
    
    def extract_cat_age
      # creates a new local variable _inside this method_
      # won't add variable to global scoope
      
      cat_age = cat[:age]
    end
    
    extract_cat_age
    cat_age # ERROR: variable out of scope

## Exercises

## Credit

[Wikipedia: Scope](http://en.wikipedia.org/wiki/Scope_(computer_science))
