//  enum.swift


import Foundation
import UIKit

enum CellState : String {
    
    
    
    case Empty
    case Died
    case Born
    case Living
    func isLiving() -> Bool {
        switch self {
        case .Living, .Born: return true
        case .Died, .Empty: return false
        }
    }
    
        /* old code
    case Living = "Living", Empty = "Empty", Born = "Born", Died = "Died"
    
    
    //description should use a switch statement and return the raw value
    func descriptionMethod() -> CellState{
        switch self {
        case .Living:
            return Living
        case .Empty:
            return Empty
        case .Born:
            return Born
        case .Died:
            return Died
            
            //no default needed since there are only 4 possible cases as CellState
        }
    }
            */
    
    
    
    
    func allValues() -> Array<CellState>{
        
        var arrAllValues = Array(count:4, repeatedValue: CellState.Empty)
        
        arrAllValues[0] = CellState.Living
        arrAllValues[1] = CellState.Empty
        arrAllValues[2] = CellState.Born
        arrAllValues[3] = CellState.Died
        
        return arrAllValues
        
        //returns an array of all available values for the enum
        
    }
    
    
}

func toggle( value: CellState) -> CellState{
    
    var cellValue: CellState!//indicate that it could be nil
    
    if value == .Empty || value == .Died{
        cellValue = .Living
    }
    
    if value == .Living || value == .Born{
        cellValue = .Empty
    }
    
    return cellValue
}