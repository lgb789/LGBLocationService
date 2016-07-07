//
//  LGBLocationService.h
//  qcjrgj
//
//  Created by lgb on 16/7/7.
//  Copyright © 2016年 com.dnj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LGBLocationServiceBlock)(NSDictionary *dic, NSError *error);

@interface LGBLocationService : NSObject

- (void)startLocation:(LGBLocationServiceBlock)block;

-(void)stopLocation;

@end
