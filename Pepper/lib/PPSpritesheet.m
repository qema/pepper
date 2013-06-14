//
//  PPSpritesheet.m
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPSpritesheet.h"
#import "ppConstants.h"

@implementation PPSpritesheet

-(id)initWithFile:(NSString *)filename scale:(float)scale
{
    if (self=[super initWithScale:scale]) {
        NSDictionary *spritesheetData = [NSDictionary dictionaryWithContentsOfFile:[PPFileUtils fullPath:filename]];
        [self processData:spritesheetData];
        NSError *error;
        self.texture = [GLKTextureLoader textureWithContentsOfFile:[PPFileUtils fullPath:self.textureFile] options:nil error:&error];
        if (error) {
            NSLog(@"Error loading texture image %@: %@",self.textureFile,error);
        }
    }
    return self;
}

-(PPSprite *)createSpriteWithFrame:(NSString *)name position:(CGPoint)position tag:(int)tag
{
    PPSprite *sprite = [[PPSprite alloc] initWithFrameInfo:[self frameInfoForName:name] position:position tag:tag];
    return sprite;
}

-(PPSprite *)createSpriteWithFrame:(NSString *)name position:(CGPoint)position
{
    return [self createSpriteWithFrame:name position:position tag:0];
}

-(PPSpriteFrameInfo *)frameInfoForName:(NSString *)name
{
    PPSpriteFrameInfo *info = [self.frames objectForKey:name];
    if (!info)
        NSLog(@"Error: sprite frame name not found: %@",name);
    return info;
}

-(void)sprite:(PPSprite *)sprite setFrame:(NSString *)name
{
    sprite.frameInfo = [self frameInfoForName:name];
}

-(Quad)quadForFrame:(PPSpriteFrameInfo *)frameInfo
{
    CGRect rect = frameInfo.bounds;
    rect.size = [frameInfo sizeInTexture];
    Quad q;
    // "squeeze" quad to fix GL precision errors
    CGPoint topLeft = CGPointMake(rect.origin.x+0.25f, rect.origin.y+0.25f);
    CGPoint bottomLeft = CGPointMake(rect.origin.x+0.25f, rect.origin.y+rect.size.height+0.25f);
    CGPoint bottomRight = CGPointMake(rect.origin.x+rect.size.width-0.25f, rect.origin.y+rect.size.height-0.25f);
    CGPoint topRight = CGPointMake(rect.origin.x+rect.size.width-0.25f, rect.origin.y+0.25f);
    
    if (frameInfo.isFlipped) {
        q.x1 = topRight.x; q.y1 = topRight.y;
        q.x2 = topLeft.x; q.y2 = topLeft.y;
        q.x3 = bottomLeft.x; q.y3 = bottomLeft.y;
        q.x4 = bottomRight.x; q.y4 = bottomRight.y;
    } else {
        q.x1 = topLeft.x; q.y1 = topLeft.y;
        q.x2 = bottomLeft.x; q.y2 = bottomLeft.y;
        q.x3 = bottomRight.x; q.y3 = bottomRight.y;
        q.x4 = topRight.x; q.y4 = topRight.y;
    }
    return q;
}

-(Quad)normalizedQuadForFrame:(PPSpriteFrameInfo *)frameInfo
{
    Quad q = [self quadForFrame:frameInfo];
    CGSize size = self.textureSize;
    q.x1 /= size.width; q.y1 /= size.height;
    q.x2 /= size.width; q.y2 /= size.height;
    q.x3 /= size.width; q.y3 /= size.height;
    q.x4 /= size.width; q.y4 /= size.height;
    return q;
}

-(void)processData:(NSDictionary *)data
{
    // parse texture file
    NSDictionary *metaData = [data objectForKey:@"metadata"];
    if (metaData) {
        // meta info
        self.textureFile = [metaData objectForKey:@"textureFileName"];
        self.textureSize = CGSizeFromString([metaData objectForKey:@"size"]);
    } else {
        NSLog(@"Error: invalid texture file in spritesheet %@",self);
    }
    NSDictionary *frames = [data objectForKey:@"frames"];
    for (NSString *frameName in frames) {
        NSDictionary *info = [frames objectForKey:frameName];
        
        CGRect bounds = CGRectFromString([info objectForKey:@"frame"]);
        CGSize origSize = CGSizeFromString([info objectForKey:@"sourceSize"]);
        CGPoint offset = CGPointFromString([info objectForKey:@"offset"]);
        BOOL isFlipped = [[info objectForKey:@"rotated"] boolValue];
        
        PPSpriteFrameInfo *frameInfo = [[PPSpriteFrameInfo alloc] initWithName:frameName    bounds:bounds originalSize:origSize offset:offset flipped:isFlipped scale:self.scale];
        [self.frames setValue:frameInfo forKey:frameName];
    }
}
@end
