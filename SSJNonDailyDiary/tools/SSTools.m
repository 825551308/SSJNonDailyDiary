//
//  SSTools.m
//  waterPro
//
//  Created by jssName on 16/1/22.
//  Copyright © 2016年 HD. All rights reserved.
//

#import "SSTools.h"
#include <CommonCrypto/CommonDigest.h>

@implementation SSTools

+ (void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((width - LabelSize.width - 20)/2, height - 100, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:1.5 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

//返回日期对象 直接调用[comps year],[comps month]
+ (NSDateComponents *)returnNSDateComponents{
    
    NSDate *now;
    now=[NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:now];
    
    return comps;
}




//返回年月日时分秒格式的日期根据你传进来的格式
+ (NSString *)returnTodayDateForYour_FormatString:(NSString *)_formatStr
{
    NSDateComponents *comps=[self returnNSDateComponents];
    long year=[comps year];
    long month1=[comps month];
    long day1=[comps day];
    long hour1=(long)[comps hour];
    long min1=(long)[comps minute];
    long sec1=(long)[comps second];
    NSString *month;
    if(month1<=9){
        month=[NSString stringWithFormat:@"0%ld",month1];
    }else{
        month=[NSString stringWithFormat:@"%ld",month1];
    }
    NSString *day;
    if(day1<=9){
        day=[NSString stringWithFormat:@"0%ld",day1];
    }else{
        day=[NSString stringWithFormat:@"%ld",day1];
    }
    NSString *hour;
    if(hour1<=9){
        hour=[NSString stringWithFormat:@"0%ld",hour1];
    }else{
        hour=[NSString stringWithFormat:@"%ld",hour1];
    }
    NSString *min;
    if(min1<=9){
        min=[NSString stringWithFormat:@"0%ld",min1];
    }else{
        min=[NSString stringWithFormat:@"%ld",min1];
    }
    NSString *sec;
    if(sec1<=9){
        sec=[NSString stringWithFormat:@"0%ld",sec1];
    }else{
        sec=[NSString stringWithFormat:@"%ld",sec1];
    }
    NSString *yearStr=[NSString stringWithFormat:@"%ld",year];
    NSString *voiceDateName=[NSString stringWithFormat:_formatStr,yearStr,month,day,hour,min,sec];
    return voiceDateName;
}


//单独计算图片的高度
+ (CGFloat)heightForImage:(UIImage *)image
{
    //(2)获取图片的大小
    CGSize size = image.size;
    //(3)求出缩放比例
    CGFloat scale = screen_width / size.width;
    CGFloat imageHeight = size.height * scale;
    return imageHeight;
}
//单独计算文本的高度
+ (CGFloat)heightForText:(NSString *)text size:(CGFloat)_size
{
    //设置计算文本时字体的大小,以什么标准来计算
    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:_size]};
    
    //    NSString *t1=@"市城投集团冯国明董事长一行至集团调研指导工作";
    //    NSString *t2=@"水务集团圆满确保“云栖大会”期间供水安全优质";
    //    DLog(@"t1-----%f",[t1 boundingRectWithSize:CGSizeMake(320-30, 20000.0f) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height);
    //    DLog(@"t2-----%f",[t2 boundingRectWithSize:CGSizeMake(320-20, 20000.0f) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height);
    
    return [text boundingRectWithSize:CGSizeMake(320-20, 20000.0f) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height;
}
//单独计算文本的宽度
+ (CGFloat)widthForText:(NSString *)text size:(CGFloat)_size
{
    //设置计算文本时字体的大小,以什么标准来计算
    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:_size]};
    
    //    NSString *t1=@"市城投集团冯国明董事长一行至集团调研指导工作";
    //    NSString *t2=@"水务集团圆满确保“云栖大会”期间供水安全优质";
    //    DLog(@"t1-----%f",[t1 boundingRectWithSize:CGSizeMake(320-30, 20000.0f) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height);
    //    DLog(@"t2-----%f",[t2 boundingRectWithSize:CGSizeMake(320-20, 20000.0f) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height);
    
    return [text boundingRectWithSize:CGSizeMake(320-20, 20000.0f) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.width;
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


//画圆形头像
+ (void)buildCircleImageView:(UIImageView *)imageView  view:(UIView *)_view{
    //画成圆圈头像
    //告诉layer位于它下面的layer都遮挡住
    imageView.layer.masksToBounds=YES;
    //设置layer的圆角，刚好是自身宽度的一半，这样就形成来圆
    imageView.layer.cornerRadius=imageView.bounds.size.width*0.5;
    //设置边框宽度为20
    imageView.layer.borderWidth=0.5;
    //设置边框颜色
    imageView.layer.borderColor=[UIColor grayColor].CGColor;
    UIDynamicAnimator *animator=[[UIDynamicAnimator alloc]initWithReferenceView:_view];
    UIGravityBehavior *gravity=[[UIGravityBehavior alloc]init];
    UICollisionBehavior *collider=[[UICollisionBehavior alloc]init];
    [animator addBehavior:gravity];
    [animator addBehavior:collider];
    id <UIDynamicItem> item1=_view;
    [collider addItem:item1];
    [gravity addItem:item1];
    
    
}

+ (void)buildCircleImageView:(UIImageView *)imageView  view:(UIView *)_view wid:(float)widFloat{
    //画成圆圈头像
    //告诉layer位于它下面的layer都遮挡住
    imageView.layer.masksToBounds=YES;
    //设置layer的圆角，刚好是自身宽度的一半，这样就形成来圆
    imageView.layer.cornerRadius=widFloat;
    //设置边框宽度为20
    imageView.layer.borderWidth=0.5;
    //设置边框颜色
    imageView.layer.borderColor=[UIColor grayColor].CGColor;
    UIDynamicAnimator *animator=[[UIDynamicAnimator alloc]initWithReferenceView:_view];
    UIGravityBehavior *gravity=[[UIGravityBehavior alloc]init];
    UICollisionBehavior *collider=[[UICollisionBehavior alloc]init];
    [animator addBehavior:gravity];
    [animator addBehavior:collider];
    id <UIDynamicItem> item1=_view;
    [collider addItem:item1];
    [gravity addItem:item1];
    
    
}


//100*100
+ (UIImage *)imgYaSuo_100:(UIImage *)_img{
    if(_img.size.height<_img.size.width){
        //横拍
        //            [image drawInRect:CGRectMake(0,0,800, image.size.height/(image.size.width/800) )];
        //            /设置image的尺寸
        CGSize imagesize = _img.size;
        
        imagesize.height =_img.size.height/(_img.size.width/100);
        
        imagesize.width =100;
        
        _img = [self imageWithImage:_img scaledToSize:imagesize];
        
    }else{
        //竖拍
        //设置image的尺寸
        
        CGSize imagesize = _img.size;
        
        imagesize.height =100;
        
        imagesize.width =_img.size.width/(_img.size.height/100);
        
        _img = [self imageWithImage:_img scaledToSize:imagesize];
        
    }
    return  _img;
}
+ (UIImage *)imgYaSuo_800:(UIImage *)_img{
    if(_img.size.height<_img.size.width){
        //横拍
        //            [image drawInRect:CGRectMake(0,0,800, image.size.height/(image.size.width/800) )];
        //            /设置image的尺寸
        CGSize imagesize = _img.size;
        
        imagesize.height =_img.size.height/(_img.size.width/800);
        
        imagesize.width =800;
        
        _img = [self imageWithImage:_img scaledToSize:imagesize];
        
    }else{
        //竖拍
        //设置image的尺寸
        
        CGSize imagesize = _img.size;
        
        imagesize.height =800;
        
        imagesize.width =_img.size.width/(_img.size.height/800);
        
        _img = [self imageWithImage:_img scaledToSize:imagesize];
        
    }
    return  _img;
}
//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}





/** md5 一般加密 */

+ ( NSString *)md5String:( NSString *)str

{
    
    const char *myPasswd = [str UTF8String ];
    
    unsigned char mdc[ 16 ];
    
    CC_MD5 (myPasswd, ( CC_LONG ) strlen (myPasswd), mdc);
    
    NSMutableString *md5String = [ NSMutableString string ];
    
    for ( int i = 0 ; i< 16 ; i++) {
        
        [md5String appendFormat : @"%02x" ,mdc[i]];
        
    }
    
    return md5String;
    
}
#define CHUNK_SIZE 1024*1024*5
+ (NSString*)fileMD5:(NSString*)pathStr
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:pathStr];
    if( handle== nil ) return @"ERROR GETTING FILE MD5"; // file didnt exist
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: CHUNK_SIZE ];
        CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}


