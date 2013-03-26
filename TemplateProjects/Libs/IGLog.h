//
//  IGLog.h
//  iPadAdBanners
//
//  Created by Pedro Valentini on 14/02/11.
//  Copyright 2011 Infoglobo. All rights reserved.
//
//
//  COMO USAR:
//
//  1. Definir em Project > Build Settings > Preprocessor Macros
//  O Nivel, por exemplo: IGMAXLOGLEVEL=IGLOGLEVEL_DEBUG
//  E modo de debug: DEBUG
//
//  2. Adicionar o import no Projeto-Prefix.pch: #include "IGLog.h"
//
//

#define IGLOGLEVEL_DEBUG    5
#define IGLOGLEVEL_INFO     4
#define IGLOGLEVEL_WARN		3
#define IGLOGLEVEL_ERROR    2
#define IGLOGLEVEL_FATAL    1
    
#ifndef IGMAXLOGLEVEL
#define IGMAXLOGLEVEL IGLOGLEVEL_WARN
#endif

// The general purpose logger. This ignores logging levels.
#ifdef DEBUG
#define IGDPRINT(xx, ...)  NSLog(@"" xx, ##__VA_ARGS__)
	//NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define IGDPRINT(xx, ...)  ((void)0)
#endif // #ifdef DEBUG


// Log-level based logging macros.
#if IGLOGLEVEL_FATAL <= IGMAXLOGLEVEL
#define IGFATAL(xx, ...)  IGDPRINT(xx, ##__VA_ARGS__)
#else
#define IGFATAL(xx, ...)  ((void)0)
#endif // #if IGLOGLEVEL_FATAL <= IGMAXLOGLEVEL

#if IGLOGLEVEL_ERROR <= IGMAXLOGLEVEL
#define IGERROR(xx, ...)  IGDPRINT(xx, ##__VA_ARGS__)
#else
#define IGERROR(xx, ...)  ((void)0)
#endif // #if IGLOGLEVEL_ERROR <= IGMAXLOGLEVEL

#if IGLOGLEVEL_WARN <= IGMAXLOGLEVEL
#define IGWARN(xx, ...)  IGDPRINT(xx, ##__VA_ARGS__)
#else
#define IGWARN(xx, ...)  ((void)0)
#endif // #if IGLOGLEVEL_WARN <= IGMAXLOGLEVEL

#if IGLOGLEVEL_INFO <= IGMAXLOGLEVEL
#define IGINFO(xx, ...)  IGDPRINT(xx, ##__VA_ARGS__)
#else
#define IGINFO(xx, ...)  ((void)0)
#endif // #if IGLOGLEVEL_INFO <= IGMAXLOGLEVEL

#if IGLOGLEVEL_DEBUG <= IGMAXLOGLEVEL
#define IGDEBUG(xx, ...)  IGDPRINT(xx, ##__VA_ARGS__)
#else
#define IGDEBUG(xx, ...)  ((void)0)
#endif // #if IGLOGLEVEL_DEBUG <= IGMAXLOGLEVEL
