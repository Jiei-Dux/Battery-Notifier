# Battery-Notifier

**REASON WHY I MADE THIS:**

Someone recommended that I:
> keep the battery at 20% to 85% to avoid degrading my laptop battery or at least make it last longer.

KDE already has a built-in battery notifier that can do a lot of things that I want.

> ie. notify to plug in the charger or make the device sleep at certain threshold / level, custom notification sounds, notification duration, etc.

Unfortunately, it wasn't good enough and I couldn't figure out how to make it do the things I wanted to do

> ie. notify me to unplug the charger at certain threshold / level, etc.

so I tried searching around internet for a script that works the way I wanted to, unfortunately, none worked, so I thought to myself

> Why don't I just make one myself?
and so I did... and here it is... Im not a very creative person so I'm just going to call this thing Battery-Notifier...

<br>
<br>

**REQUIRED PACKAGES:**
* Libnotify / libnotify
* Sound Exchange / sox

<br>
<br>

> NOTE:
> I am fairly new to Linux ( started around March 2023), and Im ( as of August 2023 ) an Irregular College student, I dont know what year I am now actually because my f**king previous school closed down...

**FUTURE PLANS:**
* [x] ~~Should work across distros~~

* [x] <b>Some Debugging Capabilities</b> - Its in the title... :3

* [ ] <b>Logging</b> - I wanted to add some logging functionality to this script just to keep a record of the batery status changes, notifications, and script activities. This can help me with stuff like, troubleshooting issues, tracking my laptop's, or another user's laptop's battery performance history.

* [ ] <b>Configurability</b> - I want to make this script configurable using environment variables or atleast a configuration file. That way, users can easily configure / customize threshold levels, notification settings, etc. without editing the script directly.

* [ ] <b>Cross-Platform Compatibility</b> - I may or may not do this... Im still deciding whether or not to do this, like, make this script compatible with other Unix-like systems or Windows...

* [ ] <b>User Interaction</b> - I kind of want to make my script interactable through the terminal... because you know... why not?

* [x] <b>Dependency Checks</b> - I really should do this next... make the script check if these things are installed on the system before trying to use them... Like check for the packages and libraries for the first time or at the start atleast...

* [x] <b>Error Handling</b> - Just some experiments :)

* [ ] <b>Custom Actions</b> - I kind of wanted to add this one also, like, this thing should enable the users to add their very own custom actions. Lets say for example, a user wanted to make the script do this and that when their battery is low instead of doing the default thing... know what I mean?

* [ ] <b>Documentation</b> - I dont know how to do this yet... maybe in the near future I will... but yeah... cant do this one yet... but I plan to...

