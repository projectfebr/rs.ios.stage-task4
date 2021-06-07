import Foundation

public extension Int {
    
    var roman: String? {
        let CONV_TABLE: [(arab: Int, rim: String)] = [(1000, "M"), (900 ,"CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
         
        guard self > 0 else {
             return nil
         }
         var res = String()
         var arab = self
         for number in CONV_TABLE {
            while arab >= number.arab {
                res.append(number.rim)
                arab -= number.arab
             }
         }
         return res
    }
}


//def arab_to_roman( number ):
//   if number <= 0: return ''
//
//   ret = ''
//   for arab, roman in CONV_TABLE:
//       while number >= arab:
//           ret += roman
//           number -= arab
//
//   return ret
