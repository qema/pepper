//
//  PPLayer.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPStageElement.h"
#import <GLKit/GLKit.h>

/** A base layer -- subclassed for specific types of layers */
@interface PPLayer : PPStageElement

@property (nonatomic) CGRect frame;
/** For optimization, the rectangle (in world coords) to draw. Only used if size is nonzero */
@property (nonatomic) CGRect drawRect;
@property (nonatomic,strong) GLKBaseEffect *shader;

-(id)initWithFrame:(CGRect)frame;
-(void)draw;
-(void)useProjectionMatrix:(GLKMatrix4)projection modelViewMatrix:(GLKMatrix4)modelView;
@end
