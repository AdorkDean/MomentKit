//
//  MomentUtil.m
//  MomentKit
//
//  Created by LEA on 2019/2/1.
//  Copyright © 2019 LEA. All rights reserved.
//

#import "MomentUtil.h"

@implementation MomentUtil

#pragma mark - 初始化
+ (void)initMomentData
{
    NSInteger count = [[MUser findAll] count];
    if (count > 0) {
        return;
    }
    // 名字
    NSArray * names = @[@"刘瑾",@"陈哲轩",@"安鑫",@"欧阳沁",@"韩艺",@"宋铭",@"童璐",@"祝子琪",@"林霜",@"赵星桐"];
    // 头像网络图片
    
    NSArray * images = @[@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2633478757,1609564776&fm=26&gp=0.jpg",
                         @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=61465521,1969244909&fm=26&gp=0.jpg",
                         @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4000299605,1917436436&fm=27&gp=0.jpg",
                         @"http://img1.imgtn.bdimg.com/it/u=3409408983,232289470&fm=26&gp=0.jpg",
                         @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=703227009,4280079683&fm=26&gp=0.jpg",
                         @"http://img4.imgtn.bdimg.com/it/u=1954008455,2270367419&fm=26&gp=0.jpg",
                         @"http://img3.imgtn.bdimg.com/it/u=2258371767,2618967988&fm=26&gp=0.jpg",
                         @"http://img0.imgtn.bdimg.com/it/u=1408188170,2359624570&fm=26&gp=0.jpg",
                         @"http://b-ssl.duitang.com/uploads/item/201711/06/20171106232540_4YdTr.jpeg",
                         @"http://img4.imgtn.bdimg.com/it/u=1841528288,1473396218&fm=26&gp=0.jpg"];
    // 内容
    NSArray * contents = @[@"鹟是一种身体小，嘴稍扁平，基部有许多刚毛，脚短小的益鸟。",
                           @"画家把她描绘成一个临江而立的忧伤女子。🔥🔥",
                           @"不要以为这是👉白浅上神👈，这只是一只可爱的文须雀。",
                           @"这种鸟上体棕黄色，翅黑色具白色翅斑，外侧尾羽白色。",
                           @"这是一只胖胖的剪嘴鸥，作者以黑白红三种分明的颜色描绘她，其实很符合剪嘴鸥的形象。",
                           @"这是网上很火的一个孤影夕阳红的故事，一只白鹭立与夕阳下的湖泊，红色的夕阳把一切都染上了一层绯红。",
                           @"“不要脸”画家呼葱觅蒜再出新作，以飞鸟为材画出仙侠新境界。",
                           @"蜀绣又名“川绣”，是在丝绸或其他织物上采用蚕丝线绣出花纹图案的中国传统工艺",
                           @"昨夜雨疏风骤，浓睡不消残酒。试问卷帘人，却道海棠依旧。知否，知否？应是绿肥红瘦。",
                           @"安利我喜欢的插画师：晓艺大佬。"];
    
    // 用户 ↓↓
    NSInteger max = [names count];
    Comment * formerComment = nil; // 前一个
    for (NSInteger i = 0; i < max; i ++)
    {
        // 用户
        MUser * user = [[MUser alloc] init];
        user.name = [names objectAtIndex:i];
        user.portrait = [images objectAtIndex:i];
        [user save];
        // 消息
        Message * message = [[Message alloc] init];
        message.time = 1549162615;
        message.userName = [names objectAtIndex:i];
        message.userPortrait = [images objectAtIndex:i];
        message.content = [contents objectAtIndex:i];
        [message save];
        // 评论
        Comment * comment = [[Comment alloc] init];
        comment.text = [contents objectAtIndex:i];
        if (i == 0) {
            comment.fromId = arc4random() % 10 + 1;
            comment.toId = 0;
        } else {
            NSInteger fromId = arc4random() % 10 + 1;
            if (fromId == formerComment.fromId) {
                comment.fromId = fromId;
                comment.toId = 0;
            } else {
                comment.fromId = fromId;
                comment.toId = formerComment.fromId;
            }
        }
        [comment save];
        formerComment = comment;
        // 图片
        MPicture * picture = [[MPicture alloc] init];
        picture.thumbnail = [images objectAtIndex:i];
        [picture save];
    }
    
    // 当前用户
    MUser * user = [[MUser alloc] init];
    user.name = @"LEA";
    user.type = 1;
    [user save];
    
    // 位置
    MLocation * location = [[MLocation alloc] init];
    location.position = @"杭州 · 雷峰塔景区";
    location.landmark = @"雷峰塔景区";
    location.address = @"杭州市西湖区南山路15号";
    location.latitude = 30.231250;
    location.longitude = 120.148550;
    [location save];
    
    // 动态  ↓↓
    for (int i = 0; i < 35; i ++)
    {
        // 动态
        Moment * moment = [[Moment alloc] init];
        moment.userId = arc4random() % 10 + 1;
        moment.likeIds = [MomentUtil getIdsByMaxPK:arc4random() % 10 + 1];
        moment.commentIds = [MomentUtil getIdsByMaxPK:arc4random() % 10 + 1];
        moment.pictureIds = [MomentUtil getIdsByMaxPK:arc4random() % 9 + 1];
        moment.time = 1549162615;
        moment.singleWidth = 640;
        moment.singleHeight = 506;
        moment.isLike = 0;
        if (i == 0) {
            moment.text = @"“不要脸”画家呼葱觅蒜再出新作，以飞鸟为材画出仙侠新境界。详见链接：https://baijiahao.baidu.com/s?id=1611814670460612719&wfr=spider&for=pc";
        } else if (i % 3 == 0) {
            moment.text = @"蜀绣又名“川绣”，是在丝绸或其他织物上采用蚕丝线绣出花纹图案的中国传统工艺，主要指以四川成都为中心的川西平原一带的刺绣。蜀绣最早见于西汉的记载，当时的工艺已相当成熟，同时传承了图案配色鲜艳、常用红绿颜色的特点。蜀绣又名“川绣”，是在丝绸或其他织物上采用蚕丝线绣出花纹图案的中国传统工艺，主要指以四川成都为中心的川西平原一带的刺绣。蜀绣最早见于西汉的记载，当时的工艺已相当成熟，同时传承了图案配色鲜艳、常用红绿颜色的特点。";
        } else if (i % 5 == 0) {
            moment.text = @"昨夜雨疏风骤，浓睡不消残酒。试问卷帘人，却道海棠依旧。知否，知否？应是绿肥红瘦。";
        } else if (i % 7 == 0) {
            moment.text = @"安利我喜欢的插画师：晓艺大佬。详见链接：https://www.duitang.com/album/?id=86312973 ";
        } else if (i % 8 == 0) {
            moment.text = @"这是手机号☎️：18367980021  表情🐷：💪👍👊👎🍟🍎🍸🍞🍣👉👈🍟🍞🍊☎️📱👍👍😝😭🍓💊🍉🔥🐎👠🐷  邮箱📱：chellyLau@126.com";
        } else {
            moment.text = @"美冠鹦鹉又被称为粉红凤头鹦鹉，因为它的头冠特别美丽又有粉红色的羽毛，被誉为爱情鸟的鹦鹉，赋予粉红色的生命，也是暖暖的少女色，恋爱感爆棚。";
        }
        [moment save];
    }
}

