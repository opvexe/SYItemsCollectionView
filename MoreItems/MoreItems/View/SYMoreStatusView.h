//
//  SYMoreStatusView.h
//  CEBMobileBank
//
//  Created by FaceBook on 2019/1/18.
//  Copyright © 2019年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYMoreStatusView : UIView

@property(nonatomic,copy)void (^statusBlock)(SYMoreStatusView *itemsView,BOOL isEdit);

-(void)initWithSouces:(NSArray *)souces;

@end

NS_ASSUME_NONNULL_END
