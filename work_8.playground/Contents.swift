import UIKit

let testStrings = ["877670372290", "467732791708", "1773250715", "3002239199","1002239199"]

func isValinINN(_ inn: String) -> Bool{
    
    let range = NSRange(location: 0, length: inn.utf16.count)
    let regex = try! NSRegularExpression(pattern: "[0-9]")
    guard
        regex.firstMatch(in: inn, options: [], range: range) != nil
    else { return false }
    
    
    var arr: [Int] = []

    for character in inn {
        arr.append(Int("\(character)") ?? 0)
    }
    
    if inn.count == 10{
        
        let i = ((2*arr[0] + 4*arr[1] + 10*arr[2] +
            3*arr[3] + 5*arr[4] + 9*arr[5] +
            4*arr[6] + 6*arr[7] + 8*arr[8])  % 11) % 10
        
        return i == arr[9]
    }else if inn.count == 12{
        
        let i = ((7*arr[0] + 2*arr[1] + 4*arr[2] +
                   10*arr[3] + 3*arr[4] + 5*arr[5] +
                    9*arr[6] + 4*arr[7] + 6*arr[8] +
                    8*arr[9]) % 11) % 10
        
        let n = ((3*arr[0] +  7*arr[1] + 2*arr[2] +
            4*arr[3] + 10*arr[4] + 3*arr[5] +
            5*arr[6] +  9*arr[7] + 4*arr[8] +
            6*arr[9] +  8*arr[10]) % 11) % 10
        
        return i == arr[10] && n == arr[11]
    }
    
    return false
}

testStrings.forEach { (str) in
    print(str, "is", isValinINN(str))
}

