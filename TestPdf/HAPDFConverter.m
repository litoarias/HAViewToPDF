//
//  HAPDFConverter.m
//  TestPdf
//
//  Created by Hipolito Arias on 31/7/16.
//  Copyright © 2016 Hipolito Arias. All rights reserved.
//

#import "HAPDFConverter.h"

@implementation HAPDFConverter

+ (void)createTableWithTableView:(UITableView *)tableView
     saveToDocumentsWithFileName:(NSString *)saveOnFileName
                 completionBlock:(void (^)(NSString *documentsDirectory, NSError *err))completionBlock
{
    [self.class renderTableView:tableView
                       fileName:saveOnFileName
                completionBlock:^(NSString *documentsDirectory, NSError *err)
     {
         if (!err) {
             completionBlock(documentsDirectory, nil);
         }
         else
         {
             completionBlock(nil, err);
         }
     }];
}


+ (void)renderTableView:(UITableView *)tableView
               fileName:(NSString *)fileName
        completionBlock:(void (^)(NSString *documentsDirectory, NSError *err))completionBlock

{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        CGRect priorBounds = tableView.bounds;
        CGSize fittedSize = [tableView sizeThatFits:CGSizeMake(priorBounds.size.width, tableView.contentSize.height)];
        tableView.bounds = CGRectMake(0, 0, fittedSize.width, fittedSize.height);
        CGRect pdfPageBounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height); // Change this as your need
        NSMutableData *pdfData = [[NSMutableData alloc] init];
        
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil); {
            for (CGFloat pageOriginY = 0; pageOriginY < fittedSize.height; pageOriginY += pdfPageBounds.size.height)
            {
                UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil);
                
                CGContextSaveGState(UIGraphicsGetCurrentContext()); {
                    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, -pageOriginY);
                    [tableView.layer renderInContext:UIGraphicsGetCurrentContext()];
                } CGContextRestoreGState(UIGraphicsGetCurrentContext());
            }
        } UIGraphicsEndPDFContext();
        
        tableView.bounds = priorBounds; // Reset the tableView
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePathPDF = [documentsPath stringByAppendingPathComponent:fileName]; //Add the file name
        BOOL written = [pdfData writeToFile:filePathPDF atomically:YES];
        
        if (written)
        {
            completionBlock(filePathPDF, nil);
        }
        else
        {
            NSError *err = [NSError errorWithDomain:@"horas_extra_writte"
                                               code:100
                                           userInfo:@{
                                                      NSLocalizedDescriptionKey:@"Error saving PDF on local storage"
                                                      }];
            
            completionBlock(nil, err);
        }
    });
    
}


+ (void)createPDFfromUIView:(UIView*)aView
saveToDocumentsWithFileName:(NSString*)aFilename
            completionBlock:(void (^)(NSString *documentsDirectory, NSError *err))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        // Creates a mutable data object for updating with binary data, like a byte array
        NSMutableData *pdfData = [NSMutableData data];
        // Points the pdf converter to the mutable data object and to the UIView to be converted
        UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil);
        UIGraphicsBeginPDFPage();
        CGContextRef pdfContext = UIGraphicsGetCurrentContext();
        // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
        [aView.layer renderInContext:pdfContext];
        // remove PDF rendering context
        UIGraphicsEndPDFContext();
        // Retrieves the document directories from the iOS device
        NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString* documentDirectory = [documentDirectories objectAtIndex:0];
        NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
        // instructs the mutable data object to write its context to a file on disk
        [pdfData writeToFile:documentDirectoryFilename atomically:YES];
        NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
        completionBlock(documentDirectoryFilename, nil);
    });
}


+ (void)sampleTestShowingPDFWithDocumentsDirectoryFileName:(NSString *)documentDirectoryFilename
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    webView.backgroundColor = [UIColor redColor];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:documentDirectoryFilename isDirectory:NO]];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:request];
    [[[[UIApplication sharedApplication]delegate] window] addSubview:webView];
}

@end
