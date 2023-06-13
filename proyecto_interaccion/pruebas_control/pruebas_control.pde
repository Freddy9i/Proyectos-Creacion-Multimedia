import net.java.games.input.*;

Controller[] controllers;
Controller controller;
float xAxis, yAxis;

void setup() {
  size(400, 400);
  controllers = ControllerEnvironment.getDefaultEnvironment().getControllers();
  controller = findController("Controller");
}

void draw() {
  background(255);
  if (controller != null) {
    controller.poll();
    Component[] components = controller.getComponents();
    for (Component component : components) {
      if (component.isAnalog()) {
        float val = component.getPollData();
        if (component.getName().equals("x")) {
          xAxis = val;
        }
        if (component.getName().equals("y")) {
          yAxis = val;
        }
      } else {
        if (component.getPollData() == 1.0f) {
          if (component.getName().equals("button 0")) {
            print("A presionada");
          }
          if (component.getName().equals("button 1")) {
            print("B presionada");
          }
          // ...
        }
      }
    }
  }
}

Controller findController(String name) {
  for (Controller c : controllers) {
    if (c.getName().equals(name)) {
      return c;
    }
  }
  return null;
}
}
