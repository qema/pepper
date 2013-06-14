//
//  PPTileGroup.h
//  Pepper
//
//  Created by Andrew Wang on 6/13/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPTileset.h"
#import "ppTypes.h"

/** Loads and draws a tilemap and tileset */
@interface PPTMXTileGroup : PPObject <NSXMLParserDelegate>
{
    NSData *mapData;
    unsigned int *mapTile;
    Quad *tileQuad,*textureQuad;
    BOOL shouldSwapBytesToCorrectEndianness;
}

/** The map's tileset */
@property (nonatomic,retain) PPTileset *tileset;
/** Map size in tiles */
@property (nonatomic) CGSize mapSize;
/** Tile size in world coords */
@property (nonatomic) CGSize tileSize;

@property (nonatomic) int numberOfQuads;

-(id)initWithDictionary:(NSDictionary *)dict tileset:(PPTileset *)tileset;

-(Quad *)quads;
-(Quad *)textureQuads;

-(unsigned int)tileAtMapCoords:(CGPoint)coords;
@end