#pragma mark - 获取
// 获取动态集合
+ (NSArray *)getMomentList:(int)momentId pageNum:(int)pageNum
{
    NSString * sql = nil;
    if (momentId == 0) {
        sql = [NSString stringWithFormat:@"ORDER BY pk DESC limit %d",pageNum];
    } else {
        sql = [NSString stringWithFormat:@"WHERE pk < %d ORDER BY pk DESC limit %d",momentId,pageNum];
    }
    NSMutableArray * momentList = [[NSMutableArray alloc] init];
    NSArray * tempList = [Moment findByCriteria:sql];
    NSInteger count = [tempList count];
    for (NSInteger i = 0; i < count; i ++)
    {
        Moment * moment = [tempList objectAtIndex:i];
        // 处理评论 ↓↓
        NSArray * idList = [MomentUtil getIdListByIds:moment.commentIds];
        NSInteger count = [idList count];
        NSMutableArray * list = [NSMutableArray array];
        for (NSInteger i = 0; i < count; i ++)
        {
            NSInteger pk = [[idList objectAtIndex:i] integerValue];
            Comment * comment = [Comment findFirstByCriteria:[NSString stringWithFormat:@"WHERE PK = %ld",(long)pk]];
            MUser * user = nil;
            if (comment.fromId != 0) {
                user = [MUser findFirstByCriteria:[NSString stringWithFormat:@"WHERE PK = %ld",(long)comment.fromId]];
            } else {
                user = nil;
            }
            comment.fromUser = user;
            if (comment.toId != 0) {
                user = [MUser findFirstByCriteria:[NSString stringWithFormat:@"WHERE PK = %ld",(long)comment.toId]];
            } else {
                user = nil;
            }
            comment.toUser = user;
            [list addObject:comment];
        }
        moment.commentList = list;
        // 处理赞  ↓↓
        idList = [MomentUtil getIdListByIds:moment.likeIds];
        count = [idList count];
        list = [NSMutableArray array];
        for (NSInteger i = 0; i < count; i ++)
        {
            NSInteger pk = [[idList objectAtIndex:i] integerValue];
            MUser * user = [MUser findFirstByCriteria:[NSString stringWithFormat:@"WHERE PK = %ld",(long)pk]];
            [list addObject:user];
        }
        moment.likeList = list;
        // 处理图片 ↓↓
        idList = [MomentUtil getIdListByIds:moment.pictureIds];
        count = [idList count];
        list = [NSMutableArray array];
        for (NSInteger i = 0; i < count; i ++)
        {
            NSInteger pk = [[idList objectAtIndex:i] integerValue];
            MPicture * pic = [MPicture findFirstByCriteria:[NSString stringWithFormat:@"WHERE PK = %ld",(long)pk]];
            [list addObject:pic];
        }
        moment.pictureList = list;
        // 发布者
        MUser * user = [MUser findFirstByCriteria:[NSString stringWithFormat:@"WHERE PK = %ld",moment.userId]];
        moment.user = user;
        // 位置
        MLocation * location = [MLocation findByPK:1];
        moment.location = location;
        // == 加入集合
        [momentList addObject:moment];
    }
    return momentList;
}

