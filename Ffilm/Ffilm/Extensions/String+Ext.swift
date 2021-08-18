//
//  String+Ext.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 6.08.2021.
//

import Foundation

extension String {
    func replaceSpecialCharacters() -> String {
        var result = self
        result = result.replacingOccurrences(of: "ş", with: "s")
        result = result.replacingOccurrences(of: "Ş", with: "S")
        result = result.replacingOccurrences(of: "İ", with: "I")
        result = result.replacingOccurrences(of: "ı", with: "i")
        result = result.replacingOccurrences(of: "Ö", with: "O")
        result = result.replacingOccurrences(of: "ö", with: "o")
        result = result.replacingOccurrences(of: "Ü", with: "U")
        result = result.replacingOccurrences(of: "ü", with: "u")
        result = result.replacingOccurrences(of: "Ğ", with: "G")
        result = result.replacingOccurrences(of: "ğ", with: "g")
        result = result.replacingOccurrences(of: "Ç", with: "C")
        result = result.replacingOccurrences(of: "ç", with: "c")
        result = result.replacingOccurrences(of: " ", with: "-")
        return result
    }

    func convertToDate() -> String {
        var result = ""
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        result = dateFormatter.string(from: date ?? Date())
        return result
    }

    func getDateYear() -> String {
        var result = ""
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy"
        result = dateFormatter.string(from: date ?? Date())
        return result
    }
}
