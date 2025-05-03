# Common Properties

Many blocks in the XMPro App Designer share common properties that control their appearance, behavior, and data binding. This page describes these common properties that you'll encounter across multiple blocks.

## Basic Properties

### ID

- **Description**: A unique identifier for the block within the page.
- **Usage**: Used for referencing the block in expressions, scripts, and for data binding.
- **Type**: String

### Name

- **Description**: A human-readable name for the block.
- **Usage**: Used for identifying the block in the designer and for accessibility.
- **Type**: String

### Visible

- **Description**: Controls whether the block is visible on the page.
- **Usage**: Can be set to a static value or bound to an expression to dynamically show/hide the block.
- **Type**: Boolean

### Enabled

- **Description**: Controls whether the block is enabled or disabled.
- **Usage**: Can be set to a static value or bound to an expression to dynamically enable/disable the block.
- **Type**: Boolean

## Styling Properties

### Width

- **Description**: Controls the width of the block.
- **Usage**: Can be set to a specific pixel value, percentage, or auto.
- **Type**: String

### Height

- **Description**: Controls the height of the block.
- **Usage**: Can be set to a specific pixel value, percentage, or auto.
- **Type**: String

### Margin

- **Description**: Controls the external spacing around the block.
- **Usage**: Can be set for all sides or individually for top, right, bottom, and left.
- **Type**: String

### Padding

- **Description**: Controls the internal spacing within the block.
- **Usage**: Can be set for all sides or individually for top, right, bottom, and left.
- **Type**: String

### Background Color

- **Description**: Controls the background color of the block.
- **Usage**: Can be set to a color name, hex value, or transparent.
- **Type**: String

### Text Color

- **Description**: Controls the text color of the block.
- **Usage**: Can be set to a color name or hex value.
- **Type**: String

### Border

- **Description**: Controls the border of the block.
- **Usage**: Can set the border width, style, and color.
- **Type**: String

### Font

- **Description**: Controls the font properties of the block.
- **Usage**: Can set the font family, size, weight, and style.
- **Type**: String

## Data Binding Properties

### Data Source

- **Description**: Specifies the data source for the block.
- **Usage**: Connects the block to a data source defined in the page.
- **Type**: Object

### Data Field

- **Description**: Specifies the field from the data source to bind to the block.
- **Usage**: Used to display or edit a specific field from the data source.
- **Type**: String

### Value

- **Description**: The current value of the block.
- **Usage**: Can be set directly or bound to a data source field.
- **Type**: Varies based on block type

## Event Properties

### On Click

- **Description**: Action to perform when the block is clicked.
- **Usage**: Can be set to navigate to another page, update a data source, or execute a custom script.
- **Type**: Function

### On Change

- **Description**: Action to perform when the value of the block changes.
- **Usage**: Can be set to update a data source, validate input, or execute a custom script.
- **Type**: Function

### On Load

- **Description**: Action to perform when the block is loaded.
- **Usage**: Can be set to initialize the block, load data, or execute a custom script.
- **Type**: Function

## Accessibility Properties

### Tooltip

- **Description**: Text to display when hovering over the block.
- **Usage**: Provides additional information about the block's purpose or functionality.
- **Type**: String

### ARIA Label

- **Description**: Accessible label for screen readers.
- **Usage**: Improves accessibility for users with screen readers.
- **Type**: String

### Tab Index

- **Description**: Controls the tab order of the block.
- **Usage**: Determines the order in which blocks receive focus when tabbing through the page.
- **Type**: Number

## Conclusion

These common properties provide a consistent way to control the appearance, behavior, and data binding of blocks in the XMPro App Designer. While not all blocks support all of these properties, understanding these common properties will help you work more efficiently with the various blocks in the toolbox.
