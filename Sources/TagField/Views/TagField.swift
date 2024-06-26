// Copyright (c) 2024 Jason Morley
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Combine
import SwiftUI

public struct TagField: View {

#if os(iOS)
    enum SheetType: Identifiable {

        public var id: Self {
            return self
        }

        case addTag
    }
#endif

    let prompt: String

    @Binding var tokens: [String]

    let suggestion: (String, [String]) -> [String]

    @StateObject var model: TokenViewModel
#if os(iOS)
    @State var sheet: SheetType?
#endif

    public init(_ prompt: String,
                tokens: Binding<[String]>,
                suggestion: @escaping (String, [String]) -> [String] = { _, _ in [] } ) {
        self.prompt = prompt
        _tokens = tokens
        self.suggestion = suggestion
        _model = StateObject(wrappedValue: TokenViewModel(tokens: tokens, suggestion: suggestion))
    }

    public var body: some View {
#if os(macOS)
        VStack {
            TagViewLayout(spacing: 4.0) {
                ForEach(model.items) { item in
                    TagView(item.text)
                }
                PickerTextField(prompt, text: $model.input) {
                    model.commit()
                } onDelete: {
                    model.deleteBackwards()
                } suggestion: { candidate in
                    return suggestion(candidate, model.items.map({ $0.text }))
                }
                .padding([.top, .bottom], 4)
            }
        }
        .onAppear {
            model.start()
        }
        .onDisappear {
            model.stop()
        }
        .onChange(of: tokens) { oldValue, newValue in
            // I find it really hard to believe that this is the idiomatic way of bidirectional binding.
            guard model.items.map({ $0.text }) != newValue else {
                return
            }
            model.items = newValue.map({ TokenViewModel.Token($0) })
        }
#else

        VStack {
            Button {
                sheet = .addTag
            } label: {
                if !tokens.isEmpty {
                    TagViewLayout(spacing: 0) {
                        ForEach(tokens.sorted(), id: \.self) { tag in
                            TagView(tag)
                        }
                    }
                } else {
                    Text("Tags")
                        .foregroundColor(.secondary)
                }
            }
        }
        .sheet(item: $sheet) { sheet in
            switch sheet {
            case .addTag:
                PhoneEditTagsView(tokenViewModel: model, tags: $tokens)
            }
        }
        .onAppear {
            model.start()
        }
        .onDisappear {
            model.stop()
        }
        .onChange(of: tokens) { oldValue, newValue in
            // I find it really hard to believe that this is the idiomatic way of bidirectional binding.
            guard model.items.map({ $0.text }) != newValue else {
                return
            }
            model.items = newValue.map({ TokenViewModel.Token($0) })
        }
#endif
    }

}
