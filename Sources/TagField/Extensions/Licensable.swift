// Copyright (c) 2024-2026 Jason Morley
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

import Foundation

import Licensable

fileprivate let autoGrowingTextFieldLicense = License(id: "https://christiantietze.de/posts/2020/02/auto-growing-nstextfield/",
                                                      name: "AutoGrowingTextField",
                                                      author: "Christian Tietze",
                                                      text: String(contentsOfResource: "autogrowingtextfield-license"),
                                                      attributes: [
                                                        .url(URL(string: "https://christiantietze.de/posts/2020/02/auto-growing-nstextfield/")!,
                                                             title: "Website"),
                                                      ])

fileprivate let hashRainbowLicense = License(id: "https://github.com/saramah/HashRainbow",
                                               name: "HashRainbow",
                                               author: "Sarah Barbour",
                                               text: String(contentsOfResource: "hashrainbow-license"),
                                               attributes: [
                                                .url(URL(string: "https://github.com/saramah/HashRainbow")!,
                                                     title: "GitHub"),
                                               ])

fileprivate let tagFieldLicense = License(id: "https://github.com/jbmorley/TagField",
                                          name: "TagField",
                                          author: "Jason Morley",
                                          text: String(contentsOfResource: "tagfield-license"),
                                          attributes: [
                                            .url(URL(string: "https://github.com/jbmorley/TagField")!, title: "GitHub"),
                                          ],
                                          licenses: [
                                            .licensable,
                                            autoGrowingTextFieldLicense,
                                            hashRainbowLicense,
                                          ])

extension Licensable where Self == License {

    public static var tagField: License { tagFieldLicense }

}
