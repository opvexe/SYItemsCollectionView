//
//  SYMoreFunctionCollectionViewCell.m
//  CEBMobileBank
//
//  Created by FaceBook on 2019/1/16.
//  Copyright © 2019年 Shen Yu. All rights reserved.
//

#import "SYMoreFunctionCollectionViewCell.h"
@interface SYMoreFunctionCollectionViewCell()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *photosImageView;
@property(nonatomic,strong)UIButton *selectButton;
@property(nonatomic,strong)UIButton *redDotBtn;
@property(nonatomic,strong)SYMoreListModel *model;
@end
@implementation SYMoreFunctionCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        _photosImageView = ({
            UIImageView *iv = [[UIImageView alloc]init];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.clipsToBounds =YES;
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.contentView);
                make.top.mas_equalTo(0.0f);
                make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
            }];
            iv;
        });
        
        _titleLabel = ({
            UILabel *iv = [[UILabel alloc]init];
            iv.textColor =[UIColor blackColor];
            iv.numberOfLines = 1;
            iv.textAlignment = NSTextAlignmentCenter;
            iv.font = [UIFont systemFontOfSize:14.0f];
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.photosImageView.mas_bottom);
                make.centerX.mas_equalTo(self.contentView);
                make.height.mas_equalTo(20.0f);
                make.left.right.mas_equalTo(self.contentView);
            }];
            iv;
        });
        
        _redDotBtn = ({
            UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
            iv.backgroundColor = [UIColor redColor];
            iv.layer.cornerRadius = 2;
            iv.layer.masksToBounds = YES;
            iv.hidden = YES;
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.photosImageView.mas_right);
                make.width.height.mas_equalTo(4.0f);
                make.top.mas_equalTo(self.photosImageView.mas_top);
            }];
            iv;
        });
        
        _selectButton = ({
            UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
            [iv setImage:[UIImage imageNamed:@"app_item_add"] forState:UIControlStateNormal];
            iv.adjustsImageWhenHighlighted =NO;
            iv.showsTouchWhenHighlighted =NO;
            [self.contentView addSubview:iv];
            [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.photosImageView.mas_right);
                make.top.mas_equalTo(self.photosImageView.mas_top);
                make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
            }];
            iv;
        });
        
    }
    return self;
}


-(void)InitDataWithModel:(SYMoreListModel *)model{
    _model = model;
    self.titleLabel.text = model.Title;
    if (model.IsSelected) {
        self.selectButton.hidden =NO;
    }else{
        self.selectButton.hidden =YES;
    }
}

-(void)Click:(UIButton *)sender{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addSevicesItemWithCell:withModel:)]) {
        [self.delegate addSevicesItemWithCell:self withModel:self.model];
    }
}

@end
