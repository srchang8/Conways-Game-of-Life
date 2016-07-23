//
//  Protocols.swift
//  Assignment3
//
//  Created by Stephen Chang on 18/07/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

import Foundation


protocol GridProtocol : class {
    init(rows: Int, cols: Int)
    var rows : Int {get}
    var cols : Int {get}
    func neighbors(neighbor: (row : Int, col : Int)) -> [(row : Int, col : Int)]
    
    subscript(row: Int, column: Int) -> CellState { set get }
}

protocol EngineDelegate : class {
    func engineDidUpdate(withGrid: GridProtocol)
}

protocol EngineProtocol : class {
    var delegate : EngineDelegate? {set get}
    var grid : GridProtocol {get}
    var refreshRate : Double {set get}
    var refreshTimer : NSTimer {set get}
    var rows : Int {set get}
    var cols : Int {set get}
    init(rows: Int, cols: Int)
    func step() -> GridProtocol
}
