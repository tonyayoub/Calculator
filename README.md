# Calculator

A simple Calculator app iOS project using SwiftUI

## Features

- Basic arithmetic operations: addition, subtraction, multiplication, division
- Advanced mathematical operations: sin, cos
- Online operation: Bitcoin
- Operations enabling and disabling
- Dark mode support

## Installation

Clone this repository and import into Xcode.

git clone https://github.com/tonyayoub/Calculator.git


## Usage

1. Open the project in Xcode.
2. Build and run the application on a simulator or physical device.

## Notes
- The calculator is missing a frame around the buttons. This looks OK in iPhone because the screen edges act as a frame but in iPad it does not look good. The reason for the missing frame is that I had to put the feature toggling on the same view and couldn't figure out a nice design to not let them look like they are outside the main app.

- For Modularization, I used XCode project groups/folders for code hierarchy. As a future enhancement, I can create a Swift package for networking and another one for calculation handling. 

- Sin, Cos and Bitcoin are used by entering a value, then tapping the operation. 

- Errors are handled locally without reporting to an error management module.


## Roadmap and Future Enhancements

- Creating an additional display for previously entered values and operations
- Creating a central error handling mechanism.
- Creating a frame around the buttons grid and the display.
- Support for landscape mode.
- Creating a module for networking and calculation handling
- Using Xcode Cloud for CI

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
