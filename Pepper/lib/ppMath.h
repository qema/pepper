//
//  ppMath.h
//  Pepper
//
//  Created by Andrew Wang on 6/12/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#ifndef Pepper_ppMath_h
#define Pepper_ppMath_h

#define CGPointAdd(a,b) CGPointMake((a.x)+(b.x),(a.y)+(b.y))
#define CGPointSub(a,b) CGPointMake((a.x)-(b.x),(a.y)-(b.y))
#define CGPointMult(v,c) CGPointMake((v.x)*(c),(v.y)*(c))
#define CGPointDiv(v,c) CGPointMake((v.x)/(c),(v.y)/(c))

#endif
