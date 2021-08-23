//
//  ContentView.swift
//  iTunes
//
//  Created by Zane Kleinberg on 8/22/21.
//

import SwiftUI
import PureSwiftUITools
struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            title_bar().frame(minHeight: 69, maxHeight: 69).clipped().zIndex(2).shadow(color: Color.black.opacity(0.55), radius: 0.55, x: 0, y: 1.25)
            itunes_content_view()
            footer_view().frame(height: 24)
        }.background(Color.white)
    }
}

struct itunes_content_view: View {
    @State var selected: String = "Music"
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                HStack(spacing: 0) {
                    sidebar_view(selected: $selected).frame(width: 180)
                    switch selected {
                    case "Music":
                        placeholder_music_view()
                    default:
                        Spacer()
                    }
                }
            }
        }
    }
}

struct placeholder_music_view: View {
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Color.white
                ScrollView {
                VStack {
                    ZStack {
                    RoundedRectangle(cornerRadius: 6).fill(Color.white).frame(width: 800, height: 475).shadow(color: Color.black.opacity(0.275), radius: 2, x: 0, y: 2)
                        VStack(spacing: 0) {
                            HStack {
                            Text("Music").font(.custom("Helvetica Neue Bold", size: 35)).foregroundColor(Color(red: 81/255, green: 81/255, blue: 81/255))
                                Spacer()
                            }.padding([.top, .leading, .trailing], 36)
                            HStack {
                                Text("Songs and music videos you add to iTunes appear in Music in your iTunes library. To play a song, just double-click it.").font(.custom("Helvetica Neue", size: 18)).foregroundColor(Color(red: 146/255, green: 146/255, blue: 146/255))
                                Spacer()
                            }.padding([.leading, .trailing], 36).padding(.top, 15)
                            HStack {
                                music_placeholder_content(geometry: geometry, image: "music_item_bag", top_text: "Download music.", sub_text: "Get new music for you library from the iTunes Store. Preview, buy, and download your favorite music, day or night.", final_content: {
                                    VStack(spacing: 2) {
                                        HStack {
                                        Text("Watch the tutorial").font(.custom("Helvetica Neue", size: 13)).foregroundColor(Color(red: 68/255, green: 153/255, blue: 209/255))
                                            Image("music_item_arrows").resizable().scaledToFit().frame(height: 12).offset(x: -2)
                                            Spacer()
                                    
                                        }
                                        HStack {
                                        Text("Shop for music in the iTunes Store").font(.custom("Helvetica Neue", size: 13)).foregroundColor(Color(red: 68/255, green: 153/255, blue: 209/255))
                                            Image("music_item_arrows").resizable().scaledToFit().frame(height: 12).offset(x: -2)
                                            Spacer()
                                        }
                                    }
                                })
                                Spacer()
                                music_placeholder_content(geometry: geometry, image: "large_cd", top_text: "Import your CDs.", sub_text: "With iTunes, any song in your CD collection is only a few clicks away. Import whole albums or just specific songs.", final_content: {
                                    VStack(alignment: .leading) {
                                        HStack {
                                        Text("Watch the tutorial").font(.custom("Helvetica Neue", size: 13)).foregroundColor(Color(red: 68/255, green: 153/255, blue: 209/255))
                                            Image("music_item_arrows").resizable().scaledToFit().frame(height: 12).offset(x: -2)
                                            Spacer()
                                        }
                                    }
                                })
                            }.padding([.leading, .trailing], 36).padding(.top, 15).offset(y: 35)
                            HStack {
                                music_placeholder_content_no_width(geometry: geometry, image: "music_files", top_text: "Find music files.", sub_text: "iTunes can search your Home folder for MP3 and AAC files you already have.", final_content: {
                                    VStack(alignment: .leading) {
                                        HStack {
                                        Text("Find MP3 and AAC files in my Home folder").font(.custom("Helvetica Neue", size: 13)).foregroundColor(Color(red: 68/255, green: 153/255, blue: 209/255))
                                            Image("music_item_arrows").resizable().scaledToFit().frame(height: 12).offset(x: -2)
                                            Spacer()
                                        }
                                    }
                                })
                                Spacer()
                            }.padding([.leading, .trailing], 36).padding(.top, 15).offset(y: 45)
                            Spacer()
                        }.frame(width: 800, height: 475)
                    }.padding(.top, 40)
                    Spacer()
                }.frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}

struct music_placeholder_content_no_width<FinalContent: View>: View {
    var geometry: GeometryProxy
    var image: String
    var top_text: String
    var sub_text: String
    var final_content: FinalContent
    
