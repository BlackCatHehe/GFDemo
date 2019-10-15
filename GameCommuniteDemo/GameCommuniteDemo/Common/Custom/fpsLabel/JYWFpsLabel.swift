//
//  JYWFpsLabel.swift
//  TheWorld
//
//  Created by kuroneko on 2019/5/20.
//  Copyright © 2019 payTokens. All rights reserved.
//

import UIKit

class JYWFpsLabel: UILabel {

    private var link: CADisplayLink!
    private var lastTime: TimeInterval = 0
    private var count: Double = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initUI()
    }
    
    deinit {
        link.invalidate()
    }

}

extension JYWFpsLabel {
    private func initUI() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        textAlignment = .center
        isUserInteractionEnabled = false
        
        font = UIFont.systemFont(ofSize: 12)
        
        link = CADisplayLink(target: self, selector: #selector(tick(link:)))
        link.add(to: .main, forMode: .common)
    }
    
    @objc func tick(link: CADisplayLink) {
        if lastTime == 0 {
            lastTime = link.timestamp
            return
        }
        
        count += 1
        
        let delta = link.timestamp - lastTime
        if delta < 1  {return}
        lastTime = link.timestamp
        let fps = count / delta
        
        count = 0
        text = "fps:" + String(Int(round(fps)))
        
        
        
        
    }
}
