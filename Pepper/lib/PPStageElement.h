//
//  PPStageElement.h
//  Pepper
//
//  Created by Andrew Wang on 6/4/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPObject.h"

@interface PPStageElement : PPObject

@property (nonatomic) CGPoint position;
@property (nonatomic) CGPoint scale;
@property (nonatomic) float rotation;
@property (nonatomic) CGPoint anchor;   // (0,0) is top left corner, (1,1) is bottom right

-(id)initWithPosition:(CGPoint)position;
-(id)initWithPosition:(CGPoint)position scale:(CGPoint)scale;
-(id)initWithPosition:(CGPoint)position scale:(CGPoint)scale rotation:(float)rotation;

-(CGSize)size;
-(CGSize)sizeBeforeTransformations;
-(CGPoint)realAnchor;   // anchor adjusted to object size
-(CGPoint)realAnchorBeforeTransformations;
@end
