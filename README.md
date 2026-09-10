# ⚔️ ButtonForge Classic v1.0.4

A complete recreation of the original **ButtonForge** addon for **Vanilla World of Warcraft (1.12)**, designed for **Turtle WoW** and other Vanilla-based servers.

Create fully customizable action bars while keeping the familiar look and behavior of the original World of Warcraft interface.

---

## 📥 Download

Download the addon directly from GitHub:

➡️ https://github.com/Wurmschwanz/ButtonForge-Classic-Reforged

Click the green **Code** button and select **Download ZIP**.

After extracting the archive, remove `-main` from the addon folder name if necessary and place the folder inside:

`World of Warcraft/Interface/AddOns/`

---

# ✨ Features

## 🎯 Action Bars

* Create multiple fully customizable action bars
* Freely position bars anywhere on the screen
* Adjustable rows and columns
* Adjustable button scale
* Bars stay anchored correctly when changing scale
* Separate **Position Lock** and **Action Lock**
* Optional bar backgrounds
* Show or hide empty action slots
* Mouseover mode with configurable fade delay
* Drag the entire bar from anywhere on its surface while in Configure Mode

---

## 🖱️ Drag & Drop

* Drag spells directly from the spellbook
* Drag items from your bags
* Drag macros from the macro window
* Move and swap actions between ButtonForge slots
* Drag actions from **ButtonForge to the default Blizzard action bars**
* Drag actions from **Blizzard action bars back to ButtonForge**
* Native WoW cursor behavior when dragging actions between different UI bars
* Stable internal ButtonForge action swapping
* Empty slots automatically appear as drop targets while dragging
* **Shift + Drag** can be used to move actions while Action Lock is enabled

---

## 🔒 Position & Action Locking

ButtonForge separates bar positioning from action movement.

### Position Lock

Controls whether the entire action bar can be moved.

### Action Lock

Controls whether spells, items and macros can be dragged from the buttons.

When **Action Lock** is enabled, actions can still be moved using:

**Shift + Drag**

This provides behavior similar to the default Blizzard action bars.

---

## ⌨️ Keybindings

* Built-in Keybinding Mode
* Character-specific keybindings
* Supports:

  * Keyboard keys
  * Mouse Wheel
  * Middle Mouse Button
  * Mouse Button 4
  * Mouse Button 5
* Protects Left and Right Mouse Buttons from accidental binding
* Keybindings remain attached to button positions when swapping actions
* Improved hotkey abbreviations:

  * `MM`
  * `M4`
  * `M5`
  * `MWU`
  * `MWD`

---

## ⚔️ Blizzard-Style Button Behavior

* Blizzard-style cooldown spiral
* Global Cooldown (GCD) support
* Spell cooldowns
* Item cooldowns
* Range indicator
* Out of Mana indicator
* Stack count display
* Missing consumables are automatically grayed out
* Proper handling of consumables and non-stackable items
* Familiar Blizzard-style drag & drop behavior

---

## 🖥️ Minimap Menu

ButtonForge includes a redesigned **Minimap Configuration Menu**.

The minimap button acts as the central control point for the addon.

From the menu you can:

* Select an action bar
* Create new bars
* Delete bars
* Enter Configure Mode
* Enter Keybinding Mode
* Change rows and columns
* Change button scale
* Lock bar position
* Lock actions
* Toggle bar backgrounds
* Show or hide empty slots
* Enable Mouseover Mode
* Adjust Mouseover delay

No Slash Commands are required for normal configuration.

---

## 🖱️ Minimap Button Controls

* **Left Click** – Open / close the ButtonForge menu
* **Right Click** – Toggle Configure Mode
* **Shift + Left Click** – Toggle Keybinding Mode
* **Alt + Drag** – Move the minimap button

The configuration menu can also be opened with:

`/bf menu`

---

## 🚀 Performance

* Event-driven updates
* Optimized range checks
* Lightweight action bar system
* Low CPU usage
* No additional addon libraries required
* Designed to remain lightweight even with multiple bars
* High FPS friendly

---

# 🔧 Improvements in v1.0.4

* Completely redesigned Minimap Menu
* Centralized action bar configuration
* Added separate **Position Lock** and **Action Lock**
* Added Blizzard-style **Shift + Drag** behavior
* Added ButtonForge ↔ Blizzard action bar drag & drop
* Improved native cursor handling
* Improved internal action swapping
* Bars now keep their position when changing scale
* Bars can now be dragged from anywhere while configuring
* Improved empty slot visibility
* Empty slots appear automatically while dragging actions
* Improved Configure Mode behavior
* Improved action bar positioning
* Improved hotkey display
* Improved macro and item handling
* Additional UI and performance optimizations

---

# 🐞 Bug Fixes

* Fixed bars moving unexpectedly when changing scale
* Fixed **Show Empty Slots** not working correctly in Configure Mode
* Fixed empty slots always being visible while configuring
* Fixed having to click between action buttons to move a bar
* Fixed inconsistent action swapping
* Fixed occasional drag & drop failures
* Fixed disappearing empty slots
* Fixed button click issues
* Fixed keybinding persistence
* Fixed macro drag & drop
* Fixed cooldown handling
* Fixed stack count display
* Fixed missing consumable detection
* Fixed range indicator responsiveness
* Fixed various UI and localization issues

---

## ❤️ Thank You

Thank you to everyone who tested **ButtonForge Classic**, reported bugs and provided ideas and feedback.

The goal is to keep ButtonForge lightweight, reliable and close to the original Vanilla World of Warcraft experience while adding useful quality-of-life features.

Enjoy **ButtonForge Classic**!
