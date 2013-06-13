//
//  PPSpritesheet.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPTextureAtlas.h"
#import "PPSprite.h"
#import "PPSpriteFrameInfo.h"

/** Manages sprite images and gives the bounding rect for a requested sprite */
@interface PPSpritesheet : PPTextureAtlas
{
}

/** @name Initializing the spritesheet */
/** Initialize with info file
 @param filename The file to use; file must be in TexturePacker cocos2d plist format
 @param scale Scale the image is stretched to; for retina images, scale should be 2.0, and 1.0 for non-retina
 */
-(id)initWithFile:(NSString *)filename scale:(float)scale;

/** @name Creating a sprite object from spritesheet info */
/** Create sprite
 
 Convenience method; initializes sprite with default size
 @param name Name of sprite frame in texture file
 @param position Starting position of sprite
 */
-(PPSprite *)createSpriteWithFrame:(NSString *)name position:(CGPoint)position;
/** Create sprite with tag
 
 Convenience method; initializes sprite with default size
 @param name Name of sprite frame in texture file
 @param position Starting position of sprite
 @param tag Identification tag
 */
-(PPSprite *)createSpriteWithFrame:(NSString *)name position:(CGPoint)position tag:(int)tag;
/** @name Setting a sprite's frame */
/** Set sprite to frame name - convenience method
 @param sprite Sprite to set
 @param name Frame name to set to */
-(void)sprite:(PPSprite *)sprite setFrame:(NSString *)name;
/** @name Getting a frame */
/** Get frame by name
 @param name Name of frame to retrieve */
-(PPSpriteFrameInfo *)frameInfoForName:(NSString *)name;
/** @name Getting a frame quad */
/** Get frame quad by name
 @param frameInfo Info object of frame image to use
 */
-(Quad)quadForFrame:(PPSpriteFrameInfo *)frameInfo;
/** Get normalized frame quad by name (0,0 is top left corner of tex, 1,1 is bottom right)
 @param frameInfo Info object of frame image to use
 */
-(Quad)normalizedQuadForFrame:(PPSpriteFrameInfo *)frameInfo;
@end
