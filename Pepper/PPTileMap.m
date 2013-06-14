//
//  PPTileMap.m
//  Pepper
//
//  Created by Andrew Wang on 6/14/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPTileMap.h"
#import "PPTMXParser.h"
#import "PPTMXTileGroup.h"

@implementation PPTileMap

-(id)initWithFile:(NSString *)file tilesetScale:(float)scale
{
    if (self=[super init]) {
        PPTMXParser *parser = [[PPTMXParser alloc] initWithFile:file];
        
        size = parser.mapSize;
        
        _tileset = [[PPTileset alloc] initWithImageFile:parser.tilesetImageFile properties:parser.tilesetProperties scale:scale];
        
        _layers = [[NSMutableArray alloc] initWithCapacity:[parser.layers count]];
        for (NSDictionary *dict in parser.layers) {
            PPTMXTileGroup *layer = [[PPTMXTileGroup alloc] initWithDictionary:dict tileset:_tileset];
            [_layers addObject:layer];
        }
    }
    return self;
}

-(CGSize)sizeBeforeTransformations
{
    CGSize tileSize = CGSizeMake(self.tileset.tileSize.width/self.tileset.scale,self.tileset.tileSize.height/self.tileset.scale);
    return CGSizeMake(size.width*tileSize.width, size.height*tileSize.height);
}

@end
