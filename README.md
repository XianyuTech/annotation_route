# annotation_route

# 简介

 一个以注解方式实现的路由映射解决方案，基于 source_gen

# 使用

1. **注意**: 你的页面应该实现指定的构造器，构造器接受一个继承于$RouteOption的类，或者直接使用$RouteOption
使用@ARoute 注解你的页面类  
例：

```Dart
@ARoute(url: 'myapp://pagea')
class A {
   A(MyRouteOption option): super();
}
```

2. 使用 **@ARouteRoot** 注解 **你自己**的 router 类
   例：

```Dart
@ARouteRoot()
class MyRouter {}
```

3. 在你的工作目录下运行 build_annotation_route.sh 脚本，或者运行如下的命令:

```shell
    flutter packages pub run build_runner build --delete-conflicting-outputs
```

4. 现在你可以使用它来获取类的实例了
    例子：

```Dart
class MyRouteOption extends $RouteOption {

}

@ARouteRoot()
class Router {
    $RouterInternal internal = \$RouterInternal<MyRouteOption>();
   getPage(MyRouteOption option) {
   return internal.implFromRouteOption(option);
   }
}
```

# 安装

## 从源码安装

 拷贝代码至你的工作目录，在你的 pubspec.yaml 文件下声明
例：

```yaml
dev_dependencies:
  annotation_route:
    path: annotation_route
```

---

# Description

a router config mapping solution based on source_gen through annotation

# Usage

1. **Notice:** your page should own a constuctor that can be initialized with a class extend \$RouteOption Annotate the page class with @ARoute  
   example:

```Dart
@ARoute(url: 'myapp://pagea')
class A {
   A(MyRouteOption option): super();
}
```

2. Annotate **your own router class** with **@ARouteRoot**  
   example:

```Dart
@ARouteRoot()
class MyRouter {}
```

3. run the build_annotation_route.sh in your workspace Or just run the command below in your workspace  
   build command:

```shell
    flutter packages pub run build_runner build --delete-conflicting-outputs
```

4. now you can get the instance  
   example:

```Dart
class MyRouteOption extends $RouteOption {

}

@ARouteRoot()
class Router {
    $RouterInternal internal = \$RouterInternal<MyRouteOption>();
   getPage(MyRouteOption option) {
   return internal.implFromRouteOption(option);
   }
}
```

# Installation

## install from source code

clone the code, then put it into your workspace, announce it in your pubspec.yaml
exxample:

```yaml
dev_dependencies:
  annotation_route:
    path: annotation_route
```
