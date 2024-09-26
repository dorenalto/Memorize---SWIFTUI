//
//  Array+Only.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 26/09/24.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
