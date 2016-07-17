//
//  enum.swift
//  Assignment3
//
//  Created by stephen chang on 7/10/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

import Foundation
import UIKit

enum CellState : String {
    
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
    
    
    func allValues() -> Array<CellState>{
        
       
        //returns an array of all available values for the enum
        return [.Empty,.Born,.Living,.Died]
        
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