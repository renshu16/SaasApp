//
//  Debug.h
//  SaasApp
//
//  Created by ToothBond on 15/11/9.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#ifndef Debug_h
#define Debug_h


#endif /* Debug_h */


#ifdef DEBUG

#define DEBUG_NSLOG(format, ...) NSLog(format, ## __VA_ARGS__)
#define DEBUG_FUNC  DEBUG_NSLOG(@"%s",__func__);
#define DEBUGTAG
#else

#define DEBUG_NSLOG(format, ...)
#define DEBUG_FUNC
#define DEBUGTAG        cur is release mod please del this tag
#endif
