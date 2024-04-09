def makeCounter(): () => Int = {
  var count = 0 // Variable in the lexical scope of the closure

  // Define and return a closure
  () => {
    count += 1 // Accesses and modifies the variable 'count'
    count     // Returns the updated count
  }
}

// Create a counter function using the makeCounter function
val counter = makeCounter()

// Call the counter function multiple times
println(counter()) // Outputs: 1
println(counter()) // Outputs: 2
println(counter()) // Outputs: 3
