# TSTTransition
TSTTransition是模仿腾讯体育iOS app的viewController的转场动画

## 起源
由于本人平时比较喜欢看NBA, 因此在手机上下载了腾讯体育app, 在平时使用的过程中, 发现该app的转场动画,控制器之间的动画不会受到导航栏和标签栏的影响, 每个viewController都有独立的UINavigationBar,由于比较好奇, 就写了很多的demo,发现该动画有点难以实现. 后来发觉到, 实际上是在presentViewController的时候,给每个viewController嵌入了一个独立的UINavigationViewController,这是关键所在,于是便动手写了 TSTTransition.

## 安装
### 使用cocoapods 
在项目的podfile文件中, `pod 'TSTTransition'`

### 手动安装
将TSTTransition的源文件直接添加到你的项目中

## 要求
* iOS 7.0及以后

## 使用
详细可以参考TSTTransition里面提供的demo
### 默认使用方式
导入相关文件
``` Objective-C
#import "UIViewController+TSTTransition.h"
//present a view controller 
UIViewController *viewController = [[UIViewController alloc] init];
//下面的方法,如果viewController不是一个导航控制器,会默认嵌入一个导航控制器给该控制器
[self tst_presentViewController:viewController animated:YES completion:nil];
//如果不想嵌入导航控制器,可以使用下面的方式
[self tst_presentViewController:viewController embedInANavigationController:NO animated:YES completion:nil];
```
### 配置默认转场动画中的相关参数
* 通过TSTGlobalSetting来配置全局的参数,在其他地方都使用该参数
* 通过tst_transition属性来配置当前转场的参数
```
#import "UIViewController+TSTTransition.h"
//是否使用TSTTransition的默认动画,如果不使用将使用系统默认提供的present和dismiss动画,默认为YES
[self.tst_transition usedTSTAnimatorAsDefault: YES];

//设置动画时长,默认为0.25s
self.tst_transition.duration = 0.5;
//是否使用交互式 dismiss transition,默认为YES
[self.tst_transition setEnabledInteractiveDismissTransition: NO];
//设置交互式dismiss transition的临界点,默认是0.3,当向左滑动的距离处理屏幕的宽度的大小大于该临界点,当手离开的时候,会完成该动画
self.tst_transition.triggerPercent = 0.5;

//设置底部视图在动画开始的alpha值,在结束后,还原其该有的alpha的值,产生某种效果.默认为0.9
self.tst_transition.alpha = 0.5;

//设置底部视图在动画过长中width和height的缩放比例,在动画结束将其还原,widthScale默认为1,heightScale默认为0.9
self.tst_transition.widthScale = 0.5;
self.tst_transition.heightScale = 0.8;

//设置动画过程中,为上面视图添加阴影
self.transition.shadowColor = [UIColor gray]; //设置阴影的颜色,默认为nil
self.transtion.shadowOpacity = 0.5; //设置阴影的不透明度,默认为0
self.transtion.shadowOffset = CGSize(width: -3, height: 0); //默认为CGSizeZero
self.transtion.shadowRadius = 3; //设置阴影的圆角,默认为0
self.transtion.shadowPath = [[UIBezierPath alloc] init]; //设置阴影的路径,默认为nil
```
### 自定义转场动画
```
//自定义present animator 
self.tst_transition.presentAnimator = [CustomPresentAnimator new];
[self tst_presentViewController:[TestViewController new] embedInANavigationController:YES animated:YES completion:nil];

//自定义dismiss animator
self.tst_transition.dismissAnimator = [CustomDismissAnimator new];
[self tst_presentViewController:[TestViewController new] embedInANavigationController:YES animated:YES completion:nil];

//自定义interactive present transition
CustomPresentInteractiveTransition *presentInteractiveTransition = [[CustomPresentInteractiveTransition alloc] initWithViewController:self];
[presentInteractiveTransition.panGestureRecognizer addTarget:self action:@selector(excuteCustomPresentInteractiveTransition:)];
self.tst_transition.presentInteractiveTransition = presentInteractiveTransition;
self.tst_transition.presentAnimator = [CustomPresentAnimator1 new];

//自定义interactive dimiss transition
TestAViewController *testAViewController = [TestAViewController new];
self.willPersentViewController = testAViewController;
CustomDismissInteractiveTransition *dismissInteractiveTransition = [CustomDismissInteractiveTransition new];
[dismissInteractiveTransition setPanGestureRecognizer:testAViewController.pangestureRecognizer];
self.tst_transition.dismissInteractiveTransition = dismissInteractiveTransition;
self.tst_transition.dismissAnimator = [CustomDismissAnimator1 new];
[self tst_presentViewController:testAViewController embedInANavigationController:YES animated:YES completion:nil];
```
## 贡献
欢迎提交issue和共同来维护该库










