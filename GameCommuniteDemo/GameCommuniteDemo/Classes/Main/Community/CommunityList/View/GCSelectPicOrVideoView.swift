//
//  GCSelectPicOrVideoView.swift
//  GameCommuniteDemo
//
//  Created by APP on 2019/10/24.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import Reusable

protocol GCSelectPicOrVideoViewDelegate {
    func chooseView(_ view: GCSelectPicOrVideoView, didSelectAt index: Int)
    func chooseView(_ view: GCSelectPicOrVideoView, didClickBack button: UIButton)
}
class GCSelectPicOrVideoView: UIView, NibLoadable {

    var delegate: GCSelectPicOrVideoViewDelegate?
    
    @IBOutlet weak var backBt: UIButton!
    
    @IBOutlet weak var picBt: UIButton!
    
//    @IBOutlet weak var videoBt: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = kRGBA(r: 0, g: 0, b: 0, a: 0.8)
        
        picBt.layoutButton(style: .Top, imageTitleSpace: adaptW(5.0))
        picBt.tag = 101
//        videoBt.layoutButton(style: .Top, imageTitleSpace: adaptW(5.0))
//        videoBt.tag = 102

    }
    
    @IBAction func clickBack(_ sender: UIButton) {
        delegate?.chooseView(self, didClickBack: sender)
    }
    
    @IBAction func clickChoose(_ sender: UIButton) {
        delegate?.chooseView(self, didSelectAt: sender.tag - 101)
    }
    
}
