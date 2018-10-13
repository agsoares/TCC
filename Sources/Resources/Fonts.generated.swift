// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
  internal typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  internal typealias Font = UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum OpenSans {
    internal static let bold = FontConvertible(name: "OpenSans-Bold", family: "Open Sans", path: "OpenSans-Bold.ttf")
    internal static let extraBold = FontConvertible(name: "OpenSans-ExtraBold", family: "Open Sans", path: "OpenSans-ExtraBold.ttf")
    internal static let light = FontConvertible(name: "OpenSans-Light", family: "Open Sans", path: "OpenSans-Light.ttf")
    internal static let regular = FontConvertible(name: "OpenSans-Regular", family: "Open Sans", path: "OpenSans-Regular.ttf")
    internal static let semiBold = FontConvertible(name: "OpenSans-SemiBold", family: "Open Sans", path: "OpenSans-SemiBold.ttf")
    internal static let all: [FontConvertible] = [bold, extraBold, light, regular, semiBold]
  }
  internal static let allCustomFonts: [FontConvertible] = [OpenSans.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  internal func font(size: CGFloat) -> Font! {
    return Font(font: self, size: size)
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    let bundle = Bundle(for: BundleToken.self)
    return bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension Font {
  convenience init!(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

private final class BundleToken {}