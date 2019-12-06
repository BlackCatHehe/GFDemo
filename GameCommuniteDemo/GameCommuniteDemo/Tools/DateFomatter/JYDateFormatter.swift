//
//  MXTDateFormatter.swift
//  mingxint
//
//  Created by payTokens on 2019/4/19.
//  Copyright © 2019 放. All rights reserved.
//

import UIKit

class JYDateFormatter: DateFormatter {

    ///单例格式化 默认格式为"yyyy-MM-dd"
    static let dateFormatter: JYDateFormatter = {
        let formater = JYDateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        return formater
    }()
}