    init(geometry: GeometryProxy, image: String, top_text: String, sub_text: String, @ViewBuilder final_content: @escaping () -> FinalContent) {
        self.geometry = geometry
        self.image = image
        self.top_text = top_text
        self.sub_text = sub_text
        self.final_content = final_content()
    }
    
    var body: some View {
        VStack {
            HStack(alignment:. top) {
                Image(image).resizable().scaledToFit().frame(height: 60)
                VStack(alignment: .leading) {
                    Text(top_text).font(.custom("Helvetica Neue Bold", size: 16)).foregroundColor(Color(red: 81/255, green: 81/255, blue: 81/255))
                    Text(sub_text).font(.custom("Helvetica Neue", size: 13)).foregroundColor(Color(red: 146/255, green: 146/255, blue: 146/255))
                    Spacer().frame(height: 25)
                    final_content
                    Spacer()
                }
            }
//            HStack(alignment:. top) {
//                Image(image).resizable().scaledToFit().frame(height: 60).opacity(0)
//                final_content
//                Spacer()
//            }.frame(width:400-36*2)
        }
    }
}

struct music_placeholder_content<FinalContent: View>: View {
    var geometry: GeometryProxy
    var image: String
    var top_text: String
    var sub_text: String
    var final_content: FinalContent
    
    init(geometry: GeometryProxy, image: String, top_text: String, sub_text: String, @ViewBuilder final_content: @escaping () -> FinalContent) {
        self.geometry = geometry
        self.image = image
        self.top_text = top_text
        self.sub_text = sub_text
        self.final_content = final_content()
    }
    
    var body: some View {
        VStack {
            HStack(alignment:. top) {
                Image(image).resizable().scaledToFit().frame(height: 60)
                VStack(alignment: .leading) {
                    Text(top_text).font(.custom("Helvetica Neue Bold", size: 16)).foregroundColor(Color(red: 81/255, green: 81/255, blue: 81/255))
                    Text(sub_text).font(.custom("Helvetica Neue", size: 13)).foregroundColor(Color(red: 146/255, green: 146/255, blue: 146/255))
                    Spacer().frame(height: 25)
                    final_content
                    Spacer()
                }
            }.frame(width:400-36*2)
//            HStack(alignment:. top) {
//                Image(image).resizable().scaledToFit().frame(height: 60).opacity(0)
//                final_content
//                Spacer()
//            }.frame(width:400-36*2)
        }
    }
}

struct footer_view: View {
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Image("13204").resizable(capInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0), resizingMode: .tile).frame(width: geometry.size.width, height: 24)
                HStack(spacing: 22) {
                    Image("15431").resizable().scaledToFit().padding([.top, .bottom], 5).padding(.leading, 22)
                    Image("15433").resizable().scaledToFit().padding([.top, .bottom], 5)
                    Image("15432").resizable().scaledToFit().padding([.top, .bottom], 5)
                    Image("15655").resizable().scaledToFit().padding([.top, .bottom], 5)
                    Spacer()
                }.offset(y: 1)
            }
        }
    }
}

struct sidebar_item: Identifiable {
    var id = UUID()
    var name: String
    var image: String
}

struct sidebar_view: View {
    @Binding var selected: String
    var lb_items = [sidebar_item(name: "Music", image: "row-1-column-1"), sidebar_item(name: "Movies", image: "row-2-column-1"), sidebar_item(name: "TV Shows", image: "row-3-column-1"), sidebar_item(name: "Radio", image: "row-5-column-1")]
    var st_items = [sidebar_item(name: "iTunes Store", image: "row-7-column-1")]
    var device_items = [sidebar_item(name: "iPhone", image: "row-46-column-1")]
    var shared_items = [sidebar_item(name: "Home Sharing", image: "row-32-column-1")]
    var genius_items = [sidebar_item(name: "Genius", image: "row-28-column-1")]
    var playlist_items = [sidebar_item(name: "iTunes DJ", image: "row-18-column-1"), sidebar_item(name: "90's Music", image: "row-20-column-1"), sidebar_item(name: "Classical Music", image: "row-20-column-1"), sidebar_item(name: "Music Videos", image: "row-20-column-1"), sidebar_item(name: "My Top Rated", image: "row-20-column-1"), sidebar_item(name: "Recently Added", image: "row-20-column-1"),  sidebar_item(name: "Recently Played", image: "row-20-column-1"), sidebar_item(name: "Top 25 Most Played", image: "row-20-column-1")]
    let gradient = LinearGradient([(Color(red: 109/255, green: 159/255, blue: 213/255), location: 0), (Color(red: 109/255, green: 159/255, blue: 213/255), location: 0.05), (Color(red: 137/255, green: 183/255, blue: 226/255), location: 0.05), (Color(red: 137/255, green: 183/255, blue: 226/255), location: 0.1), (Color(red: 124/255, green: 173/255, blue: 221/255), location: 0.1), (Color(red: 85/255, green: 138/255, blue: 204/255), location: 1 - 0.01), (Color(red: 74/255, green: 124/255, blue: 196/255), location: 1 - 0.075), (Color(red: 74/255, green: 124/255, blue: 196/255), location: 1)], from: .top, to: .bottom)
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Color(red: 223/255, green: 227/255, blue: 232/255).frame(width: geometry.size.width, height: geometry.size.height).custom_border(width: 1, edges: [.trailing], color: Color(red: 187/255, green: 187/255, blue: 187/255))
                VStack(spacing: 0) {
                    sidebar_group(title: "LIBRARY", items: lb_items, geometry: geometry, selected: $selected)
                    sidebar_group(title: "STORE", items: st_items, geometry: geometry, selected: $selected)
                    sidebar_group(title: "DEVICES", items: device_items, geometry: geometry, selected: $selected)
                    sidebar_group(title: "SHARED", items: shared_items, geometry: geometry, selected: $selected)
                    sidebar_group(title: "GENIUS", items: genius_items, geometry: geometry, selected: $selected)
                    sidebar_group(title: "PLAYLISTS", items: playlist_items, geometry: geometry, selected: $selected)
                    
                    Spacer()
                }
            }
        }
    }
}

