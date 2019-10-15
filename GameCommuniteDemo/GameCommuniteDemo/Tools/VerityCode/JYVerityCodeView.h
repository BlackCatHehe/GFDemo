//
//  JYVerityCodeView.h
//  NationalFace
//
//  Created by APP on 2019/8/6.
//  Copyright © 2019 kuroneko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYVerityCodeView : UIView

@property (nonatomic, retain) NSArray *changeArray; //字符素材数组
@property (nonatomic, copy) NSString *result;  //验证码的字符串

- (void)changeCaptcha;
@end

NS_ASSUME_NONNULL_END
