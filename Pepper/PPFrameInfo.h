//
//  PPFrameInfo.h
//  Pepper
//
//  Created by Andrew Wang on 6/7/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPStageElement.h"

@interface PPFrameInfo : PPObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic) CGRect bounds;
@property (nonatomic) CGRect originalBounds;
@property (nonatomic) CGPoint offset;
@property (nonatomic) BOOL isFlipped;

-(id)initWithName:(NSString *)name bounds:(CGRect)bounds originalBounds:(CGRect)originalBounds flipped:(BOOL)isFlipped;

-(CGPoint)adjustedOffset;
-(CGSize)adjustedSize;
-(CGSize)adjustedOriginalSize;
@end
