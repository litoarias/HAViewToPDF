//
//  TableViewController.m
//  TestPdf
//
//  Created by Hipolito Arias on 31/7/16.
//  Copyright © 2016 Hipolito Arias. All rights reserved.
//

#import "TableViewController.h"
#import "HAPDFConverter.h"
#import "SVProgressHUD.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        [SVProgressHUD show];
        
        
//        [HAPDFConverter createTableWithTableView:self.tableView
//                     saveToDocumentsWithFileName:@"test.pdf"
//                                 completionBlock:^(NSString *documentsDirectory, NSError *err)
//         {
//             dispatch_async(dispatch_get_main_queue(), ^{
//                 
//                 [HAPDFConverter sampleTestShowingPDFWithDocumentsDirectoryFileName:documentsDirectory];
//                 
//                 [SVProgressHUD dismiss];
//                 
//                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [HAPDFConverter createPDFfromUIView:self.view
                             saveToDocumentsWithFileName:@"testView.pdf"
                                         completionBlock:^(NSString *documentsDirectory, NSError *err)
                      {
                          [HAPDFConverter sampleTestShowingPDFWithDocumentsDirectoryFileName:documentsDirectory];
                      }];
                 });
                 
//             });
//             
//             
//         }];
//    
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [NSString stringWithFormat:@"Seccion : %li", (long)section];
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"Section %li - Row %li", (long)indexPath.section, (long)indexPath.row];
    return cell;
}


-(void)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    
    
    
}

@end
