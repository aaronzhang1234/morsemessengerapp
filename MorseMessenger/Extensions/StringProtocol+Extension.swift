//
//  StringProtocol+Extension.swift
//  MorseMessenger
//
//  Created by Aaron Zhang on 1/31/21.
//

import Foundation

extension StringProtocol{
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
