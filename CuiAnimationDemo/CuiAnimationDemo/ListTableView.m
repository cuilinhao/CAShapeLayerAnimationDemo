//
//  ListTableView.m
//  CuiAnimationDemo
//
//  Created by 天下林子 on 2021/1/4.
//

#import "ListTableView.h"
#import "TestVC1.h"

@interface ListTableView ()

@end

@implementation ListTableView


#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = [self viewControllerName:indexPath];;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *vcName = [self viewControllerName:indexPath];
    
    Class vcClass = NSClassFromString(vcName);
    UIViewController *vc = [[vcClass alloc] init];
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (NSString *)viewControllerName:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"TestVC%li", indexPath.row + 1];
    //return [NSString stringWithFormat:@"ViewController%li", indexPath.row + 1];
}


@end
