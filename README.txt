# ⚒️ ButtonForge Classic Reforged

**ButtonForge Classic Reforged** is a recreation of the original **ButtonForge** addon for **Vanilla World of Warcraft 1.12**, designed for **Turtle WoW** and other Vanilla-based servers.

Create additional fully customizable action bars while keeping the original Vanilla look and feel.

---

## 📥 Download & Installation

1. Click **Code → Download ZIP** on GitHub.
2. Extract the downloaded archive.
3. Rename the folder:

```text
ButtonForge-Classic-Reforged-main
```

to:

```text
ButtonForge-Classic-Reforged
```

4. Move the folder into:

```text
World of Warcraft\Interface\AddOns\
```

The final structure should look like:

```text
Interface
└── AddOns
    └── ButtonForge-Classic-Reforged
        ├── ButtonForge-Classic-Reforged.toc
        ├── Core.lua
        ├── Bar.lua
        ├── Button.lua
        └── ...
```

Restart the game after installation.

---

# ✨ Features

## 🎯 Action Bars

* Create multiple fully customizable action bars
* Freely move and position bars anywhere on the screen
* Adjustable rows and columns
* Adjustable button scale
* Lock or unlock individual bars
* Optional bar backgrounds
* Automatically hide unused buttons outside configuration mode
* Mouseover mode with configurable fade-in and fade-out
* Native Vanilla-style appearance

---

## 🖱️ Drag & Drop

* Drag spells directly from the spellbook
* Drag items directly from your bags
* Drag macros from the macro window
* Move actions between ButtonForge buttons
* Swap actions between occupied buttons
* Drag actions between ButtonForge and Blizzard action bars
* Empty drop slots automatically appear when needed

---

## ⌨️ Keybindings

* Built-in keybinding mode
* Assign keys directly to ButtonForge buttons
* Keybindings stay attached to the physical button position
* Keybinds are saved with ButtonForge
* Safe runtime bindings without modifying your normal WoW keybinding file

---

## 🖥️ Configuration

ButtonForge can be configured through its built-in interface.

Use:

```text
/bf
```

or:

```text
/bfc
```

You can also use the **ButtonForge minimap button** to access the configuration menu.

---

## 🛠️ Commands

```text
/bf new
```

Create a new action bar.

```text
/bf delete
```

Delete the currently selected bar.

```text
/bf config
```

Toggle configuration mode.

```text
/bf keybind
```

Toggle keybinding mode.

```text
/bf cols 6
```

Set the number of columns.

```text
/bf rows 2
```

Set the number of rows.

```text
/bf size 6 2
```

Set columns and rows at the same time.

```text
/bf scale 1.2
```

Change the scale of the active bar.

```text
/bf lock
```

Lock the active bar.

```text
/bf unlock
```

Unlock the active bar.

```text
/bf bg
```

Toggle the background of the active bar.

```text
/bf bg all
```

Toggle backgrounds for all ButtonForge bars.

```text
/bf grid
```

Toggle empty button slots.

```text
/bf re
```
