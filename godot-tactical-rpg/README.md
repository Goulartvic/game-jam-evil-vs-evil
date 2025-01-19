![banner](./docs/img/banner.png)

# About
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
[![Godot v3.4](https://img.shields.io/badge/Godot-v3.4-blue.svg)](https://github.com/ramaureirac/godot-tactical-rpg/tree/release/godot-v3.4)
[![Godot v4.0](https://img.shields.io/badge/Godot-v4.0-blue.svg)](https://github.com/ramaureirac/godot-tactical-rpg/tree/release/godot-v4.0)
[![Godot v4.2](https://img.shields.io/badge/Godot-v4.2-blue.svg)](https://github.com/ramaureirac/godot-tactical-rpg/tree/release/godot-v4.2)
[![Godot v4.3](https://img.shields.io/badge/Godot-v4.3-blue.svg)](https://github.com/ramaureirac/godot-tactical-rpg/tree/release/godot-v4.3)


A simple template for making <i>tactical role-playing games</i> on [Godot Engine 4](https://godotengine.org/).
This is not a fully functional game framework or a professional work, just a simple project made in our free time. 
Anyways, feel free to use this sample in your own game. 

- You can see all of the project's features on [YouTube](https://youtu.be/lJKWlLwYDZY).
- Another demo from [Open Source Games](https://www.youtube.com/watch?v=-AY6KEdX_3E).
- In case you are searching for some 2d projects, checkout [GDQuest](https://github.com/GDQuest/godot-2d-tactical-rpg-movement) or [TBS_GoDot](https://github.com/ja-brouil/TBS_GoDot)
- In case you are looking for a similar pathfinding project/tutorial: [GameDevArts](https://www.youtube.com/watch?v=fYtwZdQTP5A) (Not mine)


As mentioned before, this project uses [Godot Engine 4.3](https://godotengine.org/) (and was ported quite recently), so it will no longer support previous versions of the engine. If (for some reason) you still want to use an older version of Godot make sure to clone from the respective branch, but keep in mind that no new features will be added in the future.


# Features

- Turn based
- Grid movement
- Each pawn can move and attack
- Super basic (and stupid) enemy AI 
- Advanced camera panning, free look, zoom and rotations
    - Mouse, gamepad or keyboard-controlled
    - Configurable camera stray distance (radius)
- Blender map recognition -- [tutorial for Blender (with or without Godot Export) right here](./docs/tutorials/how-to-create-maps/README.md)!
- Controller Support

- Complete native Godot editor documentation across the project
- Toggleable Debugger
    - Sending to Output tab
    - Disable in TacticsConfig

### 4.3 Project refactoring:
[View Structure Overview Diagram](https://github.com/user-attachments/assets/65bb6862-6e84-4149-af5a-047a04f413eb)
- @mbusson made the project structure more scalable (shared assets architecture)
    - Models: Centralized storage for class parameters & logic
    - Modules: Self-contained reusable units (Godot Nodes)
    - Dedicated maps directory
    - Other smaller architecture changes to nest components logically
- Adapted code to follow [the official GDScript style guidelines](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html#one-statement-per-line)
- Slightly optimized framework performance



[![asset-store](./docs/img/asset-store.png)](https://godotengine.org/asset-library/asset/1295)


# Preview

![preview](./docs/img/preview.png)

# Contribute

All code contributions and opened issues are welcome! However, since I want to keep this project as simple as posible I suggest first open an issue suggesting your idea before sending a PR. its really sad reject work just because it doesn't allign to a projects vision or it overrides a core functionallity (If that is the case, it will be better to start your own fork).

I now there's a lot of entry game developers in here who is looking into collaborate on open-source projects (which is nice), if that's your case checkout the label "Good First Issue" in the Issues Tab. So that you can get involve into this project with simple features.


# Special thanks

- GDQuest
- Tiny Legions
- Miziziziz
- TutsByKai
- AdamCYounis
- Almost every other guy at Godot's formus / StackOverflow
