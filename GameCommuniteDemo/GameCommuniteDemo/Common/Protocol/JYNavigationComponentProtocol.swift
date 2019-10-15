//
//  JYNavigationComponentProtocol.swift
//  GameCommunity
//
//  Created by APP on 2019/9/25.
//  Copyright © 2019 kuroneko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Then
import SnapKit

fileprivate struct Metric {
    static let componentSize: CGSize = CGSize(width: 30.0, height: 30.0)
    static let searchRightComponentSize: CGSize = CGSize(width: 20.0, height: 20.0)
    static let searchLeftComponentSize: CGSize = CGSize(width: 15.0, height: 15.0)
}

protocol JYNavigationComponentProtocol {
    
}

extension JYNavigationComponentProtocol where Self: UIView {
    
    
    /// 添加通用组件到视图上，需要自行设置位置(只需设置左右约束,内置size为30*30,居中)
    /// - Parameter model: 组件的信息
    /// - Parameter onTap: 组件的点击事件
    func componentInstall(with model: JYNavigationComponentModel, onTap: ((JYNavigationComponentModel) ->())?) ->UIView {
        
        let view = UIView()
        
        let button = UIButton().then {
            $0.setTitle(model.title, for: .normal)
            $0.setBackgroundImage(model.img, for: .normal)
            $0.rx.tap
                .bind{_ in
                    onTap?(model)
            }.disposed(by: rx.disposeBag)
        }
        addSubview(view)
        view.addSubview(button)
        view.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.bottom.equalToSuperview().offset(-7)
        }
        button.snp.makeConstraints { (make) in
            make.size.equalTo(Metric.componentSize)
            make.centerY.equalToSuperview()
        }
        return view
    }
    
    /// 添加搜索组件到视图上，需要自行设置位置,返回一个数组,数组第一个元素为搜索视图,第二个元素为textfield
    /// - Parameter model: 组件的信息
    /// - Parameter textFieldDelegate: textfield的代理
    /// - Parameter onTap: 右侧组件的点击事件
    func searchComponentInstall(with model: JYNavigationSearchComponentModel, textFieldDelegate: UITextFieldDelegate?, onTap: ((JYNavigationSearchComponentModel) ->())?) ->[UIView] {
        
        //1.背景view
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        addSubview(view)
        
        //2.搜索textfield
        let searchTF = UITextField()
        searchTF.delegate = textFieldDelegate
        searchTF.backgroundColor = .white
        searchTF.clearButtonMode = .whileEditing
        searchTF.textColor = kRGB(r: 41, g: 41, b: 41)
        searchTF.font = kFont(16)
        if let attrPh = model.attributedPlaceholder {
            searchTF.attributedPlaceholder = attrPh
        }else {
            searchTF.placeholder = model.placeholder
        }
        view.addSubview(searchTF)
        
        //搜索的左右按钮
        var leftBt: UIButton? = UIButton()
        var rightBt: UIButton? = UIButton()
        if let leftImg = model.searchLeftImg {
            leftBt = UIButton().then {
                $0.setBackgroundImage(leftImg, for: .normal)
                $0.imageView?.contentMode = .scaleAspectFit
                $0.isUserInteractionEnabled = false
            }
            view.addSubview(leftBt!)
            leftBt!.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(10)
                make.size.equalTo(Metric.searchLeftComponentSize)
            }
   
        }else {
            leftBt = nil
        }
        
        if let rightImg = model.searchRightImg {
            rightBt = UIButton().then {
                $0.setBackgroundImage(rightImg, for: .normal)
                $0.imageView?.contentMode = .scaleAspectFit
                $0.rx.tap
                    .bind{_ in
                        onTap?(model)
                }.disposed(by: rx.disposeBag)
            }
            view.addSubview(rightBt!)
            rightBt!.snp.makeConstraints { (make) in
                       make.centerY.equalTo(view)
                       make.right.equalToSuperview().offset(-15)
                       make.size.equalTo(Metric.searchRightComponentSize)
            }
        }else {
            rightBt = nil
        }
        
        //搜索textfield的左右约束
        searchTF.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(30.0)
            if let lButton = leftBt {
                make.left.equalTo(lButton.snp_right).offset(10)
            }else {
                make.left.equalToSuperview().offset(10)
            }
            
            if let rButton = rightBt {
                make.right.equalTo(rButton.snp_left).offset(-10)
            }else {
                make.right.equalToSuperview().offset(-10)
            }
        }

        return [view, searchTF]
    }
}

extension JYNavigationComponentProtocol where Self: UIViewController {
    
    
    /// 设置一个覆盖navigationbar的view
    /// - Parameter titleView: 传入的覆盖view
    @discardableResult
    func maskNavigationBar(with maskView: UIView) ->UIView{
        navigationItem.titleView = maskView
        return maskView
    }
    

    /// 添加组件到导航栏
    /// - Parameter model: 组件的信息
    /// - Parameter onTap: 组件的点击事件
    func componentInstall(with model: JYNavigationComponentModel, onTap: ((JYNavigationComponentModel) ->())?) {
        
        let item: UIBarButtonItem
        if let title = model.title {
            item = UIBarButtonItem(title: title, style: .done, target: nil, action: nil)
        }else {
            item = UIBarButtonItem(image: model.img, style: .done, target: nil, action: nil)
        }
    
        item.tintColor = kRGB(r: 153, g: 153, b: 153)
        item.setTitleTextAttributes([NSAttributedString.Key.font : kFont(14)], for: .normal)
        item.rx.tap
            .bind {_ in
                onTap?(model)
        }.disposed(by: rx.disposeBag)
        
        switch model.postiton {
        case .left:
            if (navigationItem.leftBarButtonItems?.count ?? 0) == 0 {
                navigationItem.leftBarButtonItems = [item]
            }else {
                var items = navigationItem.leftBarButtonItems
                items?.append(item)
                navigationItem.leftBarButtonItems = items
            }
        case .right:
            if (navigationItem.rightBarButtonItems?.count ?? 0) == 0 {
                navigationItem.rightBarButtonItems = [item]
            }else {
                var items = navigationItem.rightBarButtonItems
                items?.append(item)
                navigationItem.rightBarButtonItems = items
            }
        default: break
        }
    }
}

enum ItemPosition {
    case left
    case right
}

struct JYNavigationComponentModel {
    
    var title: String?
    var img: UIImage?
    var selectedImg: UIImage?
    
    var searchLeftImg: UIImage?
    var searchRightImg: UIImage?
    
    var postiton: ItemPosition? = .left
    
}

struct JYNavigationSearchComponentModel {
    
    var searchLeftImg: UIImage?
    var searchRightImg: UIImage?
    var placeholder: String?
    var attributedPlaceholder: NSAttributedString?
    
}
