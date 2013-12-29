logView
=======

辅助日志输出器

使用方法：
在项目pch中加入宏
#define NSLog(...) {NSLog(__VA_ARGS__);[[NSNotificationCenter defaultCenter]postNotificationName:@"loginView" object:[NSString stringWithFormat:__VA_ARGS__]];}