#define FileHashDefaultChunkSizeForReadingData 1024*8
+(NSString*)getFileMD5WithPath:(NSString*)path

{
    
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path, FileHashDefaultChunkSizeForReadingData);
    
}



CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,size_t chunkSizeForReadingData) {
    
    // Declare needed variables
    
    CFStringRef result = NULL;
    
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    
    CFURLRef fileURL =
    
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  
                                  (CFStringRef)filePath,
                                  
                                  kCFURLPOSIXPathStyle,
                                  
                                  (Boolean)false);
    
    if (!fileURL) goto done;
    
    // Create and open the read stream
    
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            
                                            (CFURLRef)fileURL);
    
    if (!readStream) goto done;
    
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    
    CC_MD5_CTX hashObject;
    
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    
    if (!chunkSizeForReadingData) {
        
        chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
        
    }
    
    // Feed the data to the hash object
    
    bool hasMoreData = true;
    
    while (hasMoreData) {
        
        uint8_t buffer[chunkSizeForReadingData];
        
        CFIndex readBytesCount = CFReadStreamRead(readStream,(UInt8 *)buffer,(CFIndex)sizeof(buffer));
        
        if (readBytesCount == -1) break;
        
        if (readBytesCount == 0) {
            
            hasMoreData = false;
            
            continue;
            
        }
        
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
        
    }
    
    // Check if the read operation succeeded
    
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    
    if (!didSucceed) goto done;
    
    // Compute the string result
    
    char hash[2 * sizeof(digest) + 1];
    
    for (size_t i = 0; i < sizeof(digest); ++i) {
        
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
        
    }
    
    result = CFStringCreateWithCString(kCFAllocatorDefault,(const char *)hash,kCFStringEncodingUTF8);
    
    
    
