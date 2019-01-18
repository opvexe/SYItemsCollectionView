//
//  SYMoreStatusView.h
//  CEBMobileBank
//
//  Created by FaceBook on 2019/1/16.
//  Copyright © 2019年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYMoreFunModel.h"

@class SYMoreStatusHeaderView;
@protocol SYChangeItemsHeaderViewDelegate <NSObject>

-(void)changeStatusItemWithHeaderView:(SYMoreStatusHeaderView *)headerView withCollectionView:(UICollectionView *)collectionView withSouce:(NSArray *)souces withModel:(SYMoreFunModel *)model;

@end

@interface SYMoreStatusHeaderView : UIView

@property(nonatomic,copy)void(^StatusHeaderBlock)(SYMoreStatusHeaderView *headerView,BOOL isEdit);

@property(nonatomic,weak) id <SYChangeItemsHeaderViewDelegate>delegate;

@property(nonatomic,strong)UICollectionView *statusCollectionView;

-(void)initWithSouces:(NSArray *)souces;

@end
