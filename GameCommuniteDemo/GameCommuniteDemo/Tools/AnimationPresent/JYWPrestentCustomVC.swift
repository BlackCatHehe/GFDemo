//
//  JYWPrestentCustomVC.swift
//  一刻钟
//
//  Created by kuroneko on 2019/6/15.
//  Copyright © 2019 连杰. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class JYWPrestentCustomVC: UIPresentationController {
    
    /**
     * 弹出controller的frame
     */
    var toFrame = CGRect.zero
    /**
     * dismiss是否带动画
     */
    var isDismissAnimateable = true
    
    /**
     * 遮罩view
     */
    private var maskView: UIView?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        presentedViewController.modalPresentationStyle = .custom
    }
}

extension JYWPrestentCustomVC: UIViewControllerTransitioningDelegate {
    
    /*
     * 来告诉控制器，谁是动画主管(UIPresentationController)，因为此类继承了UIPresentationController，就返回了self
     */
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
}

extension JYWPrestentCustomVC {
    
    // 呈现过渡即将开始的时候被调用的
    // 可以在此方法创建和设置自定义动画所需的view
    override func presentationTransitionWillBegin() {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        containerView?.addSubview(view)
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        maskView = view
        
        
        tap.rx.event
            .subscribe{[weak self]tap in
                self?.presentingViewController.dismiss(animated: self?.isDismissAnimateable ?? true, completion: nil)
        }.disposed(by: rx.disposeBag)
        
        // 获取presentingViewController 的转换协调器，负责动画的一个东西
        let transCoorDinator = presentingViewController.transitionCoordinator
        transCoorDinator?.animate(alongsideTransition: { (context) in
            view.alpha = 0.7
        }, completion: nil)
        
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            maskView = nil
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let transtionCoordinator = presentingViewController.transitionCoordinator
        transtionCoordinator?.animate(alongsideTransition: { (coor) in
            self.maskView?.alpha = 0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            maskView?.removeFromSuperview()
            maskView = nil
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect{
        print("frame:\(toFrame)")
        return toFrame
    }
    
    //  建议就这样重写就行，这个应该是控制器内容大小变化时，就会调用这个方法， 比如适配横竖屏幕时，翻转屏幕时
    //  可以使用UIContentContainer的方法来调整任何子视图控制器的大小或位置。
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if let conV = container as? UIViewController{
            if conV == self.presentedViewController{
                containerView?.setNeedsLayout()
            }
        }
        
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        if let frame = containerView?.frame {
            maskView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        }

    }
}
