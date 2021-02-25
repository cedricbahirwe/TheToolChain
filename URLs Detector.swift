//
//  URLs Detector.swift
//  
//
//  Created by Cédric Bahirwe on 25/02/2021.
//

import Foundation

let input = "This is a test with the URL https://www.hackingwithswift.com to be detected."
let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))

for match in matches {
    guard let range = Range(match.range, in: input) else { continue }
    let url = input[range]
    print(url)
}
