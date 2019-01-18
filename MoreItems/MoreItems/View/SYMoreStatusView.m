//
//  SYMoreStatusView.m
//  CEBMobileBank
//
//  Created by FaceBook on 2019/1/18.
//  Copyright © 2019年 Shen Yu. All rights reserved.
//

#import "SYMoreStatusView.h"
#import "SYMoreFunModel.h"
@interface SYMoreStatusView()
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIButton *editButton;
@property(nonatomic,strong)NSMutableArray *lists;
@property(nonatomic,strong)UIView *bgContentView;
@end
static CGFloat MaxRowCount = 8; ///最多展示8个
@implementation SYMoreStatusView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgContentView = ({
            UIView *iv = [[UIView alloc]init];
            iv.backgroundColor = [UIColor whiteColor];
            [self addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.mas_equalTo(self);
                make.bottom.mas_equalTo(-10.0f);
            }];
            iv;
        });
        
        _nameLabel = ({
            UILabel *iv = [[UILabel alloc]init];
            [self.bgContentView addSubview:iv];
            iv.text = @"我的应用";
            iv.textColor = [UIColor blackColor];
            iv.font = [UIFont systemFontOfSize:16.0f];
            iv.textAlignment = NSTextAlignmentLeft;
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10.0f);
                make.centerY.mas_equalTo(self.bgContentView);
                make.height.mas_equalTo(20.0f);
                make.width.mas_lessThanOrEqualTo(180.0f);
            }];
            iv;
        });
        
        _editButton = ({
            UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.bgContentView addSubview:iv];
            [iv setTitle:@"自定义" forState:UIControlStateNormal];
            [iv setTitle:@"自定义" forState:UIControlStateSelected];
            [iv setTitle:@"自定义" forState:UIControlStateDisabled];
            [iv setTitle:@"自定义" forState:UIControlStateHighlighted];
            [iv setTitleColor:NEW_PURPLE_COLOR forState:UIControlStateNormal];
            [iv setTitleColor:NEW_PURPLE_COLOR forState:UIControlStateSelected];
            [iv setTitleColor:NEW_PURPLE_COLOR forState:UIControlStateDisabled];
            [iv setTitleColor:NEW_PURPLE_COLOR forState:UIControlStateHighlighted];
            iv.titleLabel.textAlignment = NSTextAlignmentRight;
            iv.adjustsImageWhenHighlighted =NO;
            iv.showsTouchWhenHighlighted =NO;
            iv.titleLabel.font = [UIFont systemFontOfSize:16.0f];
            [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-20.0f);
                make.height.mas_equalTo(20.0f);
                make.centerY.mas_equalTo(self.bgContentView);
                make.width.mas_lessThanOrEqualTo(60.0f);
            }];
            iv;
        });
        
    }
    return self;
}

-(void)initWithSouces:(NSArray *)souces{
    [self.lists removeAllObjects];
    if (souces.count) {
        [self.lists addObjectsFromArray:souces];
    }
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            [obj removeFromSuperview];
        }
    }];
    
    UIImageView *lastImageView = nil;
    for (int i = 0; i < self.lists.count; i ++) {
        UIImageView *iv = [[UIImageView alloc]init];
        [self.bgContentView addSubview:iv];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds =YES;
        iv.backgroundColor = [UIColor orangeColor];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25.0f);
            make.width.mas_equalTo(25.0f);
            make.centerY.mas_equalTo(self.bgContentView);
            if (lastImageView) {
                make.left.mas_equalTo(lastImageView.mas_right).mas_offset(5.0f);
            }else{
                make.left.mas_equalTo(self.nameLabel.mas_right).mas_offset(5.0f);
            }
        }];
        lastImageView = iv;
    }
}

-(void)Click:(UIButton *)sender{
    if (self.statusBlock) {
        self.statusBlock(self, YES);
    }
}

-(NSMutableArray *)lists{
    if (!_lists) {
        _lists = [NSMutableArray arrayWithCapacity:0];
    }
    return _lists;
}


@end
