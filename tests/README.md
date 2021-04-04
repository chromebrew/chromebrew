# Tests

## Why to run tests

Running tests will make sure that crew is working correctly or explain the problem if it's not.

## When to run tests

The tests can be used at any time to help with development but make sure to run them before submitting a Pull Request.

## Preparing new tests

To prepare a new test, create a ruby script. It may use crew constants (created in `lib/const.rb`) and import packages (be sure to use `require_relative`).

It should finish normally if the test passed, otherwise abort with `exit 1` and preferably explain why the test failed.

A simple example of a test script called `my_test` is below:

```ruby
#!/usr/bin/env ruby

# Makes sure buildessential package depends on gcc

require_relative("../packages/buildessential")
pkg = Object.const_get('Buildessential')
if pkg.dependencies and pkg.dependencies.has_key?('gcc') then
	puts "Everything works properly.".lightgreen
else
	puts "Buildessential should depend on gcc!".lightred
	exit 1
end
```
Make sure the script is executable with `chmod +x my_test`. Note: This will only work in directories with execute permission.

## How to run tests

Execute `ruby my_test` from this directory (`tests/`). If all tests pass, it should display a message similar to `All tests successful.`, otherwise it should indicate what went wrong.

Running tests manually may not work!
