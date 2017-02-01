---
title: "Preventing Windows Apps from Broadcasting a Taskbar Notification"
date: "2016-07-02 12:33"
date_modified: "2016-08-04 13:47"
comments: true
image:
  path: /assets/img/2016/07/banner.png
  alt: Windows registry notification entry
  height: 480
  width: 1011
published: true
tag: "small project"
description: "Using the Windows 10 registry editor to remove or mute application notifications in the system taskbar that will not stay hidden after a reboot."
---

A few weeks ago a Windows application on my computer was broadcasting notifications that I did not care for. I have an application that communicates with my uninterruptible power supply to shut down my machine in the event of a power outage after a few minutes. If this program estimates less than five minutes of reserve power, the program will broadcast a notification in the system taskbar (with sound!) letting me know.

> UPDATE: After the Windows 10 Anniversary Update, misbehaving applications no longer re-register an entry for notifications. This guide has now been made out of date as hiding Windows Notifications will now handle behavior correctly.

If you are familiar with Windows, then you know that there is a feature that allows you to hide notifications and icons to programs in the system tray. However, this application does not seem to respect those rules. Every time the application launches, it appears to reassociate itself and reset all settings made to keep it quiet. If I did manage to mute it, the changes would not survive a system reboot.

The notification is posted frequently, as my system's max power draw while gaming will trigger the UPS power draw warning. I found this to happen quite frequently when I was playing in virtual reality and it was continually breaking my immersion by ringing out system notifications in the middle of [Vanishing Realms](http://store.steampowered.com/app/322770/).

I understand that this is to help prevent the user from unknowingly leaving their system vulnerable during an outage when the user is not there. But if I lose power while in my VR headset, I am going to know very quickly that my machine should be shut off (not to mention my entire VR world will go black).

I wanted to keep the functionality of my uninterruptible power supply communications program, but I also wanted to remove the annoying notification. I did a bit of digging inside the Windows registry (Windows 10 64-bit) and found to be what looks like a set of the registry keys responsible for relaying an application notification.

## Removing the Notification

This is a _very quick and dirty_ registry hack to prevent applications from relaying notifications in the system taskbar. Windows notifications are sent by writing to a parent registry key associated with an application. Each application will attempt to add notifications as a sub-key to the registered parent key. By removing my user's permission to write to the parent key, the application will be unable to add sub-keys, and silently fails when it attempts to send notifications. I have not noticed any problems yet, but your mileage may vary.

In case it helps, my machine is using Windows 10 Pro 64-bit.

### Finding the Notification Key

The first step is to find the key inside the registry associated with the application. Browse to:

```
HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Current\
```

One will find a list of keys for applications registered for the system notifications. If the application you’re looking for does not immediately jump out, it is probably one of the `Microsoft.Explorer.Notification.{XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}` keys.

The only information that I could find about this and how the key is decided is the claim that [it is the application GUID](https://github.com/mumble-voip/mumble/issues/1777#issue-98981400). However, my research has found that this registry key does not match the GUID for the installed application. My theory is that it is randomly generated upon install. But I have not yet verified this.

![The notification for my battery adding a subkey in the registry](/assets/img/2016/07/regedit0.png)*The notification for my battery adding a subkey in the registry*

When the registered application has no notification to display, there will be no subkeys listed for that registry key. However, while a notification is displayed, one can refresh the registry editor (F5 key) and see that a subkey has been added. This will help identify which registry keys are associated with the application notifications.

### Removing Control Permissions

Next, control permissions need to be removed from that specific registry key. Right-click on the parent key and select `Permissions…`.
![Editing Windows registry permissions](/assets/img/2016/07/regedit1.png)

Select the user currently logged into the machine and deny `Full control` and `Read` permissions. Apply these changes. Attempt to re-create the application notification in the taskbar. If unable to re-create, the correct changes were made. If not, undo the changes and try looking for the key again.

![Denying full control permissions in Windows registry](/assets/img/2016/07/regedit2.png)

These changes should allow for the removal of annoying applications that do not follow the proper guidelines or rules when it comes to Windows taskbar notifications. Sometimes programs have unintended consequences when the programmer makes assumptions about how and when a user will interact with their program. I was hit with a combination of a program that did not properly register notifications as well as provide no advanced options to disable such notifications (there *are* other advanced options under the program).

If anyone out there has a better method or would like to point out any unforeseen consequences with this, please let me know. For everyone else, this should help tame such applications inside their Windows taskbar.
