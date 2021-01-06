Profile settings in Windows Terminal
====================================

The settings listed below are specific to each unique profile. If you'd like a setting to apply to all of your profiles, you can add it to the `defaults` section above the list of profiles in your settings.json file.

JSON

```
"defaults":
{
    // SETTINGS TO APPLY TO ALL PROFILES
},
"list":
[
    // PROFILE OBJECTS
]

```

Unique identifier[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#unique-identifier)
----------------------------------------------------------------------------------------------------------------------------

Profiles can use a GUID as a unique identifier. To make a profile your default profile, it needs a GUID for the `defaultProfile` global setting.

Property name: `guid`

Necessity: Required

Accepts: GUID as a string in registry format: `"{00000000-0000-0000-0000-000000000000}"`

* * * * *

Executable settings[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#executable-settings)
--------------------------------------------------------------------------------------------------------------------------------

### Command line[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#command-line)

This is the executable used in the profile.

Property name: `commandline`

Necessity: Optional

Accepts: Executable file name as a string

Default value: `"cmd.exe"`

### Source[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#source)

This stores the name of the profile generator that originated the profile. *There are no discoverable values for this field.* For additional information on dynamic profiles, visit the [Dynamic profiles page](https://docs.microsoft.com/en-us/windows/terminal/dynamic-profiles).

Property name: `source`

Necessity: Optional

Accepts: String

### Starting directory[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#starting-directory)

This is the directory the shell starts in when it is loaded.

Property name: `startingDirectory`

Necessity: Optional

Accepts: Folder location as a string

Default value: `"%USERPROFILE%"`

* * * * *

Dropdown settings[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#dropdown-settings)
----------------------------------------------------------------------------------------------------------------------------

![Windows Terminal dropdown](https://docs.microsoft.com/en-us/windows/terminal/images/dropdown.png) *Configuration: [Raspberry Ubuntu](https://docs.microsoft.com/en-us/windows/terminal/custom-terminal-gallery/raspberry-ubuntu)*

### Name[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#name)

This is the name of the profile that will be displayed in the dropdown menu. This value is also used as the "title" to pass to the shell on startup. Some shells (like `bash`) may choose to ignore this initial value, while others (`Command Prompt`, `PowerShell`) may use this value over the lifetime of the application. This "title" behavior can be overridden by using `tabTitle`.

Property name: `name`

Necessity: Required

Accepts: String

### Icon[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#icon)

This sets the icon that displays within the tab and the dropdown menu.

Property name: `icon`

Necessity: Optional

Accepts: File location as a string

### Hide a profile from the dropdown[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#hide-a-profile-from-the-dropdown)

If `hidden` is set to `true`, the profile will not appear in the list of profiles. This can be used to hide default profiles and dynamically generated profiles, while leaving them in your settings file. To learn more about dynamic profiles, visit the [Dynamic profiles page](https://docs.microsoft.com/en-us/windows/terminal/dynamic-profiles).

Property name: `hidden`

Necessity: Optional

Accepts: `true`, `false`

Default value: `false`

* * * * *

Tab title settings[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#tab-title-settings)
------------------------------------------------------------------------------------------------------------------------------

### Custom tab title[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#custom-tab-title)

If set, this will replace the `name` as the title to pass to the shell on startup. Some shells (like `bash`) may choose to ignore this initial value, while others (`Command Prompt`, `PowerShell`) may use this value over the lifetime of the application. If you'd like to learn how to have the shell set your title, visit the [tab title tutorial](https://docs.microsoft.com/en-us/windows/terminal/tutorials/tab-title).

Property name: `tabTitle`

Necessity: Optional

Accepts: String

### Suppress title changes from the shell[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#suppress-title-changes-from-the-shell)

When this is set to `true`, `tabTitle` overrides the default title of the tab and any title change messages from the application will be suppressed. If `tabTitle` isn't set, `name` will be used instead. When this is set to `false`, `tabTitle` behaves as normal.

Property name: `suppressApplicationTitle`

Necessity: Optional

Accepts: `true`, `false`

* * * * *

Text settings[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#text-settings)
--------------------------------------------------------------------------------------------------------------------

### Font face[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#font-face)

This is the name of the font face used in the profile. The terminal will try to fallback to Consolas if this can't be found or is invalid. To learn about the other variants of the default font, Cascadia Mono, visit the [Cascadia Code page](https://docs.microsoft.com/en-us/windows/terminal/cascadia-code).

Property name: `fontFace`

Necessity: Optional

Accepts: Font name as a string

Default value: `"Cascadia Mono"`

### Font size[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#font-size)

This sets the profile's font size in points.

Property name: `fontSize`

Necessity: Optional

Accepts: Integer

Default value: `12`

### Padding[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#padding)

This sets the padding around the text within the window. This will accept three different formats: `"#"` sets the same padding for all sides, `"#, #"` sets the same padding for left-right and top-bottom, and `"#, #, #, #"` sets the padding individually for left, top, right, and bottom.

Property name: `padding`

Necessity: Optional

Accepts: Values as a string in the following formats: `"#"`, `"#, #"`, `"#, #, #, #"`

Default value: `"8, 8, 8, 8"`

![Windows Terminal padding](https://docs.microsoft.com/en-us/windows/terminal/images/padding.gif)

### Antialiasing text[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#antialiasing-text)

This controls how text is antialiased in the renderer. Note that changing this setting will require starting a new terminal instance.

![Windows Terminal antialiasing text](https://docs.microsoft.com/en-us/windows/terminal/images/antialiasing-mode.gif)

Property name: `antialiasingMode`

Necessity: Optional

Accepts: `"grayscale"`, `"cleartype"`, `"aliased"`

Default value: `"grayscale"`

* * * * *

Cursor settings[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#cursor-settings)
------------------------------------------------------------------------------------------------------------------------

### Cursor shape[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#cursor-shape)

This sets the cursor shape for the profile. The possible cursors are as follows: `"bar"` ( ┃ ), `"vintage"` ( ▃ ), `"underscore"` ( ▁ ), `"filledBox"` ( █ ), `"emptyBox"` ( ▯ )

Property name: `cursorShape`

Necessity: Optional

Accepts: `"bar"`, `"vintage"`, `"underscore"`, `"filledBox"`, `"emptyBox"`

Default value: `"bar"`

### Cursor color[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#cursor-color)

This sets the cursor color of the profile. This will override the `cursorColor` set in the color scheme if `colorScheme` is set.

Property name: `cursorColor`

Necessity: Optional

Accepts: Color as a string in hex format: `"#rgb"` or `"#rrggbb"`

### Cursor height[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#cursor-height)

This sets the percentage height of the cursor starting from the bottom. This will only work when `cursorShape` is set to `"vintage"`.

Property name: `cursorHeight`

Necessity: Optional

Accepts: Integer from 25-100

* * * * *

Color settings[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#color-settings)
----------------------------------------------------------------------------------------------------------------------

### Color scheme[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#color-scheme)

This is the name of the color scheme used in the profile. Color schemes are defined in the `schemes` object. More detailed information can be found on the [Color schemes page](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes).

Property name: `colorScheme`

Necessity: Optional

Accepts: Name of color scheme as a string

Default value: `"Campbell"`

### Foreground color[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#foreground-color)

This changes the foreground color of the profile. This overrides `foreground` set in the color scheme if `colorScheme` is set.

Property name: `foreground`

Necessity: Optional

Accepts: Color as a string in hex format: `"#rgb"` or `"#rrggbb"`

### Background color[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#background-color)

This changes the background color of the profile with this setting. This overrides `background` set in the color scheme if `colorScheme` is set.

Property name: `background`

Necessity: Optional

Accepts: Color as a string in hex format: `"#rgb"` or `"#rrggbb"`

### Selection background color[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#selection-background-color)

This sets the background color of a selection within the profile. This will override the `selectionBackground` set in the color scheme if `colorScheme` is set.

Property name: `selectionBackground`

Necessity: Optional

Accepts: Color as a string in hex format: `"#rgb"` or `"#rrggbb"`

* * * * *

Acrylic settings[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#acrylic-settings)
--------------------------------------------------------------------------------------------------------------------------

### Enable acrylic[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#enable-acrylic)

When this is set to `true`, the window will have an acrylic background. When it's set to `false`, the window will have a plain, untextured background. The transparency only applies to focused windows due to OS limitations.

Property name: `useAcrylic`

Necessity: Optional

Accepts: `true`, `false`

Default value: `false`

![Windows Terminal acrylic](https://docs.microsoft.com/en-us/windows/terminal/images/acrylic.gif)

### Acrylic opacity[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#acrylic-opacity)

When `useAcrylic` is set to `true`, this sets the transparency of the window for the profile. This accepts floating point values from 0-1.

Property name: `acrylicOpacity`

Necessity: Optional

Accepts: Number as a floating point value from 0-1

Default value: `0.5`

![Windows Terminal acrylic opacity](https://docs.microsoft.com/en-us/windows/terminal/images/acrylic-opacity.gif)

* * * * *

Background image settings[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#background-image-settings)
--------------------------------------------------------------------------------------------------------------------------------------------

### Setting the background image[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#setting-the-background-image)

This sets the file location of the image to draw over the window background. The background image can be a .jpg, .png, or .gif file.

Property name: `backgroundImage`

Necessity: Optional

Accepts: File location as a string

### Background image stretch mode[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#background-image-stretch-mode)

This sets how the background image is resized to fill the window.

Property name: `backgroundImageStretchMode`

Necessity: Optional

Accepts: `"none"`, `"fill"`, `"uniform"`, `"uniformToFill"`

Default value: `"uniformToFill"`

![Windows Terminal background image stretch mode](https://docs.microsoft.com/en-us/windows/terminal/images/background-image-stretch-mode.gif) *[Background image source](https://wallpaperhub.app/wallpapers/6287)*

### Background image alignment[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#background-image-alignment)

This sets how the background image aligns to the boundaries of the window.

Property name: `backgroundImageAlignment`

Necessity: Optional

Accepts: `"center"`, `"left"`, `"top"`, `"right"`, `"bottom"`, `"topLeft"`, `"topRight"`, `"bottomLeft"`, `"bottomRight"`

Default value: `"center"`

![Windows Terminal background image alignment](https://docs.microsoft.com/en-us/windows/terminal/images/background-image-alignment.gif) *[Background image source](https://design.ubuntu.com/brand/ubuntu-logo/)*

### Background image opacity[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#background-image-opacity)

This sets the transparency of the background image.

Property name: `backgroundImageOpacity`

Necessity: Optional

Accepts: Number as a floating point value from 0-1

Default value: `1.0`

* * * * *

Scroll settings[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#scroll-settings)
------------------------------------------------------------------------------------------------------------------------

### Scrollbar visibility[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#scrollbar-visibility)

This sets the visibility of the scrollbar.

Property name: `scrollbarState`

Necessity: Optional

Accepts: `"visible"`, `"hidden"`

### Scroll to input line when typing[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#scroll-to-input-line-when-typing)

When this is set to `true`, the window will scroll to the command input line when typing. When it's set to `false`, the window will not scroll when you start typing.

Property name: `snapOnInput`

Necessity: Optional

Accepts: `true`, `false`

Default value: `true`

### History size[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#history-size)

This sets the number of lines above the ones displayed in the window you can scroll back to.

Property name: `historySize`

Necessity: Optional

Accepts: Integer

Default value: `9001`

* * * * *

How the profile closes when exiting[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#how-the-profile-closes-when-exiting)
----------------------------------------------------------------------------------------------------------------------------------------------------------------

This sets how the profile reacts to termination or failure to launch. `"graceful"` will close the profile when `exit` is typed or when the process exits normally. `"always"` will always close the profile and `"never"` will never close the profile. `true` and `false` are accepted as synonyms for `"graceful"` and `"never"`, respectively.

Property name: `closeOnExit`

Necessity: Optional

Accepts: `"graceful"`, `"always"`, `"never"`, `true`, `false`

Default value: `"graceful"`

* * * * *

Retro terminal effects[](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/profile-settings#retro-terminal-effects)
--------------------------------------------------------------------------------------------------------------------------------------

When this is set to `true`, the terminal will emulate a classic CRT display with scan lines and blurry text edges. This is an experimental feature and its continued existence is not guaranteed.

Property name: `experimental.retroTerminalEffect`

Necessity: Optional

Accepts: `true`, `false`

Default value: `false`

![Windows Terminal experimental retro terminal effect](https://docs.microsoft.com/en-us/windows/terminal/images/experimental-retro-terminal-effect.gif) *Configuration: [Retro Command Prompt](https://docs.microsoft.com/en-us/windows/terminal/custom-terminal-gallery/retro-command-prompt)*