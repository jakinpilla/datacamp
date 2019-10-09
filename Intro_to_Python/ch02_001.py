# Python list...

[1+2, "a"*5, 3]

# list of list....

# Subsetting list...

# Create the areas list
areas = ["hallway", 11.25, "kitchen", 18.0, "living room", 20.0, "bedroom", 10.75, "bathroom", 9.50]

# Print out the area of the living room
print(areas[5])

# Sum of kitchen and bedroom area: eat_sleep_area
eat_sleep_area = areas[3] + areas[-3]

# Print the variable eat_sleep_area
print(eat_sleep_area)


# Use slicing to create downstairs
downstairs = areas[:6]
downstairs

# Use slicing to create upstairs
upstairs = areas[6:10]
upstairs


# Alternative slicing to create upstairs
upstairs = areas[6:]
upstairs

x = [["a", "b", "c"],
     ["d", "e", "f"],
     ["g", "h", "i"]]


x[2][0]

x[2][:2]



house = [["hallway", 11.25], 
          ["kitchen", 18.0], 
          ["living room", 20.0], 
          ["bedroom", 10.75], 
          ["bathroom", 9.50]]

house[-1][1]


# Manipulating Lists....

# del()

x = ['a', 'b', 'c']
y=x
y[1] = 'z'

y
x


x = ['a', 'b', 'c']
y = list(x)
y

y[1] = 'z'
y
x

x = ['a', 'b', 'c']
y = x[:]
y

y[1] = 'z'
y
x

# Create the areas list
areas = ["hallway", 11.25, "kitchen", 18.0, "living room", 20.0, "bedroom", 10.75, "bathroom", 9.50]

# Correct the bathroom area
areas[-1] = 10.50
areas

# Change "living room" to "chill zone"
areas[4] = "chill zone"
areas

# Add poolhouse data to areas, new list is areas_1
areas_1 = areas + ["poolhouse", 24.5]

# Add garage data to areas_1, new list is areas_2
areas_2 = areas_1 + ["garage", 15.45]

# As soon as you remove an element from a list, the indexes of the elements that 
# come after the deleted element all change!







