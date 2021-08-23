//
//  ContentView.swift
//  iTunes
//
//  Created by Zane Kleinberg on 8/22/21.
//

import SwiftUI
import PureSwiftUITools

struct CustomSliderComponents {
    let barLeft: CustomSliderModifier
    let barRight: CustomSliderModifier
    let knob: CustomSliderModifier
}
struct CustomSliderModifier: ViewModifier {
    enum Name {
        case barLeft
        case barRight
        case knob
    }
    let name: Name
    let size: CGSize
    let offset: CGFloat

    func body(content: Content) -> some View {
        content
        .frame(width: size.width)
        .position(x: size.width*0.5, y: size.height*0.5)
        .offset(x: offset)
    }
}

struct CustomSlider<Component: View>: View {
    @Binding var value: Double
    @Binding var should_update_from_timer: Bool?
    @Binding var duration: Double?
    @Binding var show_pressed: Bool
    var type: String
    var range: (Double, Double)
    var knobWidth: CGFloat?
    let viewBuilder: (CustomSliderComponents) -> Component

    init(type: String, should_update_from_timer: Binding<Bool?> = .constant(true), duration: Binding<Double?> = .constant(0), value: Binding<Double>, range: (Double, Double), knobWidth: CGFloat? = nil, show_pressed: Binding<Bool>,
         _ viewBuilder: @escaping (CustomSliderComponents) -> Component
    ) {
        self.type = type
        _should_update_from_timer = should_update_from_timer
        _duration = duration
        _value = value
        _show_pressed = show_pressed
        self.range = range
        self.viewBuilder = viewBuilder
        self.knobWidth = knobWidth
    }

    var body: some View {
      return GeometryReader { geometry in
        self.view(geometry: geometry) // function below
      }
    }


    private func view(geometry: GeometryProxy) -> some View {
        var frame = geometry.localFrame
        if type == "Song" {
           frame = geometry.frame(in: .local)
        } else {
     frame = geometry.frame(in: .global)
        }
      let drag = DragGesture(minimumDistance: 0).onChanged({ drag in
        self.onSliderDragChange(drag, frame)
        self.show_pressed = true
      }
            
      ).onEnded({ _ in
        self.show_pressed = false
        if type == "Song" {
           should_update_from_timer = true
       } //Maybe unnecesary now
      })
      let offsetX = self.getOffsetX(frame: frame)
    
      let knobSize = CGSize(width: knobWidth ?? frame.height, height: frame.height)
      let barLeftSize = CGSize(width: CGFloat(offsetX + knobSize.width * 0.5), height:  frame.height)
      let barRightSize = CGSize(width: frame.width - barLeftSize.width, height: frame.height)

      let modifiers = CustomSliderComponents(
          barLeft: CustomSliderModifier(name: .barLeft, size: barLeftSize, offset: 0),
          barRight: CustomSliderModifier(name: .barRight, size: barRightSize, offset: barLeftSize.width),
          knob: CustomSliderModifier(name: .knob, size: knobSize, offset: offsetX))
      return ZStack { viewBuilder(modifiers).gesture(drag) }
    }
    private func onSliderDragChange(_ drag: DragGesture.Value,_ frame: CGRect) {
        let width = (knob: Double(knobWidth ?? frame.size.height), view: Double(frame.size.width))
        let xrange = (min: Double(0), max: Double(width.view - width.knob))
        var value = Double(drag.startLocation.x + drag.translation.width) // knob center x
        value -= 0.5*width.knob // offset from center to leading edge of knob
        value = value > xrange.max ? xrange.max : value // limit to leading edge
        value = value < xrange.min ? xrange.min : value // limit to trailing edge
        value = value.convert(fromRange: (xrange.min, xrange.max), toRange: range)
        self.value = value
//        if type == "Brightness" {
//            UIScreen.main.brightness = CGFloat(value/100)
//        }
        if type == "Volume" {
            NSSound.setSystemVolume(Float(value/100))
        }
    }
    private func getOffsetX(frame: CGRect) -> CGFloat {
        let width = (knob: knobWidth ?? frame.size.height, view: frame.size.width)
        let xrange: (Double, Double) = (0, Double(width.view - width.knob))
        let result = self.value.convert(fromRange: range, toRange: xrange)
        return CGFloat(result)
    }
}

extension Double {
    func convert(fromRange: (Double, Double), toRange: (Double, Double)) -> Double {
        var value = self
        value -= fromRange.0
        value /= Double(fromRange.1 - fromRange.0)
        value *= toRange.1 - toRange.0
        value += toRange.0
        return value
    }
}

extension View {
    func innerShadowBottomView(color: Color, radius: CGFloat = 0.1) -> some View {
        modifier(InnerShadow_Bottom_View(color: color, radius: min(max(0, radius), 1)))
    }
    func innerShadowSliderMultiDiffed(color: Color, radius: CGFloat = 0.1) -> some View {
          modifier(InnerShadowSliderDiffed(color: color, radius: min(max(0, radius), 1)))
      }
    func innerShadowSliderMulti(color: Color, radius: CGFloat = 0.1) -> some View {
        modifier(InnerShadowSliderMulti(color: color, radius: min(max(0, radius), 1)))
    }
    func custom_border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}


struct EdgeBorder: Shape {
    
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }
            
            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }
            
            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }
            
            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

private struct InnerShadow_Bottom_View: ViewModifier {
    var color: Color = .gray
    var radius: CGFloat = 0.1
    
    private var colors: [Color] {
        [color.opacity(0.75), color.opacity(0.0), .clear]
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .bottom, endPoint: .top)
                            .frame(height: self.radius * self.minSide(geo)),
                         alignment: .bottom)
        }
    }
    
    func minSide(_ geo: GeometryProxy) -> CGFloat {
        CGFloat(3) * min(geo.size.width, geo.size.height) / 2
    }
}

private struct InnerShadowSliderMulti: ViewModifier {
    var color: Color = .gray
    var radius: CGFloat = 0.1
    
    private var colors: [Color] {
        [color.opacity(0.75), color.opacity(0.0), .clear]
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .top, endPoint: .bottom)
                            .frame(height: self.radius * self.minSide(geo) * 1.25),
                         alignment: .top)
                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .bottom, endPoint: .top)
                            .frame(height: self.radius * self.minSide(geo) * 0.25),
                         alignment: .bottom)
                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .trailing, endPoint: .leading)
                                  .frame(width: self.radius * self.minSide(geo)),
                                       alignment: .trailing)
        }
    }
    
    func minSide(_ geo: GeometryProxy) -> CGFloat {
        CGFloat(3) * min(geo.size.width, geo.size.height) / 2
    }
}


private struct InnerShadowSliderDiffed: ViewModifier {
    var color: Color = .gray
    var radius: CGFloat = 0.1
    
    private var colors: [Color] {
        [color.opacity(0.75), color.opacity(0.0), .clear]
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .top, endPoint: .bottom)
                            .frame(height: self.radius * self.minSide(geo) * 0.75).offset(y: 0.1),
                         alignment: .top)
                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .bottom, endPoint: .top)
                            .frame(height: self.radius * self.minSide(geo)*0.25).opacity(0.45),
                         alignment: .bottom)
                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .leading, endPoint: .trailing)
                            .frame(width: self.radius * self.minSide(geo)*0.1),
                                       alignment: .leading)
        }
    }
    
    func minSide(_ geo: GeometryProxy) -> CGFloat {
        CGFloat(3) * min(geo.size.width, geo.size.height) / 2
    }
}
