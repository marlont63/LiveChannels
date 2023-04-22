//
//  AsyncImage.swift
//  LiveChannels
//
//  Created by Marlon Tavarez Parra on 22/4/23.
//

import Foundation
import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

/**
 * The purpose of the [AsyncImage] view is to display an image provided its URL.
 * It depends on [ImageLoader] that fetches an image from the network and emits image updates via a Combine publisher.
 */
struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image

    init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
            } else {
                placeholder
            }
        }
    }
}

struct ImageFromUrl: View {
    var url: URL
    var placeHolder: Image = Image("ic_notimage")/// If nill looks for background color
    var aspectRatio: ContentMode = .fill
    var isGeometryFrameUsed: Bool = false
    var isScaledToFill: Bool = false
    var withTransition: Bool = true
    var maxWidth: CGFloat?

    @ViewBuilder
    var body: some View {
        GeometryReader { frame in
            AsyncImage(url: url, placeholder: {
                placeHolder
                    .resizable()
                    .scaledToFill()
                    .frame(width: frame.size.width, height: frame.size.height)
            }, image: {
                Image(uiImage: $0)
                    .resizable()
            })
            .id(url)
            .if(isScaledToFill, transform: { image in
                image.scaledToFill()
            })
            .if(withTransition, transform: { image in
                image.transition(.fade(duration: 0.1))
            })
            .aspectRatio(contentMode: aspectRatio)
            .if(isGeometryFrameUsed, transform: { image in
                image.frame(width: frame.size.width, height: frame.size.height)
            })
            .if(maxWidth != nil, transform: { image in
                image.frame(maxWidth: maxWidth!)
            })
            .clipped()
        }
    }
}