done:
    
    if (readStream) {
        
        CFReadStreamClose(readStream);
        
        CFRelease(readStream);
        
    }
    
    if (fileURL) {
        
        CFRelease(fileURL);
        
    }
    
    return result;
    
}

//根据传进来的字节返回大小
+(NSString *)sizeValue:(float)size{
    if (size>1024*1024*1024) {//G
        float val = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%0.2fG",val];
    }else if (size>(1024*1024)) {//M
        float val = size/(1024*1024);
        return [NSString stringWithFormat:@"%0.2fM",val];
    }else if (size>1024) {//KB
        float val = size/1024;
        return [NSString stringWithFormat:@"%0.2fKB",val];
    }else{//B
        if (size > 0) {
            return [NSString stringWithFormat:@"%0.2fB",size];
        }
        return @"0B";
    }

}

//字典转json字符串
+(NSString *)JsonModel:(NSDictionary *)dictModel
{
    if ([NSJSONSerialization isValidJSONObject:dictModel])
    {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictModel options:NSJSONWritingPrettyPrinted error:nil];
        NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return nil;
}


//时间戳转字符串 @"YYYY-MM-dd"
+ (NSString *)returnDataStrWithString:(NSString *)time formateStr:(NSString *)formateStr{
    NSString *timeformateStr = formateStr.length > 0 ? (formateStr):(@"MM/dd hh:mm");
////    NSString *time = [NSString stringWithFormat:@%@,[[dateListobjectAtIndex:indexPath.row]gradeDate]];
//    
//    NSInteger num = [time integerValue]/1000 ;
//   
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    
////    [formatter setDateStyle:NSDateFormatterMediumStyle];
////    
////    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    
//    [formatter setDateFormat:timeformateStr];
//    
//    NSTimeZone* gTMzone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:gTMzone];
//    
//    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];
//    NSString*confromTimespStr = [formatter stringFromDate:confromTimesp];
//    
//    return confromTimespStr;

    NSTimeInterval times = [time floatValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:times];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:timeformateStr];
    NSTimeZone* gTMzone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [format setTimeZone:gTMzone];
        return [format stringFromDate:date];
    
    
}

#pragma mark - 将某个时间戳转化成 时间

+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSLog(@"1296035591  = %@",confromTimesp);
    
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    
    
    return confromTimespStr;
    
}



//判断时间差几天
+ (NSInteger)getDifferenceByDate:(NSString *)date {
//    //获得当前时间
//    NSDate *now = [NSDate date];
    /*获得当前日期*/
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    NSDate *currentDate = [dateformatter dateFromString:locationString];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *oldDate = [dateFormatter dateFromString:date];
    
    
    
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:oldDate  toDate:currentDate  options:0];
    return [comps day];
}




+ (BOOL)isChinese:(NSString *)str
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}

