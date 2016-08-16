//: Playground - noun: a place where people can play

import UIKit

// Application
protocol ShapeDrawer {
    func drawShape()
}

class DrawingApp {
    let drawer: ShapeDrawer
    var cornerradius = 0
    
    init(drawer: ShapeDrawer) {
        self.drawer = drawer
    }
    
    func makePicture() {
        drawer.drawShape()
    }
}

// Component library
protocol AppSettings {
    var sketchRounderShapes: Bool { get }
}

class SketchComponent {
    private let settings: AppSettings
    
    init(settings: AppSettings) {
        self.settings = settings
    }
    
    func sketchShape() {
        if settings.sketchRounderShapes {
            print("Sketch Circle")
        } else {
            print("Sketch Square")
        }
    }
}

class TwoWayAdapter: ShapeDrawer, AppSettings {
    var app: DrawingApp?
    var component: SketchComponent?
    
    func drawShape() {
        component?.sketchShape()
    }
    
    var sketchRounderShapes: Bool {
        return app?.cornerradius > 0
    }
}

let adapter = TwoWayAdapter()
let component = SketchComponent(settings: adapter)
let app = DrawingApp(drawer: adapter)
adapter.app = app
adapter.component = component

app.makePicture()