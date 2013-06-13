//
//  PPSpriteFrameInfo.h
//  Pepper
//
//  Created by Andrew Wang on 6/7/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPStageElement.h"

@interface PPSpriteFrameInfo : PPObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic) CGRect bounds;
@property (nonatomic) CGSize originalSize;
@property (nonatomic) CGPoint offset;
@property (nonatomic) BOOL isFlipped;
@property (nonatomic) float scale;

-(id)initWithName:(NSString *)name bounds:(CGRect)bounds originalSize:(CGSize)originalSize offset:(CGPoint)offset flipped:(BOOL)isFlipped scale:(float)scale;

-(CGSize)sizeInTexture;
@end
