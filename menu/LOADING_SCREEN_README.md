# Loading Screen System for Big Mac's Rainforest Escape

## Overview
This loading screen system provides a beautiful, themed loading experience for your rainforest escape game. It includes animated elements, progress tracking, and educational tips about rainforests.

## Features
- 🌳 **Rainforest Theme**: Green gradient backgrounds and floating leaf animations
- 📊 **Progress Bar**: Visual progress indicator with percentage display
- 💡 **Educational Tips**: Rotating tips about rainforest layers and gameplay
- 🍃 **Animated Elements**: Floating leaves and spinning loading indicators
- 🔄 **Smooth Transitions**: Seamless scene loading with threaded resource loading

## Files Created
- `loading_screen.tscn` - The loading screen scene
- `loading_screen.gd` - Loading screen logic and animations
- `main_menu.tscn` - Main menu with rainforest theme
- `main_menu.gd` - Main menu logic
- `scene_transition_manager.gd` - Singleton for managing scene transitions
- `level_1_forest_floor.tscn` - Example level scene
- `level_1_forest_floor.gd` - Example level logic

## How to Use

### Basic Usage
```gdscript
# Load any scene with loading screen
SceneTransitionManager.load_scene("res://your_scene.tscn")

# Or use the convenience methods
SceneTransitionManager.load_level_1()
SceneTransitionManager.load_level_2()
SceneTransitionManager.load_main_menu()
```

### From Any Script
```gdscript
# In any script, you can call:
SceneTransitionManager.load_scene("res://path/to/scene.tscn")
```

### Custom Loading Tips
Edit the `loading_tips` array in `loading_screen.gd` to add your own educational content:
```gdscript
var loading_tips: Array[String] = [
    "Tip: The rainforest has four distinct layers to explore!",
    "Tip: Your custom tip here!",
    # Add more tips...
]
```

## Project Setup
The system is already configured in your `project.godot`:
- Main scene set to `main_menu.tscn`
- `SceneTransitionManager` added as autoload

## Customization

### Colors and Theme
- Edit the gradient colors in `loading_screen.tscn`
- Modify background colors in both scenes
- Adjust leaf colors and animations

### Animations
- Modify floating leaf patterns in `setup_animations()`
- Adjust timing and movement in the tween animations
- Add more animated elements as needed

### Loading Tips
- Add more educational content about rainforests
- Include gameplay hints and tips
- Rotate tips every 3 seconds (configurable)

## Integration with Your Game
1. **Level Transitions**: Use `SceneTransitionManager.load_scene()` between levels
2. **Menu Navigation**: All menu buttons use the loading system
3. **Error Handling**: Failed loads are handled gracefully
4. **Performance**: Uses threaded loading for smooth experience

## Next Steps
- Create the remaining level scenes (Level 2-4)
- Add Big Mac character and gameplay mechanics
- Implement collectible nuts system
- Add sound effects and music
- Create level selection menu

## Tips for Development
- Test loading times with larger scenes
- Adjust loading duration in `start_loading()` if needed
- Add more visual elements as your game grows
- Consider adding a skip option for faster testing

Enjoy building Big Mac's Rainforest Escape! 🦜🌳
