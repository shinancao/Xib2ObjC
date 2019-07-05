Xib2ObjC
=======

This is a tool that can generate Objective-C UI layout code with `Masonry` from xib files, it can save you much time if you manually create UI layout in your current project by code. This tool also allow you to preview the xib layout effect, so you don't need to see it if it's okay in your actual project.

Features
--------
- Generate `Masonry` layout code from xib files.
- If you name your view in xib, the view's name will be synced into code, and treat it as a `property`.
- You can preview your xib effect without any code.

Usage
--------
This project is divided into two parts: `Xib2ObjC_Server` and `Xib2ObjC_Client`. These two parts communicate by `Socket`. 

`Xib2ObjC_Server` is responsible to analyze xib and generate view `.h` and `.m` files. To run it, you need Swift Package Manager (as well as swift compiler) installed in your macOS, generally you are prepared if you have the latest Xcode installed. 

You can add xib files in `Xib2ObjC_Client`, then run it to see your xib layout effect.

Now let's start!

- clone this project to your computer:

```
> git clone git@github.com:shinancao/Xib2ObjC.git
```

- open Terminal and run `Xib2ObjC_Server`:

```
> cd Xib2ObjC/Xib2ObjC_Server
> swift build
```

This will generate an executable file, such as:

<img src="https://raw.github.com/shinancao/Xib2ObjC/master/Screenshots/executable_file.png"/>

Then run it:

```
> ./.build/x86_64-apple-macosx10.10/debug/Xib2ObjC_Server
Listening on port: 8585
```

- open `Xib2ObjC_Client`, and add a xib file in `Xib` folder, layout your view elements with `Constraint`.

<img src="https://raw.github.com/shinancao/Xib2ObjC/master/Screenshots/xib_folder.png" />

**Note: you have to put xib files in this folder, the xib filepath is import!**

- build and run `Xib2ObjC_Client`, and to see it in the Simulator. The list view will show all the xib files's name in the `Xib` folder.

<img src="https://raw.github.com/shinancao/Xib2ObjC/master/Screenshots/xib_list.png" />

- select the xib you want to see, then tap `Generate Code`.

<img src="https://raw.github.com/shinancao/Xib2ObjC/master/Screenshots/generate_code.png" />

- Now Terminal will receive message, if there is no error, the folder that contains the generated files will open for you, its default path is `Xib2ObjC_GeneratedViews` on your desk.

<img src="https://raw.github.com/shinancao/Xib2ObjC/master/Screenshots/result.png" />

TODO
-------



License
-------

Xib2ObjC is released under the MIT license. See LICENSE for details.




