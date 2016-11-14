//
//  ViewController.m
//  SaveImage
//
//  Created by 刘浩浩 on 2016/11/3.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 320, 320)];
    self.imageView.image = [UIImage imageNamed:@"fire.jpg"];
    [self.view addSubview:self.imageView];
    self.imageView.center = self.view.center;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /**
     *  将图片保存到iPhone本地相册
     *  UIImage *image            图片对象
     *  id completionTarget       响应方法对象
     *  SEL completionSelector    方法
     *  void *contextInfo
     */
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self makeScreenShotCompletion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

/**
 *  简单截屏并将图片保存到本地
 */
-(void)makeScreenShotCompletion:(void(^)(UIImage * image))completion{
    //开启上下文  <span style="font-family: Arial, Helvetica, sans-serif;">设置截屏大小</span>
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //获取图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    completion(image);
    
    /**
     *  将图片保存到本地相册
     */
    UIImageWriteToSavedPhotosAlbum(image, self , @selector(image:didFinishSavingWithError:contextInfo:), nil);//保存图片到照片库
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
