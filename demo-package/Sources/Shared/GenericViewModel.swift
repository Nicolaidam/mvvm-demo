//
//  File.swift
//  
//
//  Created by Nicolai Dam on 13/05/2022.
//

import Combine
import Foundation
import SwiftUI

public protocol GenericViewModel: ObservableObject {
    
    associatedtype Action
    associatedtype Environment

    var environment: Environment { get }
    
    func trigger(_ action: Action)
}
