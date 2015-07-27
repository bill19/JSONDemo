//
//  RootTableViewController.m
//  JSONDemo
//
//  Created by vera on 15/7/26.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#define kUrlString @"https://api.douban.com/v2/book/search?q=s"

#import "RootTableViewController.h"
#import "HTTPRequest.h"
#import "Book.h"
//SDWebImage是图片缓存第3方库
#import "UIImageView+WebCache.h"

@interface RootTableViewController ()<HTTPRequestDelegate>
{
    //数据源
    NSMutableArray *_books;
}

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",NSHomeDirectory());
    
    /*
    Book *book = [[Book alloc] init];
    NSString *s = [book valueForKey:@"test"];
    NSLog(@"----:%@",s);
     */
    
    /*
     1.请求数据
     2.解析
     3.显示到界面上
     */
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _books = [NSMutableArray array];
    
    /**
     请求数据
     */
    [self requestDataFromNetWork];
    
    
}

/**
 请求数据
 */
- (void)requestDataFromNetWork
{
    HTTPRequest *request = [[HTTPRequest alloc] initWithUrl:[NSURL URLWithString:kUrlString]];
    //设置代理
    request.delegate = self;
    //发送异步请求
    [request startRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理方法
#pragma mark -HTTPRequestDelegate
//请求完成的回调
- (void)requestDidFinish:(HTTPRequest *)request
{
#if 0
    /**
     把字典或者数组转化为json字符串
     */
    NSDictionary *dic = @{@"key1":@"value1",@"key2":@"value2"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //把UIButton对象转化为字典
    NSDictionary *dic2 = NSDictionaryOfVariableBindings(button);
    NSLog(@"----:%@",dic2[@"button"]);
#endif
    
    
    
    
    //解析
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
    NSArray *jsonArray = jsonDic[@"books"];
    
    //遍历
    for (NSDictionary *dic in jsonArray)
    {
        Book *book = [[Book alloc] init];
        
        //赋值
        [book setValuesForKeysWithDictionary:dic];
        
        
        NSLog(@"%@ - %@ - %@",book.title,book.price,book.large);
        
        //添加到数据源
        [_books addObject:book];
        
        
        
        /*
         for (NSString *key in dic)
         {
         [book setValue:dic[key] forKey:key];
         }
         
        [book setValue:@"alt" forKey:dic[@"alt"]];
        .....
         */
    }
    
    //刷新tableView
    [self.tableView reloadData];
    
}

//请求失败的回调
- (void)requestDidError:(NSError *)error
{
    
}

#pragma mark -Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _books.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    //取值
    Book *book = _books[indexPath.row];
    //图片赋值
    /*
     sd_setImageWithURL:图片地址
     placeholderImage:默认图片
     */
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:book.large] placeholderImage:[UIImage imageNamed:@"photo"]];
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.price;
    
    
    
    /*
    [cell.imageView sd_setImageWithURL:<#(NSURL *)#> placeholderImage:<#(UIImage *)#> options:<#(SDWebImageOptions)#> progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        <#code#>
    } completed:<#^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)completedBlock#>];
     */
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
