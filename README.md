# Upload missing dSYMs to Firebase Crashlytics

Crashlytics [requires](https://firebase.google.com/docs/crashlytics/get-deobfuscated-reports?platform=ios#expandable-1 "requires") you to upload new generated dSYMs by Apple for every crash record if dSYMs are missing. It is very annoying. These scripts can help you automate this process

## How to use

1. Download repo
2. Init [Fastlane](https://fastlane.tools/ "Fastlane") for your project
3. Copy **Appfile** (*project/root/directory/.fastlane/Appfile*) to *path/to/repo/Credentials/Example*
4. Copy **GoogleService-Info.plist** to *path/to/repo/Credentials/Example*
5. Edit *path/to/repo/Credentials/Example/**options.plist***
Use *ci_key* as prefix for environment veriables for current project
Use one of other keys to determine dSYMs for versions' of your applications to download ([read more](https://docs.fastlane.tools/actions/download_dsyms/#parameters "read more"))
6. Rename /Credentials/Example directory to you project's name
7. Create directory at *path/to/repo/Credentials* for each project and repeat steps 2 - 5
8. Run **refresh-dsyms.sh** from  *path/to/repo* 

All dSYMs for selected versions of your projects will be downloaded, unacrchived and uploaded to Firebase.

You can automate this process by adding a scheduled **refresh-dsyms.sh**  execution. Or you can use any CI service. Just add environment variable **"CI": "true"**. You can also move version options from **options.plist** to environment variables. Just add uppercased environment variable with proper *prefix_key* (i.e. *EXAMPLE_MIN_VERSION*)
