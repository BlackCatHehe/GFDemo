//
//  JYNaviControllerPushProtocol.swift
//  GameCommuniteDemo
//
//  Created by kuroneko on 2019/10/19.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import Foundation

protocol JYNaviControllerTransitionProtocol {
    
}

extension JYNaviControllerTransitionProtocol where Self: GCBaseVC {
    
    func addTransition(type: CATransitionType, position: CATransitionSubtype) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = .init(name: .easeInEaseOut)
        transition.type = type
        transition.subtype = position
        transition.delegate = self
        self.navigationController?.view.layer.add(transition, forKey: nil)
    }
    
}

extension GCBaseVC: CAAnimationDelegate {}
