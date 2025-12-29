import Foundation
 
public enum ViewState: Equatable {
    case loading
    case success
    case error(String)
    case empty
}
