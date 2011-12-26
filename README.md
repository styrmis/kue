###Kue

Kue is a Rails ready key value store that uses active-record under the hood.

###Build Status

[![Build Status](https://secure.travis-ci.org/dotnetguyuk/kue.png)](https://secure.travis-ci.org/dotnetguyuk/kue)

###What does Kue mean?
K(eyVal)ue 

###What about real key value stores?
Redis is awesome! But sometimes you just don't want or need the external dependancy!

### How do I install Kue?
Install the gem

    gem install kue (command line)
    gem 'kue'       (gemfile)

Run the generator

    rails generate kue:install
    rake db:migrate

### Use Kue
Set a key and it's value.

```ruby
KueStore[:any_key_name_you_can_think_of] = "Any object you can dream up"
```

Get a value by key.

```ruby
KueStore[:any_key_name_you_can_think_of] 
```

Don't worry it's not just string value's kue can store for you. It's anything!

```ruby
KueStore[:my_class_instance] = Foo.new(:name => 1)
```

Find out if a key exists?

```ruby
KueStore.exists?(:my_class_instance)
```

Delete a key and it's value

```ruby
KueStore.delete!(:my_class_instance)
```

List all the keys in the KueStore

```ruby
KueStore.keys
```

Clear all keys and values from the KueStore

```ruby
KueStore.clear!
```

Get a count of all the key/value pairs

```ruby
KueStore.count
```

###Don't like the KueStore class name?

No problem. Just include the Kue::Store module inside of your own class.

```ruby
class MyStore < ActiveRecord::Base
  include Kue::Store
end

MyStore[:all_good] = 1
```


