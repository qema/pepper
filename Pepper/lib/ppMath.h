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
#define CGPointMult(a,b) CGPointMake((a.x)*(b.x),(a.y)*(b.y))
#define CGPointDiv(a,b) CGPointMake((a.x)/(b.x),(a.y)/(b.y))

#define CGPointAddScalar(a,v) CGPointMake((a.x)+(v),(a.y)+(v))
#define CGPointSubScalar(a,v) CGPointMake((a.x)-(v),(a.y)-(v))
#define CGPointMultScalar(a,v) CGPointMake((a.x)*(v),(a.y)*(v))
#define CGPointDivScalar(a,v) CGPointMake((a.x)/(v),(a.y)/(v))

#endif