+ (BOOL)includeChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++)
    {
        int a =[str characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

/**
 *  颠倒顺序 数组
 */
+ (NSMutableArray *)transposeArray:(NSArray *)array{
    NSMutableArray *arr = [array mutableCopy];
    for (int i = 0; i<array.count/2.0; i++) {
        [arr exchangeObjectAtIndex:i withObjectAtIndex:arr.count-1-i];
    }
    return arr;
}

/**
 *  替换指定字符附件区间的字符串
 *  比如"dss<div>g<div><b>To:</b><div><b> zju"  想要替换To:附件的前后<div>之间的所有内容 变成“dss<div>g<b> zju”
 *  @param oldString 原字符串
 *  @param rep       指定字符串
 *  @param searchFromString       前一个匹配搜索字符串
 *  @param searchToString       后一个匹配搜索字符串
 *  @param replaceWithString       需要替换的字符串
 *
 *  @return 返回替换后的字符串
 */
+ (NSString *)replaceWithOldString:(NSString *)oldString  rep:(NSString *)rep searchFromString:(NSString *)searchFromString
                    searchToString:(NSString *)searchToString  replaceWithString:(NSString *)replaceWithString{
    //    NSString *a = @"dss<div>gt;<div><b>To:</b><div><b> zju";
    NSArray *fromArr = [oldString componentsSeparatedByString:rep];
    if (fromArr.count > 1) {
        //说明有这个节点
        //查找紧挨着的上一个"searchFromString"
        NSString *lastIndexStr = [self searchCharFromString:fromArr[0] searChar:searchFromString].lastObject;
        NSString *lastStr = fromArr[0];
        NSString *nextIndexStr = [self searchCharFromString:fromArr[1] searChar:searchToString].firstObject;//第二段内容的第一个匹配位置
        //bbb:  第二段未知的佩佩字符串起始位置＋匹配字符串长度 即为第二段文字的位置 再加上前一段的内容长度和分割字符rep，即为整个字符串需要匹配的末尾字符在整个字符串里的位置
        float bbb = [nextIndexStr floatValue] + searchToString.length + lastStr.length + rep.length;
        return [oldString stringByReplacingCharactersInRange:NSMakeRange([lastIndexStr floatValue], bbb  - [lastIndexStr floatValue]) withString:@""];
    }else{
        return oldString;
    }
    
}
//搜索指定的字符串   并返回所搜到的所有位置集合
+ (NSMutableArray *)searchCharFromString:(NSString *)searchStrSource  searChar:(NSString *)searChar{
    NSMutableArray *searIndexMuArray = [NSMutableArray new];
    NSString *temp = nil;
    for(int i =0; i < [searchStrSource length]; i++)
    {
        if (searchStrSource.length - i > searChar.length) {
            temp = [searchStrSource substringWithRange:NSMakeRange(i, searChar.length)];
            if ([temp isEqualToString:searChar]) {
                NSLog(@"第%d个字是:%@", i, temp);
                [searIndexMuArray addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
    }
    return searIndexMuArray;
}


/**
 *  将数组元素拆分，用charValue隔开 组成一个全新的字符串并返回该字符串
 *
 *  @param arr 数组
 *
 *  @return 返回拼接好的字符串
 */
+ (NSString *)stringFromMutable:(NSMutableArray *)arr cutApartWithChar:(NSString *)charValue{
    NSString *endStr = @"";
    for (int i = 0 ; i < arr.count; i++) {
        NSString *eveStr = [NSString stringWithFormat:@"%@",arr[i]];
//        //按"<"分组
//        NSArray *arr = [eveStr componentsSeparatedByString:@"<"];
//        if (arr.count > 1) {
//            NSString *endStr = arr[1];
//            NSString *toTextViewStr = [endStr substringToIndex:endStr.length-1];
//            eveStr = toTextViewStr;
//        }
        
        if (i == 0) {
            endStr = eveStr;
        }else{
            endStr = [NSString stringWithFormat:@"%@%@%@",endStr,charValue,eveStr];
        }
    }
    return endStr;
}


+ (UIBarButtonItem *)createBarButtonItem:(id)sender WithTitleName:(NSString *)titleName withTitleColor:(UIColor *)titleColor withSelName:(NSString *)selName{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 60, 40)];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [button setTitle:titleName forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    SEL SelForBarButtonItemSel = NSSelectorFromString(selName);
    if (sender) {
        [button addTarget:sender action:SelForBarButtonItemSel forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barItem;
}



/** 如果为12小时制 就在小时后面+12 */
+ (NSString *)dealWithTime:(NSString *)time{
    if ([self kWhether12Hour]) {
        NSInteger t =  [[time substringToIndex:2] integerValue] + 12;
        NSString *timeEnd = [time substringFromIndex:2];
        if (t > 24) {
            t = t % 24 ;
            time = [NSString stringWithFormat:@"%ld",(long)t];
        }else{
            time = [NSString stringWithFormat:@"%ld",(long)t];
        }
        time = [time stringByAppendingString:timeEnd];
    }
    return time;
}

/** 判断是否12小时制，YES为12小时制 */
+ (BOOL)kWhether12Hour{
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    
    BOOL hasAMPM = containsA.location != NSNotFound;
    return hasAMPM;
}

//根据时间戳获取星期几
+ (NSString *)getWeekDayFordate:(long long)data
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:newDate];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

//获得当前viewControll
+(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        
        NSLog(@"===%@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}

@end
