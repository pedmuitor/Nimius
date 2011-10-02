//
//  NIMEMacros.h
//  NimEngine
//
//  Created by Pedro Muiños Tortajada on 01/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//----------------
// RELEASE SAFELY MACRO
//----------------
#define NIME_RELEASE_SAFETY(instance_ptr) [instance_ptr release],instance_ptr = nil;

//----------------
// LOG MACROS
//----------------
#if !defined(NIME_DEBUG) || NIME_DEBUG == 0
#define NIME_DLOG(...)
#define NIME_ELOG(...)
#define NIME_MLOG(...)

#elif NIME_DEBUG == 1
#define NIME_DLOG(...) NSLog((@"DEBUG: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define NIME_ELOG(...) NSLog((@"ERROR: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define NIME_MLOG(...)

#elif NIME_DEBUG >1 1
#define NIME_DLOG(...) NSLog((@"DEBUG: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define NIME_ELOG(...) NSLog((@"ERROR: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define NIME_MLOG(...) NSLog((@"MESSAGE: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif