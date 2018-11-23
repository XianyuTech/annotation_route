# annotation_route

# Description

a router config mapping solution based on source_gen through annotation

# Usage

1. **Notice:** your page should own a constuctor that can be initialized with unique param, then Annotate the page class with @ARoute  
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
   build:

   ```shell
    flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

   suggest you running the clean command before build:  
    clean:

   ```shell
    flutter packages pub run build_runner clean
   ```

4. now you can get the instance  
   example:

   ```Dart
   @ARouteRoot()
   class Router {
    ARouterInternal internal = ARouterInternalImpl();
    dynamic getPage(MyRouteOption option) {
      return internal.findPage(
          ARouteOption(option.urlpattern, option.params), option);
    }
   }

   class MyRouteOption {
    String urlpattern;
    Map<String, dynamic> params;
   }
   ```

5. examples placed in 'lib/example/\*'

# Installation

## install from packages

add packages to dev_dependencies in your pubspec.yaml  
example:

```yaml
dev_dependencies:
  annotation_route: any
```

## install from source code

clone the code, then put it into your workspace, announce it in your pubspec.yaml
exxample:

```yaml
dev_dependencies:
  annotation_route:
    path: annotation_route
```

---

# 简介

一个以注解方式实现的路由映射解决方案，基于 source_gen

# 使用

1. **注意**: 你的页面应该实现指定的构造器，一个接受唯一参数的构造器，然后使用@ARoute 注解你的页面类  
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
   class MyRouter {}
   ```

3. 在你的工作目录下运行 build_annotation_route.sh 脚本，或者运行如下命令:  
   build:

   ```shell
    flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

   建议在执行 build 命令前，先执行如下命令:  
    clean:

   ```shell
    flutter packages pub run build_runner clean
   ```

4. 现在你可以使用它来获取类的实例了  
   例：

   ```Dart
   @ARouteRoot()
   class Router {
    ARouterInternal internal = ARouterInternalImpl();
    dynamic getPage(MyRouteOption option) {
      return internal.findPage(
          ARouteOption(option.urlpattern, option.params), option);
    }
   }

   class MyRouteOption {
    String urlpattern;
    Map<String, dynamic> params;
   }
   ```

5. 具体代码可以参考 lib/example/\*下的文件

# 安装

## 从 pub 安装

在你的 pubspec.yaml 文件下声明  
例：

```yaml
dev_dependencies:
  annotation_route: any
```

## 从源码安装

拷贝代码至你的工作目录，在你的 pubspec.yaml 文件下声明  
例：

```yaml
dev_dependencies:
  annotation_route:
    path: annotation_route
```
