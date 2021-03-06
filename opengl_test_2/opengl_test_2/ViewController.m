//
//  ViewController.m
//  opengl_test_2
//
//  Created by Kalou on 13-5-13.
//  Copyright (c) 2013年 lijian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <OpenGLViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _boundFrame = [[UIScreen mainScreen] bounds];
    _openGLView = [[OpenGLView alloc] initWithFrame:_boundFrame];
    _openGLView.delegate = self;
    [self.view addSubview:_openGLView];
    
    UIButton *rotateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rotateBtn setFrame:CGRectMake(250, 20, 50, 50)];
    [rotateBtn setTitle:@"rotate" forState:UIControlStateNormal];
    [rotateBtn addTarget:self action:@selector(rotate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotateBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_openGLView release];
    
    [super dealloc];
}

- (void)rotate:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([btn.titleLabel.text isEqualToString:@"rotate"]) {
        [btn setTitle:@"stop" forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"rotate" forState:UIControlStateNormal];
    }
    
    [_openGLView toggleDisplayLink];
}

- (void)drawView:(UIView *)theView
{
/* 三角形
    glLoadIdentity();
    
    glClearColor(0.7, 0.7, 0.7, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glShadeModel(GL_SMOOTH);
    
    const GLfloat vertices[] = {
        -1, -1, -1,
         1, -1, -1,
         0,  1, -1,
    };
//    glColor4f(1.0, 0, 0, 1.0);
    glVertexPointer(3, GL_FLOAT, 0, vertices);
    glEnableClientState(GL_VERTEX_ARRAY);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    glDisableClientState(GL_VERTEX_ARRAY);
*/
    
/* 正方形
    glShadeModel(GL_FLAT);
    const GLfloat triangle[] = {
        -1.0, -1.0, -3,
         1.0, -1.0, -3,
        -1.0,  1.0, -3,
         1.0,  1.0, -3
    };
    
    const GLfloat triangleColor[] = {
      1, 0, 0, 1,
      0, 1, 0, 1,
      0, 0, 1, 1,
      1, 1, 0, 1,
    };
    
    glVertexPointer(3, GL_FLOAT, 0, triangle);
    glColorPointer(4, GL_FLOAT, 0, triangleColor);
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);// 画面一直不对，是因为理解错了此函数，count不是12，而是4，count数组中顶点的数量
    
    glDisableClientState(GL_VERTEX_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
*/
    
///* 正四面体
    const GLfloat vertices[] = {
         0    ,  1.0,  0  ,  //0
        -0.866, -0.5,  0.5,  //1
         0.866, -0.5,  0.5,  //2
         0    , -0.5,  -1 ,  //3
     };
     
    const GLfloat vertexColor[] = {
         1, 0, 0, 1, //0
         0, 1, 0, 1, //1
         0, 0, 1, 1, //2
         0, 1, 1, 1, //3
    };
    
    GLubyte indices[] = {
        0, 1, 2,
        0, 2, 3,
        0, 3, 1,
        1, 2, 3,
    };
 
    glLoadIdentity();
    glClearColor(0.7, 0.7, 0.7, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);    
    
    glVertexPointer(3, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_FLOAT, 0, vertexColor);
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
    glRotatef(_openGLView.rotateColorCube, 0, 1, 0);
//    glDrawArrays(GL_TRIANGLES, 0, 12);
    glDrawElements(GL_TRIANGLES, sizeof(indices) / sizeof(GLubyte), GL_UNSIGNED_BYTE, indices);// warning: is GL_UNSIGNED_BYTE not GL_UNSIGNED_INT
    glDisableClientState(GL_VERTEX_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
//*/
}

-(void)setupView:(UIView*)view
{
	GLfloat size;
	CGRect rect = view.bounds;

	glEnable(GL_DEPTH_TEST);
    
    //视口变换
	glViewport(0, 0, rect.size.width, rect.size.height);
    
	glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
	    
    //正交变换 
    size = 1.0f;
    glOrthof(-size, size, -size / (rect.size.width / rect.size.height), size / (rect.size.width / rect.size.height), -5, 5);
    // glOrthof与glOrthox不同，注意区别。zNear和zFar注意与glFrustumf不同

/*
    //投影变换
    size = kZNear * tanf(DEGREES_TO_RADIANS(kFieldOfView) / 2.0);
	glFrustumf(-size, size, -size / (rect.size.width / rect.size.height), size / (rect.size.width / rect.size.height), kZNear, kZFar);
*/  
 
	glMatrixMode(GL_MODELVIEW);
  
//    GLfloat ambient[] = {1.0, 0, 0, 1.0};
//    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, ambient);
//    
//    GLfloat lmodel_embient[] = {1.0, 1.0, 1.0, 1.0};
//    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, lmodel_embient);
    
/* 设置光源
    //开启光效
    glEnable(GL_LIGHTING);

    //打开0光源
    glEnable(GL_LIGHT0);

    //环境光
    const GLfloat light0Ambient[] = {0.2, 0.2, 0.2, 1};
    glLightfv(GL_LIGHT0, GL_AMBIENT, light0Ambient);

    //散射光
    const GLfloat light0Diffuse[] = {0.5, 0.5, 0.5, 1.0};
    glLightfv(GL_LIGHT0, GL_DIFFUSE, light0Diffuse);

    //高光
    const GLfloat light0Specular[] = {0.7, 0.7, 0.7, 1.0};
    glLightfv(GL_LIGHT0, GL_SPECULAR, light0Specular);

    //光源位置
    const GLfloat light0Position[] = {10.0, 10.0, 10.0, 0.0};
    glLightfv(GL_LIGHT0, GL_POSITION, light0Position);
    
    //光源方向
    const GLfloat light0Direction[] = {0.0, 0.0, -1.0};
    glLightfv(GL_LIGHT0, GL_SPOT_DIRECTION, light0Direction);
    
    //光源角度
    glLightf(GL_LIGHT0, GL_SPOT_CUTOFF, 45.0);
*/
	glLoadIdentity();
}

@end
