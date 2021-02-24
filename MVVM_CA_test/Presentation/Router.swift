//
//  HomeRouter.swift
//  MVVM_CA_test
//
//  Created by Nunzio Giulio Caggegi on 24/02/21.
//

import Foundation
import UIKit

enum RouterMode {
    case present
    case push
}

protocol RouterProtocol {
    func route(to: UIViewController, from: UIViewController, mode: RouterMode)
}

extension RouterProtocol {
    func route(to: UIViewController, from: UIViewController, mode: RouterMode) {
        switch mode {
        case .present:
            from.present(to, animated: true, completion: nil)
        default:
            from.navigationController?.pushViewController(to, animated: true)
        }
    }
}
