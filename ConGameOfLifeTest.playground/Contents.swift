//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//var before: [[Int]] = []

var after: [[Bool]] = []

arc4random()


class MyClass{
    
    var anArray:[[Int]]
    
init() {
    self.anArray = [[1,0,0], [0,1,0], [0,0,1]]
}

func dump() {
    for (i,row) in anArray.enumerate() {
        for (j,cell) in row.enumerate() {
            print("m[\(i),\(j)] = \(cell)")
        }
    }
}

}

let m = MyClass()
m.dump()

//before = [[1,2], [3,4], [5,6]]

var beforeBool: [[Bool]] = []

for i in 0...9 {
    for j in 0...9 {
        
    }
    
    
    
}

//class fun
var myString: String? = "a string"
myString = Optional.None
myString?.characters

//should the boxes be randome alive or dead and then check each box?

/*
 
 1. Create 10x10 multi dimensional array
 2. Fill array with random true or false, true for alive
 3. Create Method to check if cell should be alive or dead next round:
 
        a.
  Create another 10x10 array to track what happens to the cells from the first array
 
 
 
 */









var arr = Array(count: 5, repeatedValue: Array(count: 2, repeatedValue: 0))

//arr[0][0] =

//var before: [[Bool]] = []

var array: [[Int]] = []


var beforeArray = Array<Array<Bool>>()

//var foo = Array(count:2, repeatedValue: Array(count:2, repeatedValue:false))


/*
 
 if arc4random_uniform(3) == 1 {
 // set current cell to alive
 }
 */


//constant variable in case we want to change the size of game of life grid
let NumColumns = 10
let NumRows = 10

//create an array of type bool
var before = Array(count:NumColumns, repeatedValue: Array(count:NumRows, repeatedValue:false))

//set a random true or false value for each cell in the before array
for i in 0..<NumColumns{//iterate 0-9
    for j in 0..<NumRows{//iterate 0-9
        
        // if arc4random_uniform generates 1, then it will set cell to true
        if arc4random_uniform(3) == 1 {
            before[i][j] = true
            
        }
        //print(before[i][j]) print entire array to see if random variables generated correctly
    }
    
}



//print(before[1][1])

//print(arc4random_uniform(3))


/*
 var arr2 = Array(count: 10, repeatedValue: 1)
 
 for i in 0..<5{
 print("works")
 }
 */












