# Serialization

Ruby objects live within the context of a Ruby program. You cannot
directly read/save a Ruby object from/to disk (perhaps for later
reuse), nor send it to another computer.

To do this you need to convert the Ruby object into a representation
that can be saved to disk or sent over a network. This process is
called *serialization*.

There are many, many serialization *formats*, or ways of representing
data. Probably the most important in the web world is JSON:

    { "fieldA": "valueA",
      "fieldB": [1, 2, 3] }

JSON supports a few primitive forms of data: numbers, strings, arrays
and hashes. It is descended from JavasScript, and is commonly used as
the message format for web APIs.

You can easily serialize basic Ruby objects to a JSON string:

    require 'json'
    { "a" => "always",
      "b" => "be",
      "c" => "closing" }.to_json
    => '{"a":"always","b":"be","c":"closing"}'
    JSON.parse('{"a":"always","b":"be","c":"closing"}')
    => {"a"=>"always", "b"=>"be", "c"=>"closing"}

JSON doesn't do know how to serialize more complicated classes though:

    Cat.new("Breakfast, 8, "San Francisco").to_json
    => '"#<Cat:0x007fb87c81b398>"'

You can fix this somewhat by defining a `to_json` method on your
classes, but that involves you writing custom serialization code. It
will also be a pain to do the opposite translation.

## YAML

YAML is meant to solve the problem of saving custom classes. Here's a
YAML representation of our cat:

    --- !ruby/object:Cat
    name: Breakfast
    age: 8
    location: San Francisco

Notice that YAML has saved the instance variables of the object, as
well as recording the class of object that was saved. Serializing to
and from YAML is a cinch:

    require 'yaml'
    cat = Cat.new("Breakfast", 8, "San Francisco")
    
    # serialize and save to cat.yaml file
    File.write("cat.yaml", cat.to_yaml)
    
    # read cat.yaml file and deserialize the object
    cat2 = YAML::load(File.read("cat.yaml"))

Note that `cat` and `cat2` are different objects; serialization and
deserialization are sometimes used as a poor man's "clone".

JSON is the dominant serialization technology on the web (XML is a
close second), but YAML is the leader in the Ruby world because of its
better support for class tagging.

## Exercises

Extend your course curriculum application to serialize and deserialize
data across program loads.

## References
