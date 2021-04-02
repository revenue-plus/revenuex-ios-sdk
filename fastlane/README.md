fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios create_new_version
```
fastlane ios create_new_version
```
Create new version
### ios check_before_deploy
```
fastlane ios check_before_deploy
```
Checks before deployment
### ios deploy
```
fastlane ios deploy
```
Deploy
### ios prepare_next
```
fastlane ios prepare_next
```
Prepare next version
### ios github_release
```
fastlane ios github_release
```
Make github release
### ios export_xcframework
```
fastlane ios export_xcframework
```
Export XCFramework
### ios create_and_update_changelog
```
fastlane ios create_and_update_changelog
```
Increment build number and update changelog

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
