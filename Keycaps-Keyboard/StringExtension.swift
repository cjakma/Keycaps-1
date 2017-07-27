//
//  StringExtension.swift
//  Keycaps
//
//  Created by Richard Rissanen on 7/27/17.
//  Copyright © 2017 Screen Sized. All rights reserved.
//

import UIKit

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
