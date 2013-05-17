[![Build Status](https://travis-ci.org/alainravet/cattr_reader_preloaded.png?branch=master)](https://travis-ci.org/alainravet/cattr_reader_preloaded) -
[![Code Climate](https://codeclimate.com/github/alainravet/cattr_reader_preloaded.png)](https://codeclimate.com/github/alainravet/cattr_reader_preloaded)
tested with Ruby (1.8.7, 1.9.3, and 2.0.0), JRuby(1.8 and 1.9 mode), and Rubinius(1.8 and 1.9 mode) - see [.travis.yml](.travis.yml)

##TL;DR
Precompute asynchronously a value when the file is loaded, not on the 1st call.
```ruby
require 'cattr_reader_preloaded'

cattr_reader_preloaded :gem_names do
  `gem list --no-version`  # <<< SLOW
end
```
---------------

##Problem : 
Some operations are very slow the 1st time you perform them, even when this takes place long after the program was started.
Memoization will only speed up the 2nd and later calls.

Example : this operation
```ruby
def gems_names
  @@_gems_names ||= `gem list --no-version`  # <<<
end
```
is slow :

```ruby
sleep 10 # simulates the program running for a while.

3.times do
  start = Time.now
  gems_names  # <<< the slow operation
  puts "%.4f" % (Time.now - start)
end
```
```
1.6710  : 1st call = slow
0.0000  : 2nd call = fast (memoized)
0.0000  : 3rd call = fast (memoized)
```

##Solution : 

This gem adds a ```cattr_reader_preloaded``` method to ```Kernel``` that starts precomputing - asynchronously the value as soon as the file (class or module) is loaded by Ruby


```ruby
# replace
#   def gems_names
#     @@_gems_names ||= `gem list --no-version`
#   end
# by
require 'cattr_reader_preloaded'

cattr_reader_preloaded  :gem_names do
  `gem list --no-version`  # <<< SLOW
end
```
and the result is now
```
0.0000
0.0000
0.0000
```


## Installation

Add this line to your application's Gemfile:

    gem 'cattr_reader_preloaded'

And then execute:

    $ bundle

## Contributing

0. Respect the code style and formatting.
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
