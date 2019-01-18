//
//  SYMoreFunctionCollectionViewCell.h
//  CEBMobileBank
//
//  Created by FaceBook on 2019/1/16.
//  Copyright © 2019年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYMoreFunModel.h"

@class SYMoreFunctionCollectionViewCell;

@protocol SYMoreFunctionCollectionViewCellActionDelegate <NSObject>

-(void)addSevicesItemWithCell:(SYMoreFunctionCollectionViewCell *)cell withModel:(SYMoreFunModel *)model;

@end

@interface SYMoreFunctionCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak) id <SYMoreFunctionCollectionViewCellActionDelegate>delegate;

-(void)InitDataWithModel:(SYMoreFunModel *)model;

@end

