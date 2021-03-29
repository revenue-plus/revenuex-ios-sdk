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
### ios bump
```
fastlane ios bump
```
Increment build number
### ios deployment_checks
```
fastlane ios deployment_checks
```
Deployment checks
### ios deploy
```
fastlane ios deploy
```
Deploy
### ios prepare_next_version
```
fastlane ios prepare_next_version
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
### ios bump_and_update_changelog
```
fastlane ios bump_and_update_changelog
```
Increment build number and update changelog

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
