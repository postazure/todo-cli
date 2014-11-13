# Todo - the (Ruby) CLI Edition

This exercise/assessment is used in the first couple of lessons where we focus
on applying Ruby.

Command line applications are pretty hard to test for reasons that are vague and
abstract:
  * standard in/out streaming
  * dependency injection

We have taken that pain away from you in this project. A class is written with
the application logic at `/lib/todos.rb`. The `run` method is where you should
add your logic.

There is only one test file. See your first test fail with `rspec`. Write the code
in `run` to make it pass. Change the `xit` test method to `it` to get the next
test failing. Pay attention to the failure message, and make it pass. Rinse and
repeat.

Command line version of the app can be run at any time from the root of the project
with `ruby todo_cli.rb`.

#### Gems

It only comes with the 'rspec' gem for testing. It also comes with files that
set the ruby version and the gemset. Once you pull down this project once, and
bundle gems, you shouldn't have to do it again. Your computer should just know
which Ruby and gemset to use.

## Getting Started

1. `bundle` to get your gems
2. Tests are written
3. CLI apps are hard to test. We have built a tiny stub of a class to help. Put your code in the Todos#run method!
4. run tests with `rspec` and make each one pass
5. run the command line app with `ruby todo_cli.rb`