#pragma mark - 辅助方法
// 获取ids
+ (NSString *)getIdsByMaxPK:(NSInteger)maxPK
{
    NSMutableString * ids = [[NSMutableString alloc] init];
    for (int i = 1; i <= maxPK; i ++) {
        if (i == maxPK) {
            [ids appendString:[NSString stringWithFormat:@"%d",i]];
        } else {
            [ids appendString:[NSString stringWithFormat:@"%d,",i]];
        }
    }
    return ids;
}

// id集合
+ (NSArray *)getIdListByIds:(NSString *)ids
{
    return [ids componentsSeparatedByString:@","];
}

// ids
+ (NSString *)getIdsByIdList:(NSArray *)idList
{
    NSMutableString * ids = [[NSMutableString alloc] init];
    NSInteger count = [idList count];
    for (NSInteger i = 0; i < count; i ++) {
        NSString * idd = [idList objectAtIndex:i];
        if (i == count - 1) {
            [ids appendString:[NSString stringWithFormat:@"%@",idd]];
        } else {
            [ids appendString:[NSString stringWithFormat:@"%@,",idd]];
        }
    }
    return ids;
}

// 数组转字符
+ (NSString *)getLikeString:(Moment *)moment
{
    NSMutableString * likeString = [[NSMutableString alloc] init];
    NSInteger count = [moment.likeList count];
    for (NSInteger i = 0; i < count; i ++)
    {
        MUser * user = [moment.likeList objectAtIndex:i];
        if (i == 0) {
            [likeString appendString:user.name];
        } else {
            [likeString appendString:[NSString stringWithFormat:@"，%@",user.name]];
        }
    }
    return likeString;
}

@end
