//: Playground - noun: a place where people can play
// Stephen Chang Bonus Assignment 5

import UIKit


func isLeap(year:Int) ->  Bool
{
    return year % 400 == 0 ? true : (year % 100 == 0 ? false : (year % 4 == 0 ? true : false))
}



func julianDate(year: Int, month: Int, day: Int) -> Int
{
    var arr = [Int]()
    arr += 1900...year
    
    return arr.map { (number) -> Int in return isLeap(number) ? 366 : 365 }.reduce(0, combine: +) + ((month == 5 || month == 7 || month == 10 || month == 12) ? 30 : ((month == 3 ? (isLeap(year) ? 29 : 28) : (month == 1 ? 0:31)))) + day + (year == 1900 ? -365 : 0)
}