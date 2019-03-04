//
//  SYMoreFunModel.h
//  CEBMobileBank
//
//  Created by FaceBook on 2019/1/16.
//  Copyright © 2019年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SYMoreFunModel : NSObject

@property(nonatomic,copy)NSString *Id;

@property(nonatomic,copy)NSString *Title;

@property(nonatomic,assign)BOOL IsSelected;

@end

@interface SYMoreFunContentModel : SYMoreFunModel

@property(nonatomic,strong)NSArray *List;
@end

@interface SYMoreListModel :SYMoreFunModel


@property(nonatomic,copy)NSString *ImageUrl;


@end

