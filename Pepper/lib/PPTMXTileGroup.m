//
//  PPTMXTileGroup.m
//  Pepper
//
//  Created by Andrew Wang on 6/13/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPTMXTileGroup.h"
#import "PPFileUtils.h"
#import "ppMath.h"
#import "PPTileset.h"

@implementation PPTMXTileGroup

-(id)initWithDictionary:(NSDictionary *)dict tileset:(PPTileset *)tileset
{
    if (self=[super init]) {
        if (CFByteOrderGetCurrent() == CFByteOrderBigEndian) shouldSwapBytesToCorrectEndianness = YES;
        int wid = [[dict objectForKey:@"width"] intValue];
        int hei = [[dict objectForKey:@"height"] intValue];
        self.mapSize = CGSizeMake(wid, hei);
        mapData = [[dict objectForKey:@"data"] copy];
        mapTile = (unsigned int *)[mapData bytes];
        
        _tileset = tileset;
        _tileSize = CGSizeMake(self.tileset.tileSize.width/self.tileset.scale,self.tileset.tileSize.height/self.tileset.scale);
        
        _numberOfQuads = (self.mapSize.width)*(self.mapSize.height);
        tileQuad = malloc(sizeof(Quad)*_numberOfQuads);
        textureQuad = malloc(sizeof(Quad)*_numberOfQuads);
        
        wid=self.mapSize.width;
        hei=self.mapSize.height;
        for (int x=0;x<wid;x++) {
            for (int y=0;y<hei;y++) {
                int i = y*wid+x;
                CGPoint coords = CGPointMake(x, y);
                tileQuad[i] = [self quadForTileAtMapCoords:coords];
                unsigned int tile = [self tileAtMapCoords:coords];
                if (tile > 0) {
                    textureQuad[i] = [self.tileset normalizedQuadForTile:tile];
                }
                //quadIndex[i*2] = i*2;
                //quadIndex[i*2+1] =
            }
        }
    }
    return self;
}

-(CGPoint)worldToMapCoords:(CGPoint)coords
{
    return CGPointMake(coords.x/self.tileSize.width, coords.y/self.tileSize.height);
}

-(CGPoint)mapToWorldCoords:(CGPoint)coords
{
    return CGPointMake(coords.x*self.tileSize.width, coords.y*self.tileSize.height);
}

-(Quad)quadForTileAtMapCoords:(CGPoint)coords
{
    int x=coords.x,y=coords.y;
    int tileWid=self.tileSize.width,tileHei=self.tileSize.height;
    int realx=x*tileWid,realy=y*tileHei;
    Quad q;
    q.x1 = realx; q.y1 = realy;
    q.x2 = realx; q.y2 = realy+tileHei;
    q.x3 = realx+tileWid; q.y3 = realy+tileHei;
    q.x4 = realx+tileWid; q.y4 = realy;
    return q;
}

-(unsigned int)tileAtMapCoords:(CGPoint)coords
{
    int x=coords.x,y=coords.y;
    unsigned int dat = mapTile[y*(int)self.mapSize.width+x];
    if (shouldSwapBytesToCorrectEndianness) dat = CFSwapInt32(dat);
    return dat;
}

-(Quad *)quads
{
    return tileQuad;
}

-(Quad *)textureQuads
{
    return textureQuad;
}

-(CGSize)sizeBeforeTransformations
{
    return CGSizeMake(self.mapSize.width*self.tileSize.width,self.mapSize.height*self.tileSize.height);
}

-(void)dealloc
{
    free(tileQuad);
    free(textureQuad);
}
@end
