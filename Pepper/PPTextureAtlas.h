//
//  PPTextureAtlas.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPFileUtils.h"
#import "PPStageElement.h"
#import <GLKit/GLKit.h>

/** Stores a texture and an "atlas" of frames which are assigned to names. Thus you can access a certain rectangle (i.e. location of a sprite or tile in a spritesheet/tileset) by its name. */
@interface PPTextureAtlas : PPObject
{
}
@property (nonatomic,strong) NSMutableDictionary *frames;
@property (nonatomic,strong) GLKTextureInfo *texture;
@property (nonatomic,strong) NSString *textureFile;
@property (nonatomic) CGSize textureSize;
@property (nonatomic) float scale;

/** @name Initializing */
/** Initialize with info file
 @param filename The file to use; file must be in TexturePacker cocos2d plist format
 @param scale Scale the image is stretched to; for retina images, scale should be 2.0, and 1.0 for non-retina
 */
-(id)initWithFile:(NSString *)filename scale:(float)scale;
@end
