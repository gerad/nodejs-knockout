# CoffeeScript's operations should be chainable, like Python's.
ok 500 > 50 > 5 > -5

ok true is not false is true is not false

ok 0 is 0 isnt 50 is 50

ok 10 < 20 > 10

ok 50 > 10 > 5 is parseInt('5', 10)


# Make sure that each argument is only evaluated once, even if used
# more than once.
i = 0
func = -> i++

ok 1 > func() < 1


# `==` and `is` should be interchangeable.
a = b = 1

ok a is 1 and b is 1
ok a == b
ok a is b


# Ensure that chained operations don't cause functions to be evaluated more
# than once.
val = 0
func = -> val = + 1

ok 2 > (func null) < 2
ok val is 1


# Allow "if x not in y"
obj = {a: true}
ok 'a' of obj
ok 'b' not of obj

# And for "a in b" with array presence.
ok 100 in [100, 200, 300]
array = [100, 200, 300]
ok 100 in array
ok 1 not in array

list = [1, 2, 7]
result = if list[2] in [7, 10] then 100 else -1
ok result is 100

# And with array presence on an instance variable.
obj = {
  list: [1, 2, 3, 4, 5]
  in_list: (value) -> value in @list
}
ok obj.in_list 4
ok not obj.in_list 0

# Non-spaced values still work.
x = 10
y = -5

ok x*-y is 50
ok x*+y is -50


# Half-operators.
one = two = null
one = or 1
two = or  2

ok one is 1
ok two is 2

one = and 'one'
two = and  'two'

ok one is 'one'
ok two is 'two'
