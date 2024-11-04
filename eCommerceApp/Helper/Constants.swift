//
//  Constants.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 29/12/23.
//

import Foundation
import SwiftUI

class Constants {
    static let kPrimary = "kPrimary"
    static let kSecondary = "kSecondary"
    static let mainFont = "American Typewriter"
}


enum AppColor {
    case white
    case primary
    case black
    case primaryOrSecondary
    case systemGram6OrPrimary
}


public class NavStackHolder {
  public weak var viewController: UIViewController?
  
  public init() {}
}

public protocol ViewControllable: View {
  var holder: NavStackHolder { get set }
  
  func loadView()
  func viewOnAppear(viewController: UIViewController)
}

public extension ViewControllable {
  var viewController: UIViewController {
    let viewController = HostingController(rootView: self)
    self.holder.viewController = viewController
    return viewController
  }
  
  func loadView() {}
  func viewOnAppear(viewController: UIViewController) {}
}

public class HostingController<ContentView>: UIHostingController<ContentView> where ContentView: ViewControllable {
  public override func loadView() {
    super.loadView()
    self.rootView.loadView()
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.rootView.viewOnAppear(viewController: self)
  }
}
