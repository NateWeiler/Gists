Windows Package Manager Preview
===============================

If you're already familiar with what a package manager is, feel free to skip this paragraph. If you're still reading, you're going to love this! A package manager is designed to help you save time and frustration. Essentially, it is a set of software tools that help you automate the process of getting software on your machine. You specify which apps you want installed, and it does the work of finding the latest version (or the exact one you specified) and installing it on your machine.

Just about every developer has wanted a native package manager in Windows. That day is finally here. You are going to be able to `winget install` your way to bliss. One of the best parts is that it is open source. I had to pinch myself when I was able to `winget install terminal`, and then `winget install powershell`, and then `winget install powertoys`. You get the idea, and If you do not see an app you use, just create a new manifest, and submit a pull request.

[![Execute winget in Windows Terminal](https://devblogs.microsoft.com/commandline/wp-content/uploads/sites/33/2020/05/winget01.png)](https://devblogs.microsoft.com/commandline/wp-content/uploads/sites/33/2020/05/winget01.png)

### When can I try it?

As of today, the Windows Package Manager preview has been made open source. You can clone, build, run and test the code from the GitHub repository (<https://github.com/microsoft/winget-cli>). There are other *possibly* easier ways to get your hands on it if that doesn't sound appealing. Please continue reading.

### What functionality is included?

You can `install` any app with a valid manifest (even local ones `-- manifest`). The command line client "winget.exe" is already pre-configured to point to the Microsoft community repository. That means you can install any package with a manifest that has been published.

> Have you ever had to completely re-install all your apps and tools on your PC? How long did it take? How did you remember where to go to find, download, and install all your editors & IDEs, languages & runtimes, source control tools, etc.?
>
> *Did you enjoy it*? Yeah, neither did we ... which is why we created Windows Package Manager.
>
> Now you can install all your favorite apps & tools simply by typing `winget install <foo>` into your command-line. Or better still, you can create a script file that installs ALL your tools while you sit back enjoy a well-earned coffee break!"

You can `search` for available packages and display information using the `show` command. There are also commands to help with manifest creation and validation (`hash` and `validate`). Once the first third-party repository is published, you will be able to add that repository as a `source` as well. We're providing documentation at <https://docs.microsoft.com/windows/package-manager> and both of the GitHub repositories.

[![Executing the winget install vscode command in Windows Terminal](https://devblogs.microsoft.com/commandline/wp-content/uploads/sites/33/2020/05/winget02.png)](https://devblogs.microsoft.com/commandline/wp-content/uploads/sites/33/2020/05/winget02.png)

### How do I get it?

We have provided three different ways for you to get your hands on the Windows Package Manager. If you are a Windows Insider, you may already have it. First, you can head over to the open source GitHub repository for the [client](https://www.github.com/microsoft/winget-cli). Second, you can join any of the [Windows Insider](https://insider.windows.com/) rings. Third, you can join the Windows Package Manager Insider program by providing your Microsoft Account (MSA) to [Windows Package Manager Insider Program](http://aka.ms/winget-InsiderProgram) and request to be included in the preview. Either of the Insider programs will ensure you automatically receive updates as we progress from preview to general availability. After you have joined either Insider program, head over to the Microsoft Store and get the [App Installer](ms-windows-store:/pdp/?productid=9nblggh4nns1). The Windows Package manager will be available after you get the update.

[![The App Installer in the Microsoft Store](https://devblogs.microsoft.com/commandline/wp-content/uploads/sites/33/2020/05/winget03.png)](https://devblogs.microsoft.com/commandline/wp-content/uploads/sites/33/2020/05/winget03.png)

### Why not contribute to another open source package manager?

We looked at several other package managers. There were several reasons leading us to create a new solution. One critical concern we had was how to build a repository of trusted applications. We are automatically checking each manifest. We leverage SmartScreen, static analysis, SHA256 hash validation and a few other processes to reduce the likelihood of malicious software making its way into the repository and onto your machine. Another key challenge was all the changes required to be able to deliver the client program as a native Windows application.

### Which versions of Windows will be supported?

Windows Package Manager will support every Windows 10 version since the Fall Creators Update (1709)! The Windows Package Manager will be delivered with the Desktop App Installer when we ship version 1.0. If you are building software to run on Windows 10 you will have a simple way for your customers to install your software on billions of machines.

### But what about...

We are expecting you have plenty of questions. What does this mean for the Windows store? It doesn't mean anything for the Windows store. The Windows Package Manager is a command line interface, no marketing, no images, no commerce. Although we do plan on making those apps installable too.

What about *insert any other package manager here*? We think they are great. If they want to leverage our repository of validated packages, they can. If they want to see how we are doing it, it is open source. We're open to feedback and suggestions.

We have already talked with a few of the well-known package manager teams. Chocolatey has a vibrant community with a massive collection of applications, and a rich history supporting both open source and enterprise customers. Scoop provides a convenient way to allow software to be installed without the UAC popups. Ninite keeps an eye on updates for all the apps it installed. There are many others like AppGet, Npackd and the PowerShell based OneGet package manager-manager.