# Future-Hope-iOS

> This is an example file with default selections.

## Install


[CocoaPods - Getting Started](https://guides.cocoapods.org/using/getting-started.html)




-  Clone repo, cd into repo

```
cd Future-Hope

pod init
vim Podfile //you can also usue text editor

```

-  Add Pods for Future-Hope ( Podfile should look like this)
```
# Uncomment the next line to define a global platform for your project
  platform :ios, '12.0'

target 'Future-Hope' do
# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

# Pods for Future-Hope
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
end

//

```
- save, quit and install, open the workspace

```
pod install
open Future-Hope.xcworkspace
```


## Usage



## Contributing







PRs accepted.

## License

MIT © Richard McRichface
