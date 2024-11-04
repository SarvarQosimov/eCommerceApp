//
//  CurrentNavigation.swift
//  MoodTracing
//
//  Created by Shohjahon Rakhmatov on 24/08/23.
//

import Foundation
import SwiftUI
import UIKit

class CurrentNavigation: NSObject {
    
    static let shared = CurrentNavigation()
    
    func showIndicator<Content: View>(_ content: Content) {
        let hostingController = UIHostingController(rootView: content)
        hostingController.isModalInPresentation = true
        //        hostingController.modalTransitionStyle = .crossDissolve
        hostingController.modalPresentationStyle = .overFullScreen
        hostingController.view.backgroundColor = .clear
        CurrentNavigation.shared.topViewController?.present(hostingController, animated: true)
    }
    
    func hideIndicator(completion: @escaping() -> ()) {
        CurrentNavigation.shared.topViewController?.dismiss(animated: true) {
            completion()
        }
    }
    
    func presentModal<Content: View>(_ content: Content) {
        let hostingController = UIHostingController(rootView: content)
        hostingController.isModalInPresentation = true
//        hostingController.modalTransitionStyle = .crossDissolve
        hostingController.modalPresentationStyle = .overFullScreen
        hostingController.view.backgroundColor = .clear
        CurrentNavigation.shared.topViewController?.present(hostingController, animated: true)
    }
    
//    func presentDatePicker(time: Binding<Date>, leading: CGFloat, top: CGFloat) {
//        let hostingController = UIHostingController(rootView: CustomDatePickerView(time: time, leading: leading, top: top))
//        hostingController.isModalInPresentation = true
//        hostingController.modalTransitionStyle = .crossDissolve
//        hostingController.modalPresentationStyle = .overFullScreen
//        hostingController.view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
//        hostingController.view.addGestureRecognizer(tapGesture)
//        CurrentNavigation.shared.topViewController?.present(hostingController, animated: true)
//        Utils.shared.hapticFeedback()
//    }
    
    @objc func didTapBackground() {
        CurrentNavigation.shared.dismissDatePicker {}
    }
    
    func dismissDatePicker(completion: @escaping() -> ()) {
        CurrentNavigation.shared.topViewController?.dismiss(animated: true) {
            completion()
        }
    }
    
    func present<Content: View>(_ content: Content, isFullScreenCover: Bool = false, isCrossDissolve: Bool = false) {
        let hostingController = UIHostingController(rootView: content)
        hostingController.isModalInPresentation = true
        if isCrossDissolve {
            hostingController.modalTransitionStyle = .crossDissolve
        }
        if isFullScreenCover {
            hostingController.modalPresentationStyle = .overFullScreen
        }
        CurrentNavigation.shared.topViewController?.present(hostingController, animated: true)
        hapticFeedback()
    }
    
    func push<Content: View>(_ content: Content) {
        print("push push push")
        let hostingController = UIHostingController(rootView: content)
        navigationController?.pushViewController(hostingController, animated: true)
        hapticFeedback()
    }
    
    func topPush<Content: View>(_ content: Content) {
        let hostingController = UIHostingController(rootView: content)
        topViewController?.navigationController?.pushViewController(hostingController, animated: true)
        hapticFeedback()
    }
    
    func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
    
    var topViewController: UIViewController? {
        var rootViewController: UIViewController? = rootViewController
        while rootViewController?.presentedViewController != nil {
            rootViewController = rootViewController?.presentedViewController
        }
        return rootViewController
    }
    
    var rootViewController: UIViewController? {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first?.rootViewController
    }
    
    var navigationController: UINavigationController? {
        return findNavigationController(viewController: rootViewController)
    }
    
    private func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        return nil
    }
}

