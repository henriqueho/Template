//
//  BannerModel+Parse.h
//  MoveRio
//
//  Created by Alexandre Santos on 19/12/12.
//  Copyright (c) 2012 Infoglobo. All rights reserved.
//

#import "BannerModel.h"
//#import "TFHpple.h"

@interface BannerModel (Parse)

+ (BannerModel *)parseWithURL:(NSURL *)url;

@end
