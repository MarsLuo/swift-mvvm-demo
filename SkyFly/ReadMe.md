为保证本项目得以运行，请查看本手册以下内容。

### 依赖
本项目开发依赖macOS，Xcode，CocoaPods，如果没有相关环境请自行安装。  
本项目调试依赖 npm, node.js,如果没有相关环境，请自行安装。

参考版本：  
macOS: 10.15.7   
Xcode: 12.3  
CocoaPods: 1.8.4  
npm: 6.14.7  
node.js 12.13.1  

### 运行
本项目运行入口为SkyFly.xcworkspace， 使用Xcode打开即可。  

注意：
1. 在运行前需要执行 `pod install` 以更新相关依赖。

### 关于FakeServer
1. 在运行前需要在 luanmock 文件夹中，执行`npm install`， 以安装FakeServer依赖。
2. 启动 FakeServer, 执行`npm start`命令.




