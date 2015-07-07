//
//  Header.h
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#ifndef CarsHelp_Header_h
#define CarsHelp_Header_h
//定义宏
/**
 *  导航栏高度
 */
#define NAVGATION_HEIGHT 44
/**
 *  状态栏+导航栏高度
 */

#define NAVGATION_ADD_STATUSBAR_HEIGHT 64


/**
 *  屏幕宽度
 */

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  屏幕高度
 */

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/**
 *  tabBar的高度
 */
#define TABBAR_HEIGHT 49
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#endif
