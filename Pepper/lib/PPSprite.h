//
//  PPSprite.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPStageElement.h"
#import "PPSpriteFrameInfo.h"
#import "ppTypes.h"

/** Info for a single sprite entity. Does not draw itself; drawing is handled by its parent PPSpriteLayer
 */
@interface PPSprite : PPStageElement
{
}

/** The sprite frame info object for this sprite */
@property (nonatomic,strong) PPSpriteFrameInfo *frameInfo;

/** @name Initializing a sprite */
/** Initializes a sprite
 @param info PPSpriteFrameInfo object of sprite in spritesheet to use as the sprite's starting frame
 @param position Initial location of the sprite in relation to its PPSpriteLayer
 */
-(id)initWithFrameInfo:(PPSpriteFrameInfo *)info position:(CGPoint)position;

/** Initializes a sprite with tag
 @param info PPSpriteFrameInfo object of sprite in spritesheet to use as the sprite's starting frame
 @param position Initial location of the sprite in relation to its PPSpriteLayer
 @param tag Identifying tag to use
 */
-(id)initWithFrameInfo:(PPSpriteFrameInfo *)info position:(CGPoint)position tag:(int)tag;

/** @name Getting sprite information */
/** Get sprite bounds */
-(CGRect)bounds;
/** Get unadjusted size */
-(CGSize)sizeBeforeTransformations;
/** Check collision with other sprite 
 @param sprite Name of sprite to check against */
-(BOOL)collidesWithSprite:(PPSprite *)sprite;

-(Quad)quad;
@end
