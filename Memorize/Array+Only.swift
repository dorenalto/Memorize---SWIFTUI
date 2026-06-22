//
//  Array+Only.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
