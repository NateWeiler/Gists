# Remove warning
Unity has a warning when running a webgl build on mobile (iOS, Android). In order to remove it, just add this file to an editor folder. 

## Logic
The script will run after the build has completed and replace the checks from all generated javascript files.

## Support
* Tested with Unity 2019.3, but should work with any version
* Works with `Name Files as Hashes`, since it looks for all js files in the Build folder
* Only runs when building for WebGL, so you can use it for a multiplatform project

## Further Notes
* Unity adds this note, since the builds oftentimes don't work for mobile, so oftentimes it does make sense to include the info.
* You might need to empty your browser cache to get the new javascript file without any warnings