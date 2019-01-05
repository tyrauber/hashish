# Mishmash

A ruby class for translating *complex* hashes to an alternate schema.

## Features

 * rename keys in a nested hash
 * condense an array of hash values to an array
 * return a hash from an array of hashes based on conditional attributes
 * return an array of hashes filtered by keys

## What? Why?

How do you translate an API response - or multiple responses from different APIs - to a single database schema? 

Mishmash.

## Methods

### hash = Mishmash.new({ "a" => 1 })

Mishmash new accepts and returns an input hash.

### hash.translate({ "a" = "b" })

An instance of Mishmash accepts a schema and returns an translated output.

> { "b" => 1 }

##  Examples

 * rename keys in a nested hash
 
```Ruby
> Mishmash.new({ "hash"=> {"a" => 1} }).translate({ "hash" =>{ "a" => "b" }})
=> {"hash" => {"b" => 1}}
```
 
 * condense an array of hash values to an array
 
 ```Ruby
 > Mishmash.new({
        "array" => [
          {"key" => "value 1"}, 
          {"key" => "value 2"}
          ]
  }).translate({
    "array" => {"key" => "array_of_values"}
  })

 => { "array_of_values" => ["value 1", "value 2"] }
 ```
 
 * return a hash from an array of hashes based on a condition

 ```Ruby
 > Mishmash.new({
       "array" => [
         {"option"=> "1", "value" => "X"},
         {"option"=> "2", "value" => "Y"}
       ]
     }
   }).translate({"array" => {"option" => "1", "value" => "key"}})

 => {"key" => "X"}
 ```


 * return an array of hashes filtered by keys

 ```Ruby
 > Mishmash.new({
       "array" => [
         {"option"=> "1", "value" => "X"},
         {"option"=> "2", "value" => "Y"}
       ]
     }
   }).translate({"array" => ["new_array", {"option" => "1", "value" => "key"}]})

 => {"new_array" => [{"key" => "X"}, {"key" => "y"}]}
 ```

## Inspection

Mishmash .translate() returns an Mishmash instance, allowing for additional translation. Useful for inspecting and navigating a response to determine and appropriate response.