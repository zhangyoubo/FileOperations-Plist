//
//  ViewController.m
//  file
//
//  Created by 张友波 on 15/9/6.
//  Copyright (c) 2015年 zf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //*****************普通文件操作***************************//
//    [self createFile];
//    [self writeFile];
//    [self readFile];
//    [self fileAttriutes];
//    [self deleteFile];
//    
//    //*************以plist为存储空间的文件操作******************
// 
//    [self writeAndreadPlistFile];
//    
//    //************属性化列表存储(plist在appName目录下)*********
//    
//    [self xmlFileOpe];
//    
    //************持久化存储之归档与反归档*********
    
    [self startArchiverAndUnArchiver];
    
}

-(void)startArchiverAndUnArchiver
{
    NSString *documentsPath =[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"archiver"];
   // NSString *testPath = [testDirectory stringByAppendingPathComponent:@"archiver.txt"];
    
    Person *person=[[Person alloc] initWithName:@"zyb" phone:@"123" age:20];
    //归档
    NSMutableData *data=[NSMutableData data];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:person forKey:@"per"];
    [archiver finishEncoding];
    [data writeToFile:testDirectory atomically:YES];
    
    //反归档
    NSMutableData *Undata=[[NSMutableData alloc] initWithContentsOfFile:testDirectory];
    NSKeyedUnarchiver *Unarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:Undata];
    Person *p=[Unarchiver decodeObjectForKey:@"per"];
    NSLog(@"name=%@,Phone=%@,age=%ld",p.name,p.Phone,p.age);
}

-(void)writeAndreadPlistFile
{
    NSString *str=@"zhangyoubo";
    [str writeToFile:[self getSettingFilePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSString *test=[[NSString alloc] initWithContentsOfFile:[self getSettingFilePath] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",test);
}
- (NSString *)getSettingFilePath
{
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSString *writablePath;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentPath=[paths objectAtIndex:0] ;
    writablePath = [documentPath stringByAppendingPathComponent:@"1.plist"];
    NSLog(@"%@",writablePath);
    if(![fileManager fileExistsAtPath:writablePath])
    {
        [fileManager createFileAtPath:writablePath contents:nil attributes:nil];
    }
    
    return writablePath;
}

//写文件
-(void)writeFile{
    NSString *documentsPath =[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
    NSString *content=@"测试写入内容!";
    BOOL res=[content writeToFile:testPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"文件写入成功");
    }else
        NSLog(@"文件写入失败");
    
}

//读文件
-(void)readFile{
    NSString *documentsPath =[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
    NSString *content=[NSString stringWithContentsOfFile:testPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"文件读取成功: %@",content);
}

//**************获取IOS四种常用的沙盒目录方法**************

//获取应用沙盒根目录
-(void)dirHome{
    NSString *dirHome=NSHomeDirectory();
    NSLog(@"app_home: %@",dirHome);
}

//获取Documents目录
-(NSString *)dirDoc{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_doc: %@",documentsDirectory);
    return documentsDirectory;
}

//获取Library目录 (存储程序的默认设置或其它状态信息)
-(void)dirLib{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_lib: %@",libraryDirectory);
}

//获取Cache目录 (存放缓存文件)
-(void)dirCache{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSLog(@"app_home_lib_cache: %@",cachePath);
}

//获取Tmp目录 (存放临时文件)
-(void)dirTmp{
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSLog(@"app_home_tmp: %@",tmpDirectory);
}
//**************获取IOS四种常用的沙盒目录方法**************


//创建文件夹及文件
-(void)createFile{
    NSString *documentsPath =[self dirDoc];//获取Documents目录
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
    BOOL ret=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    if (ret) {
         NSLog(@"文件夹创建成功: %@" ,testDirectory);
    }else{
         NSLog(@"文件夹创建失败");
    }
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
    BOOL res=[fileManager createFileAtPath:testPath contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功: %@" ,testPath);
    }else
        NSLog(@"文件创建失败");
}

//文件属性
-(void)fileAttriutes{
    NSString *documentsPath =[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:testPath error:nil];
    NSArray *keys;
    id key, value;
    keys = [fileAttributes allKeys];
    NSInteger count = [keys count];
    for (NSInteger i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [fileAttributes objectForKey: key];
        NSLog (@"Key: %@ for value: %@", key, value);
    }
}

//删除文件
-(void)deleteFile{
    NSString *documentsPath =[self dirDoc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
    BOOL res=[fileManager removeItemAtPath:testPath error:nil];
    if (res) {
        NSLog(@"文件删除成功");
    }else
        NSLog(@"文件删除失败");
    NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:testPath]?@"YES":@"NO");
}

//属性化列表存储(plist在appName目录下)
-(void)xmlFileOpe
{
    NSUserDefaults *userdefaults =[NSUserDefaults standardUserDefaults];
    
    [userdefaults setObject:@"2014-10-10" forKey:@"lastupdate"];
    [userdefaults setObject:@"doubleicon" forKey:@"username"];
    [userdefaults setInteger:10 forKey:@"cache"];
    [userdefaults setObject:@"123456" forKey:@"password"];
    
    [userdefaults synchronize];
    
    [userdefaults removeObjectForKey:@"password"];
    [NSUserDefaults resetStandardUserDefaults];
    
    
    NSString*lastupdate=[userdefaults objectForKey:@"lastupdate"];
    NSString *username=[userdefaults objectForKey:@"username"];
    NSString *cache=[userdefaults objectForKey:@"cache"];
    NSString *password=[userdefaults objectForKey:@"password"];
    
    NSLog(@"lastupdate=%@,username=%@,cache=%@,password=%@",lastupdate,username,cache,password);
    
    
    //获取应用程序沙盒
    NSArray *libraryArray =NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *librarypath =[libraryArray objectAtIndex:0];
    NSString *destpath =[[librarypath stringByAppendingString:@"/Preferences"] stringByAppendingPathComponent:@"my.plist"];
    
    NSMutableDictionary *hobbyDic =[[NSMutableDictionary alloc] initWithContentsOfFile:destpath];
    if(hobbyDic==nil){//判断是否督导值
        hobbyDic =[[NSMutableDictionary alloc] init];
    }
    [hobbyDic setObject:@"20" forKey:@"grade"];
    [hobbyDic writeToFile:destpath atomically:YES];//保存
    NSMutableDictionary *savedDic =[[NSMutableDictionary alloc] initWithContentsOfFile:destpath];
    NSLog(@"以保存过的数据:%@",savedDic);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
