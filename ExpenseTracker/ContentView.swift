//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/11.
//

import SwiftUI

enum SoundOption {
    case none
    case alertsOnly
    case all
}

struct SoundOptionPicker: View {
    @Binding var option: SoundOption
    @State private var isExpanded = false

    var body: some View {
        HStack(spacing: 0) {
            button(for: .none, label: "volume.slash")
                .foregroundColor(.red)
            button(for: .alertsOnly, label: "speaker.badge.exclamationmark")
                .foregroundColor(.white)
            button(for: .all, label: "volume.2")
                .foregroundColor(.white)
        }
        .buttonStyle(.plain)
        .background {
            Capsule(style: .continuous).foregroundColor(.black)
        }
    }

    @ViewBuilder
    private func button(for option: SoundOption, label: String) -> some View {
        Button {
            withAnimation(.easeOut) {
                if isExpanded {
                    self.option = option
                    isExpanded = false
                } else {
                    isExpanded = true
                }
            }
        } label: {
            Image(systemName: label)
                .fontWeight(.bold)
                .padding(10)
        }
        .frame(width: shouldShow(option) ? buttonSize : 0, height: buttonSize)
        .opacity(shouldShow(option) ? 1 : 0)
        .clipped()
    }

    private var buttonSize: CGFloat { 44 }

    private func shouldShow(_ option: SoundOption) -> Bool {
        return isExpanded || option == self.option
    }
}

struct ContentView: View {
    @State var option = SoundOption.none

    var body: some View {
        ZStack {
            Color(hue: 0.6, saturation: 1, brightness: 0.2)
            SoundOptionPicker(option: $option)
                .shadow(color: .gray, radius: 3)
                .frame(width: 200, alignment: .trailing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
