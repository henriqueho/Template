//
//  IGSplashVie.h
//  IGUtilProject
//
//  Created by Pedro Valentini on 09/06/11.
//  Copyright 2011 Infoglobo. All rights reserved.
//
/*

 
 Classe para exibir imagem de "Splash" no inicio dos aplicativos.
    - Exibe imagem diferente para landscape e portrait
    - Exibido mesmo quando a app volta de background
    - Mantem o statusbar
    - Exibe 3 segundos por padrao, pode ser alterado no build
    
 Proxima versao:
    - Baixar imagens da web
    - Animar imagem (estilo app do O Globo)
    - Parametro para remover status bar
 
 
 USO
 
 - No AppDelegate applicationWillResignActive:
 
 IGSplashView *splash = [[IGSplashView alloc] init];
 [splash setTag:555];
 [viewController.view addSubview:splash];
 [splash release];
 
 - No AppDelegate applicationDidBecomeActive:
 
 IGSplashView *splash = (IGSplashView*)[viewController.view viewWithTag:555];
 if (splash) [splash show];
 
 - No ViewController viewDidLoad:
 
 IGSplashView *splash = [[IGSplashView alloc] init];
 [splash setTag:555];
 [viewController.view addSubview:splash];
 [splash release];
 [splash show];
 
 - No ViewController willRotateToInterfaceOrientation:
 
 IGSplashView *splash = (IGSplashView*)[self.view viewWithTag:555];
 if (splash) [splash setNeedsDisplay];
 
*/


#import <UIKit/UIKit.h>


@interface IGSplashView : UIView {
    
    NSTimeInterval showSeconds;
    NSTimeInterval fadeSeconds;
    
}

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *fadeTimer;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, ) UIImageView *imageView;
@property (nonatomic) BOOL isAnimation;

- (void)showForSeconds:(NSTimeInterval)seconds fadeForSeconds:(NSTimeInterval)_fadeSeconds;
- (void)show;
- (void)fadeOut;
- (id)initSecondSplash;

@end
