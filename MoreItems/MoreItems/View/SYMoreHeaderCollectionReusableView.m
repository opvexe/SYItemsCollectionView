//
//  SYMoreHeaderCollectionReusableView.m
//  CEBMobileBank
//
//  Created by FaceBook on 2019/1/16.
//  Copyright © 2019年 Shen Yu. All rights reserved.
//

#import "SYMoreHeaderCollectionReusableView.h"
@interface SYMoreHeaderCollectionReusableView()
@property(nonatomic,strong)UIView *verticaLineView;
@property(nonatomic,strong)UILabel *sevicesLabel;
@property(nonatomic,strong)UIView *bottomlineView;
@end
@implementation SYMoreHeaderCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _verticaLineView = ({
            UIView *iv = [[UIView alloc]init];
            iv.backgroundColor = NEW_PURPLE_COLOR;
            [self addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10.0f);
                make.centerY.mas_equalTo(self);
                make.height.mas_equalTo(14.0f);
                make.width.mas_equalTo(3.0f);
            }];
            iv;
        });
        
        _sevicesLabel = ({
            UILabel *iv = [[UILabel alloc]init];
            [self addSubview:iv];
            iv.textColor = [UIColor blackColor];
            iv.font = [UIFont systemFontOfSize:14];
            iv.textAlignment = NSTextAlignmentLeft;
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.verticaLineView.mas_right).mas_offset(5.0f);
                make.centerY.mas_equalTo(self);
                make.height.mas_equalTo(20.0f);
                make.width.mas_lessThanOrEqualTo(180.0f);
            }];
            iv;
        });
        
        _bottomlineView = ({
            UIView *iv = [[UIView alloc] init];
            iv.backgroundColor =GRAY_BACK_GROUND_COLOR;
            [self addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0.5);
                make.bottom.mas_equalTo(self.mas_bottom);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
            }];
            iv;
        });
    }
    return  self;
}

-(void)InitDataWithModel:(SYMoreFunContentModel *)model{
    self.sevicesLabel.text = model.Title;
}
@end