struct sidebar_group: View {
    var title: String
    var items: [sidebar_item]
    var geometry: GeometryProxy
    var is_first: Bool?
    @Binding var selected: String
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title).font(.custom("Lucida Grande Bold", size: 11)).foregroundColor(Color(red: 115/255, green: 126/255, blue: 139/255)).shadow(color: Color.white.opacity(0.6), radius: 0, x: 0, y: 1).padding(.leading, 7.5)
                Spacer()
            }.padding(.top, (is_first ?? false) ? 5 : 8).padding(.bottom, 5.5)
        ForEach(items) {item in
            Button(action: {selected = item.name}) {
                HStack(spacing: 5.5){
                    Image(selected == item.name ? item.image : "\(item.image)-unselected").resizable().scaledToFit().padding([.top, .bottom], 1).padding(.leading, 15)
                    if selected == item.name {
                        Text(item.name).font(.custom("Lucida Grande Bold", size: 11)).foregroundColor(.white).shadow(color: Color.black.opacity(0.2), radius: 0, x: 0, y: 1)
                    } else {
                        Text(item.name).font(.custom("Lucida Grande", size: 11)).foregroundColor(.black)
                    }
                Spacer()
            }.contentShape(Rectangle())
            }.buttonStyle(BlankButtonStyle()).frame(width: geometry.size.width, height: 20).if(selected == item.name) {
                $0.background(Image("selected_background").resizable(capInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0), resizingMode: .tile).frame(width: geometry.size.width, height: 20))
            }
        }
        }
    }
}

struct BlankButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Color.clear)
    }
    
}

struct title_bar: View {
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Image("13200").resizable(capInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0), resizingMode: .tile).frame(width: geometry.size.width, height: 69).innerShadowBottomView(color: Color.white.opacity(0.5), radius: 0.01)
                VStack(spacing: 0) {
                    //   Spacer()
                    HStack {
                        Spacer()
                        Text("iTunes").foregroundColor(Color.black).font(.custom("Lucida Grande", size: 13)).shadow(color: Color.white.opacity(0.51), radius: 0, x: 0.0, y: 2/3)
                        Spacer()
                    }.padding([.top, .bottom], 4)
                    ZStack {
                    title_bar_display_view().frame(width: geometry.size.width/2.12).padding(.bottom, 4)
                        HStack {
                            title_bar_controls_view().padding(.leading, 40).padding([.top, .bottom], 4)
                            Spacer().frame(width: geometry.size.width/8 - 165)
                            title_slider_view()
                            Spacer()
                            ZStack {
                                search_bar().frame(width: geometry.size.width/8.2, height: 22).cornerRadius(11)
                            }.clipped().strokeCapsule(LinearGradient([Color(red: 195/255, green: 195/255, blue: 195/255), Color(red: 204/255, green: 205/255, blue: 205/255)], from: .top, to: .bottom), lineWidth: 0.9).frame(width: geometry.size.width/8.2 + 1.8, height: 22 + 1.8).shadow(color: Color.white.opacity(0.28), radius: 0.3, x: 0, y: 0.5).padding(.trailing, 20)
                        }
                    }
                }
            }
        }
    }
}


