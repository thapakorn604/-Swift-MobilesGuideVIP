import Foundation

struct Mobile : Equatable {
  static func == (lhs: Mobile, rhs: Mobile) -> Bool {
    return lhs.mobile == rhs.mobile && lhs.isFav == rhs.isFav
  }
  
  var mobile : MobileResponse!
  var isFav : Bool!
}
