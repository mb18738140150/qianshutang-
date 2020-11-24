//
//  GrafitiViewController.m
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "GrafitiViewController.h"
#import "GraffitiView.h"

@interface GrafitiViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)GraffitiView * graffitiView;

@end

@implementation GrafitiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.graffitiView = [[GraffitiView alloc]initWithFrame:CGRectMake(0, 0, self.view.hd_width, self.view.hd_height) image:self.sourceimage];
    __weak typeof(self)weakSelf = self;
    self.graffitiView.backBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    self.graffitiView.GetLibraryImageBlock = ^{
        [weakSelf getLibraryImageAction];
    };
    self.graffitiView.SavaGraffitiBlock = ^(UIImage * image) {
        
        if (weakSelf.SavaImageProDuctBlock) {
            weakSelf.SavaImageProDuctBlock(image);
        }
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.view addSubview:_graffitiView];
}

- (void)getLibraryImageAction
{
    __weak typeof(self)weakSelf = self;
    BLImagePickerViewController * vc = [[BLImagePickerViewController alloc]init];
    vc.maxNum = 1;
    vc.imageClipping = NO;
    vc.showCamera = NO;
    [vc initDataProgress:^(CGFloat progress) {
        
    } finished:^(NSArray<UIImage *> *resultAry, NSArray<PHAsset *> *assetsArry, UIImage *editedImage) {
        
        [weakSelf.graffitiView resetWithImage:resultAry[0]];
        
    } cancle:^(NSString *cancleStr) {
        
    }];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