struct title_slider_view: View {
    @State var slider_val: Double = Double(NSSound.systemVolume() * 100)
    @State var show_pressed: Bool = false
    var body: some View {
        HStack(spacing: 1) {
            Image("part_vol").resizable().scaledToFit().padding([.top, .bottom], 6.2)
            CustomSlider(type: "Volume", value: $slider_val,  range: (0, 100), show_pressed: $show_pressed) { modifiers in
                   ZStack {
                    ZStack {
                        Image("13200").resizable(capInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0), resizingMode: .tile).brightness(-0.2).frame(height: 80).offset(y: -5).mask(RoundedRectangle(cornerRadius: 11/2).frame(height: 11))
                    }.clipped().frame(height:11).ps_innerShadow(.roundedRectangle(11/2), radius: 2.8, offset: CGPoint(-2, 2), intensity: 0.62).clipped().shadow(color: Color.white.opacity(0.3), radius: 0, x: 0, y: 1).padding(.leading, 4).modifier(modifiers.barLeft)
                    ZStack {
                        Image("13200").resizable(capInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0), resizingMode: .tile).frame(height: 80).offset(y: -5).mask(RoundedRectangle(cornerRadius: 11/2).frame(height: 11))
                    }.clipped().frame(height:11).ps_innerShadow(.roundedRectangle(11/2), radius: 2.8, offset: CGPoint(2, 2), intensity: 0.62).clipped().shadow(color: Color.white.opacity(0.3), radius: 0, x: 0, y: 1).padding(.trailing, 4).modifier(modifiers.barRight)
                       ZStack {
                        Image(show_pressed ? "slider_thumb_pressed" : "slider_thumb").resizable().scaledToFill().offset(y: 1)
                       }.modifier(modifiers.knob)
                   }
            }.frame(width: 125, height: 19)
            Image("full_vol").resizable().scaledToFit().padding([.top, .bottom], 6.2)
        }.frame(height: 22)
    }
}

extension NSTextField { // << workaround !!!
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}




struct search_bar: View {
    @State var search: String = ""
    @State var editing_state_google: String = "None"
    private let gradient = LinearGradient([.white, .white], to: .trailing)
    private let cancel_gradient = LinearGradient([(color: Color(red: 164/255, green: 175/255, blue:191/255), location: 0), (color: Color(red: 124/255, green: 141/255, blue:164/255), location: 0.51), (color: Color(red: 113/255, green: 131/255, blue:156/255), location: 0.51), (color: Color(red: 112/255, green: 130/255, blue:155/255), location: 1)], from: .top, to: .bottom)
    var body: some View {
        HStack(spacing: 0) {
            Image("16656").resizable().scaledToFit().padding(.leading, 5.2).padding([.top,.bottom], 4.3).offset(y: 1)
            HStack (alignment: .center,
                    spacing: 10) {
                TextField ("Search", text: $search, onEditingChanged: { (editingChanged) in
                    if editingChanged {
                        editing_state_google = "Foc"
                    } else {
                        editing_state_google = "None"
                    }
                }) {
                }.textFieldStyle(PlainTextFieldStyle()).textFieldStyle(PlainTextFieldStyle()).font(.custom("Lucida Grande", size: 13))
            }.offset(y: 0.5)
            
            .padding([.top,.bottom], 5)
            .padding(.leading, 4)
            Spacer(minLength: 8)
        } .ps_innerShadow(.capsule(gradient), radius:1.8, offset: CGPoint(0, 2), intensity: 0.3)
    }
}

struct title_bar_controls_view: View {
    var body: some View {
        HStack {
            Image("15322-r").resizable().scaledToFit().padding([.top, .bottom], 2)
            Image("15320-p").resizable().scaledToFit()
            Image("15324-f").resizable().scaledToFit().padding([.top, .bottom], 2)
        }
    }
}

struct title_bar_display_view: View {
    private let gradient = LinearGradient([(Color(red: 238/255, green: 240/255, blue: 226/255), location: 0), (Color(red: 231/255, green: 233/255, blue: 214/255), location: 0.5), (Color(red: 224/255, green: 226/255, blue: 202/255), location: 0.5), (Color(red: 247/255, green: 248/255, blue: 227/255), location: 0.98), (Color(red: 234/255, green: 235/255, blue: 211/255), location: 0.98), (Color(red: 234/255, green: 235/255, blue: 211/255), location: 1)], from: .top, to: .bottom)
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 4).fill(gradient).strokeRoundedRectangle(4, LinearGradient([Color(red: 107/255, green: 108/255, blue: 96/255), Color(red: 170/255, green: 173/255, blue: 153/255)], from: .top, to: .bottom), lineWidth: 0.9).shadow(color: Color.white.opacity(0.4), radius: 0, y: 0.25)
                Image("15154").resizable().scaledToFit().padding([.top, .bottom], 3.25)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
