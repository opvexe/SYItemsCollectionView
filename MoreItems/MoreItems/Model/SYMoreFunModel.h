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
@property(nonatomic,copy)NSString *Columns;

@property(nonatomic,copy)NSString *Rows;

@property(nonatomic,copy)NSString *Type;

@property(nonatomic,strong)NSArray *List;
@end

@interface SYMoreListModel :SYMoreFunModel

@property(nonatomic,copy)NSString *ClientsType;

@property(nonatomic,copy)NSString *FeedUrl;

@property(nonatomic,copy)NSString *ImageUrl;

@property(nonatomic,copy)NSString *IsLogin;

@property(nonatomic,copy)NSString *Type;

@property(nonatomic,copy)NSString *Updated;

@property(nonatomic,copy)NSString *Created;

@property(nonatomic,copy)NSString *version;

@property(nonatomic,copy)NSString *AppUrl;

@property(nonatomic,copy)NSString *Url;

@property(nonatomic,copy)NSString *UserGroup;

@end

