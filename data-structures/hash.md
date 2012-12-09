## Hash

A Hash is a collection of key-value pairs. You can think of a hash like an
array, but instead of the keys being incrementing integer indices (i.e., 0, 1,
2, 3, etc.), the keys are arbitrary, and can be any kind of object.

You can create a hash a couple different ways:

    empty_hash = Hash.new
    another_empty_hash = {}
    # This is the preferred way to make a Hash, and much easier as
    # well

    element_symbols = {:hydrogen => 'H', :helium => 'He', :lithium => 'Li'}
    element_weights = {:hydrogen => 1, :helium => 2, :lithium => 3}

Aside: the keys (e.g., `:hydrogen`, `:helium`, etc.) are of a Ruby data
type called Symbol. Think of them as immutable (i.e., can't be
changed) strings. Symbols are often used instead of hard-coded
strings, especially as keys for hashes.

***

We can look up a values in a hash by its key:

    element_symbols = {:hydrogen => 'H', :helium => 'He', :lithium => 'Li'}
    element_symbols[:hydrogen] # => 'H'
    
***
    
We can also *iterate* over the elements of the hash, just like we did
with array:

    element_symbols = {:hydrogen => 'H', :helium => 'He', :lithium => 'Li'}
    
    elements.each do |key, value|
      puts key
      puts value  
    end
    
    # => hydrogen
    #    H
    #    helium
    #    He
    #    lithium
    #    Li
    
    # Notice that when we iterate over a hash, each entry in the hash has both
    a key and a value.

***

We add a new key and value to a hash like so:

    element_symbols = {:hydrogen => 'H', :helium => 'He', :lithium => 'Li'}
    element_symbols[:beryllium] = 'Be'
    
    puts element_symbols
    # => {:hydrogen => 'H', :helium => 'He', :lithium => 'Li', :beryllium => 'Be'}

***

We can also merge two hashes together:

    hash1 = {:hydrogen => "H"}
    hash2 = {:helium => "He"}
    
    hash1.merge(hash2) # => {:hydrogen => "H", :helium => "He"}
    
Notice that `hash1.merge(hash2)` is the same as
`hash2.merge(hash1)`. `merge` does not modify either of the hashes, it
creates a new hash which contains the keys and values of both.

Like other *bang* methods, `hash1.merge!(hash2)` modifies hash1.

***

If we want to get all of the keys in a hash we can use the `keys`
method:

    element_symbols = {:hydrogen => 'H', :helium => 'He', :lithium => 'Li'}
    
    element_symbols.keys # => [:hydrogen, :helium, :lithium]

Notice that the return value of this method is an *array* of the
hash's keys.
    
***

Similarly, we can get all of the values in a hash by using the Hash#values method:

    element_symbols = {:hydrogen => 'H', :helium => 'He', :lithium => 'Li'}

    element_symbols.values # => ['H', 'He', 'Li']

***

We can check if a hash has a specific key by using the Hash#has_key? method:

    element_symbols = {:hydrogen => 'H', :helium => 'He', :lithium => 'Li'}

    element_symbols.has_key?(:hydrogen) # => true
    element_symbols.has_key?(:unobtanium) # => false

### Exercises

### Two sum

Previously, we wrote a method that found if an array had a pair of
elements that summed to zero. Let's improve our old version with one
that uses a hash.

One important difference between a hash and an array is that Hash's
`has_key?` method is much faster than array's `include?` method. Can
you use this fact to write a faster two sum solution?

Test your solution on a large array of ~1000 random elements.

### Resources
http://www.ruby-doc.org/core-1.9.3/Hash.html
