//
//  TextElement.swift
//  work_9
//
//  Created by Stanislav Belsky on 5/24/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct TextElement {
    
    let string: String
    var value: Any{
        tryParse()
    }
    
    let stringDate1 = #"^[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])"#
    let stringDate2 = #"^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"#
    let stringDate3 = #"^[0-9]{4}.(0[1-9]|1[012]).(0[1-9]|1[0-9]|2[0-9]|3[01])"#
    let stringDigit = #"^\-?\d+(\.\d{0,})?$"#
    
    
    init(_ string: String) {
        self.string = string
    }
    
    func tryParse() -> Any{
        
        do {
            
            let regexDate1 = try NSRegularExpression(pattern: stringDate1)
            let resultsDate1 = regexDate1.matches(in: string, range: NSRange(string.startIndex..., in: string))
            let date1Strings = resultsDate1.map{ String(string[Range($0.range, in: string)!]) }
            if let dateString = date1Strings.first{
                return Util.dateFromString(string: dateString, format: "yyyy-MM-dd") ?? string
            }
            
            let regexDate2 = try NSRegularExpression(pattern: stringDate2)
            let resultsDate2 = regexDate2.matches(in: string, range: NSRange(string.startIndex..., in: string))
            let date2Strings = resultsDate2.map{ String(string[Range($0.range, in: string)!]) }
            if let dateString = date2Strings.first{
                return Util.dateFromString(string: dateString, format: "dd/MM/yyyy") ?? string
            }
            
            let regexDate3 = try NSRegularExpression(pattern: stringDate2)
            let resultsDate3 = regexDate3.matches(in: string, range: NSRange(string.startIndex..., in: string))
            let date3Strings = resultsDate3.map{ String(string[Range($0.range, in: string)!]) }
            if let dateString = date3Strings.first{
                return Util.dateFromString(string: dateString, format: "dd.MM.yyyy") ?? string
            }
            
            let regexDigit = try NSRegularExpression(pattern: stringDigit)
            let resultsDigit = regexDigit.matches(in: string, range: NSRange(string.startIndex..., in: string))
            let digitStrings = resultsDigit.map{ String(string[Range($0.range, in: string)!]) }
            if let dateString = digitStrings.first{
                return Double(dateString) ?? string
            }
            
        } catch let error {
            print(error)
        }
        
        return string
    }
    
    func translate(with locale: Locale) -> String {
        
        if let digit = value as? Double{
            let mass = Measurement(value: digit, unit: UnitMass.kilograms)
            let formatter = MeasurementFormatter()
            formatter.locale = locale
            return formatter.string(from: mass)
        }
        
        if let date = value as? Date{
            let dateFormatter = DateFormatter()
            dateFormatter.locale = locale
            dateFormatter.dateFormat = "dd.MMMM.yyyy"
            return dateFormatter.string(from: date)
        }
        
        return string
    }
    
}
