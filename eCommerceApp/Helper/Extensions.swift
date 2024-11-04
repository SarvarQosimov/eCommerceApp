//
//  Extensions.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 13/01/24.
//

import Foundation
import SwiftUI

extension Int {
    func toString() -> String{
        return "\(self)"
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(
            .sRGB,
            red: red,
            green: green,
            blue: blue,
            opacity: 1
        )
    }
}

extension Color {
    static func ColorByAppThemView(_ color: AppColor) -> some View {
        @AppStorage("appThem") var appThem = ""
        
        let isDarkMode = stringToAppThem(appMode: appThem)
        
        switch color {
        case .white:               return isDarkMode ? Color(Constants.kPrimary) : Color.white
        case .primary:             return isDarkMode ? Color.white               : Color(Constants.kPrimary)
        case .black:               return isDarkMode ? Color.white               : Color.black
        case .primaryOrSecondary:  return isDarkMode ? Color(Constants.kSecondary) : Color(Constants.kPrimary)
        case .systemGram6OrPrimary: return isDarkMode ? Color(Constants.kPrimary) : Color(uiColor: UIColor.systemGray6)
        }
    }
   
    static func ColorByAppThemColor(_ color: AppColor) -> Color {
        @AppStorage("appThem") var appThem = ""
        
        let isDarkMode = stringToAppThem(appMode: appThem)

        switch color {
        case .white:              return isDarkMode ? Color(Constants.kPrimary) : Color.white
        case .primary:            return isDarkMode ? Color.white               : Color(Constants.kPrimary)
        case .black:              return isDarkMode ? Color.white               : Color.black
        case .primaryOrSecondary: return isDarkMode ? Color(Constants.kSecondary) : Color(Constants.kPrimary)
        case .systemGram6OrPrimary: return isDarkMode ? Color(Constants.kPrimary) : Color(uiColor: UIColor.systemGray6)
        }
    }
    
     static private func stringToAppThem(appMode: String) -> Bool {
        switch appMode {
        case "light": return false
        case "dark": return true
        default:
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            
            let currentTime = formatter.string(from: Date())
            
            let hour = currentTime.dropLast(6)
            
            if hour > "06" && hour < "18" {
                return false
            } else {
                return true
            }
            
            
        }
    }
    
}
// Extending on View to apply to all Views
extension View {
    func hide(if isHiddden: Bool) -> some View {
        ModifiedContent(content: self,
                        modifier: HideViewModifier(isHidden: isHiddden)
        )
    }
}

// modifier
struct HideViewModifier: ViewModifier {
    let isHidden: Bool
    @ViewBuilder func body(content: Content) -> some View {
        if isHidden {
            EmptyView()
        } else {
            content
        }
    }
}

class UpdateMananger: ObservableObject, Equatable {
    static func == (lhs: UpdateMananger, rhs: UpdateMananger) -> Bool {
        false
    }
    
    @Published var shouldUpdate = false
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
