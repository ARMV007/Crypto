//
//  String.swift
//  ARMVCrypto
//
//  Created by Abhishek on 04/11/24.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
