//
//  MXTDateFormatter.swift
//  mingxint
//
//  Created by payTokens on 2019/4/19.
//  Copyright © 2019 放. All rights reserved.
//

import UIKit

class MXTDateFormatter: DateFormatter {

    ///单例格式化 默认格式为"yyyy-MM-dd"
    static let dateFormatter: MXTDateFormatter = {
        let formater = MXTDateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        return formater
    }()
}

