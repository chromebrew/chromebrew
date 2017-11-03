# Tests

## Why to run the tests

Running these tests will make sure that crew is working correctly, or explain the problem if it's not.

## When to run tests

The tests can be used at any time to help with developing, but make sure to run them before submitting a Pull Request.

## How to run the tests

Execute `ruby test_all`. If all tests pass, it will print `All tests successful.`, otherwise it will show what went wrong.

Running tests manually may not work!

## Preparing new tests

To prepare a new test, create a `.rb` file. It may use crew constants (created in `lib/const.rb`) and import packages (be sure to use `require_relative`).

It should finish normally if the test passed, or finish with `exit 1` otherwise, preferably explaining why the test failed.
All `.rb` files in this directory will automatically be run by the `all_tests` script.

Here is a simple example of a test:

```ruby
# Makes sure buildessential package depends on gcc

require_relative("../packages/buildessential")
pkg = Object.const_get('Buildessential')
if pkg.dependencies and pkg.dependencies.has_key?('gcc') then
	puts "Everything works properly.".lightgreen
else
	puts "Buildessential should depend on gcc!".lightred
end
```
