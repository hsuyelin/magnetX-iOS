//
//  Router.swift
//  SwiftRouter
//
//  Created by G-Xi0N on 2017/12/27.
//  Copyright © 2017年 gaoX. All rights reserved.
//

import Foundation
import UIKit

public typealias ConfigurationHandler<T> = (T) -> Void
public typealias CompletionHandler<T> = (UIViewController, T) -> Void

public protocol Routable {
    static func registerRoute(parameters: [String: Any]?) -> Routable
}

public protocol Redirectable {
    func redirect(route: Routable.Type,
                  parameters: [String: Any]?,
                  transform: @escaping (Routable) -> Void)
}

extension Redirectable {
    public func redirect(route: Routable.Type,
                         parameters: [String: Any]?,
                         transform: @escaping (Routable) -> Void) {
        transform(route.registerRoute(parameters: parameters))
    }
}

open class Router: Redirectable {
    
    public static let shared = Router()
    private init() {}
    
    open class func open<R: Routable>(_ route: R.Type,
                                      parameters: [String: Any]? = nil,
                                      from originViewController: UIViewController,
                                      animated: Bool = true,
                                      configuration: ConfigurationHandler<R>? = nil,
                                      completion: CompletionHandler<R>? = nil) {
        shared.open(route, parameters: parameters, from: originViewController, animated: animated, configuration: configuration, completion: completion)
    }
    
    private func open<R: Routable>(_ route: R.Type,
                                   parameters: [String: Any]? = nil,
                                   from originViewController: UIViewController,
                                   animated: Bool = true,
                                   configuration: ConfigurationHandler<R>? = nil,
                                   completion: CompletionHandler<R>? = nil) {
        
        func configurationHandler(target: Routable,
                                  configuration: ((R) -> Void)?) {
            guard let target = target as? R else { return }
            configuration.map({ $0(target) })
        }
        
        func completionHandler(origin: UIViewController,
                               target: Routable,
                               completion: ((UIViewController, R) -> Void)?) {
            guard let target = target as? R else { return }
            completion.map({
                $0(origin, target)
            })
        }
        
        redirect(route: route, parameters: parameters) { (target) in
            guard let viewController = target as? UIViewController else {
                fatalError("Target type error")
            }
            configurationHandler(target: target, configuration: configuration)
            viewController.hidesBottomBarWhenPushed = true
            if let nav = originViewController as? UINavigationController {
                nav.pushViewController(viewController, animated: animated)
            }
            else {
                guard let nav = originViewController.navigationController else {
                    fatalError("Current view controller have no navigation controller")
                }
                nav.pushViewController(viewController, animated: animated)
            }
            completionHandler(origin: originViewController, target: target, completion: completion)
        }
    }
}

extension UIViewController {
    
    public func push<R: Routable>(_ route: R.Type,
                                  parameters: [String: Any]? = nil,
                                  animated: Bool = true,
                                  configuration: ConfigurationHandler<R>? = nil) {
        Router.open(route, parameters: parameters, from: self, animated: animated, configuration: configuration, completion: nil)
    }
}

extension UIView {
    
    public var currentViewController: UIViewController? {
        var next = superview
        while next != nil {
            let nextResponder = next?.next
            if nextResponder is UIViewController {
                return nextResponder as? UIViewController
            }
            next = next?.superview
        }
        return nil
    }
    
    public func push<R: Routable>(_ route: R.Type,
                                  parameters: [String: Any]? = nil,
                                  animated: Bool = true,
                                  configuration: ConfigurationHandler<R>? = nil) {
        currentViewController?.push(route, parameters: parameters, animated: animated, configuration: configuration)
    }
}
