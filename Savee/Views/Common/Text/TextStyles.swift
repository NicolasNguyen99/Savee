//
//  Header1Text.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import SwiftUI

struct Header1Text: ViewModifier {
    func body(content: Content) -> some View {
        HStack() {
            content
                .font(.title.weight(.bold))
                .foregroundColor(Color("saveeBlue"))
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            Spacer()
        }
    }
}

extension View {
    func header1TextStyle() -> some View {
        modifier(Header1Text())
    }
}

struct Header3Text: ViewModifier {
    func body(content: Content) -> some View {
        HStack() {
            content
                .font(.subheadline.weight(.bold))
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            Spacer()
        }
    }
}

extension View {
    func header3TextStyle() -> some View {
        modifier(Header3Text())
    }
}

struct FootNote: ViewModifier {
    func body(content: Content) -> some View {
        HStack() {
            content
                .font(.caption.weight(.light))
                .foregroundColor(Color.gray)
            Spacer()
        }
    }
}

extension View {
    func footNoteTextStyle() -> some View {
        modifier(FootNote())
    }
}

struct FootNoteW: ViewModifier {
    func body(content: Content) -> some View {
        HStack() {
            content
                .font(.caption.weight(.light))
                .foregroundColor(Color.gray)
        }
    }
}

extension View {
    func footNoteWTextStyle() -> some View {
        modifier(FootNoteW())
    }
}

struct Caption1Text: ViewModifier {
    func body(content: Content) -> some View {
        HStack() {
            content
                .font(.largeTitle.weight(.bold))
                .foregroundColor(Color("saveeBlue"))
        }
    }
}

extension View {
    func caption1TextStyle() -> some View {
        modifier(Caption1Text())
    }
}

struct HeaderCenter: ViewModifier {
    func body(content: Content) -> some View {
        HStack() {
            content
                .font(.subheadline.weight(.semibold))
        }
    }
}

extension View {
    func headerCenter() -> some View {
        modifier(HeaderCenter())
    }
}
