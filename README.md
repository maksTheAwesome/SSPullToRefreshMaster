# SSPullToRefreshMaster.swift
Super simple pull to refresh custom animation

![Preview](https://d13yacurqjgara.cloudfront.net/users/495792/screenshots/2018249/draft_06.gif)

Simple Pull to refresh animation

Made by Max at [![EeasyAppsNYC.com/](http://easyappsnyc.com/)](http://easyappsnyc.com/)

Also, read how it was done in our [blog](http://yalantis.com/blog/how-we-created-guillotine-menu-animation/)


## Requirements
iOS 10.3 Swift 4.2


## Installation

#### [CocoaPods](http://cocoapods.org)
Coming soon.

#### Manual Installation

You are welcome to see the sample of the project for fully operating sample in the SSPullToRefreshMaster folder.

* Add the folder "PullToRefresh" to your project.
* Set initiate SSPullToRefreshView with any frame  and set it to be a `refreshControl` in your refreshable view controller.
* Set the target for the `refreshControl` to handle pull-to-refresh gesture. 
* In your refresh handler method call `refreshControl?.beginRefreshing()` to start the animation.
* Call `refreshControl?.endRefreshing()` when data is loaded and screen is ready to refresh.

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = SSPullToRefreshView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    @objc func handleRefresh() {
        refreshControl?.beginRefreshing()
        
        dataProvider.startLoading().onLoaded { [weak refreshControl] in
           refreshControl?.endRefreshing()
        }
    }
```

### Customization

Uhh. Sorry I don't think this one is very customizable. But feel free to use this code as an example to create your own lightweight and simple to use pull to refresh.

### Compatibility

iOS 10.3+

#### Version: 1.0

### License

The MIT License (MIT)

Copyright (c) 2018 Maksym Lazebnyi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
