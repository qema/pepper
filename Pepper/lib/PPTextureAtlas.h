//
//  PPTextureAtlas.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPFileUtils.h"
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

-(id)initWithScale:(float)scale;
@end
