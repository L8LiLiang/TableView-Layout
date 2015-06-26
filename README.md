# TableView-Layout
TableVIew的自动布局和手动布局示例代码


本程序主要展示tableview cell的自动布局和手动布局。

L8Controller是用来展示数据的tableviewcontroller
L8NewCell是本程序使用的L8DynamicNewscell（自动布局）和L8ManualNewsCell（手动布局）的基类
L8DynamicNewscell 自动布局cell类
L8ManualNewsCell 手动布局cell类

L8Label主要实现layoutSubviews方法，用来支持自动布局，如下：
-(void)layoutSubviews
{
    [super layoutSubviews];
    //保证自动换行
    self.preferredMaxLayoutWidth = self.bounds.size.width;
    
    [super layoutSubviews];
}


自动布局是通过在updateConstraints方法中调整约束进行布局。
手动布局就是在L8ManualNewsCell的layoutSubviews方法中通过计算子控件的frame控制布局。
