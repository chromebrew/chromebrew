require 'package'

class Wxwidgets < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.0.5.1'
  source_url 'https://github.com/wxWidgets/wxWidgets/releases/download/v3.0.5.1/wxWidgets-3.0.5.1.tar.bz2'
  source_sha256 '440f6e73cf5afb2cbf9af10cec8da6cdd3d3998d527598a53db87099524ac807'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9bc9ccfe7c61b34880f86340c35114f2cadd9a1cee6e7941cb345c9919a2c33d',
     armv7l: '9bc9ccfe7c61b34880f86340c35114f2cadd9a1cee6e7941cb345c9919a2c33d',
       i686: 'dd1e04c0d67446afcb3c3083d4e2c77ed4d1227d08434b4e512dab4bda0c4993',
     x86_64: 'f7c04b355523fc215d30e16671ae2e3654fbf13112acc753d0797e3ef862d2b4',
  })

  depends_on 'gst_plugins_base'
  depends_on 'libnotify'
  depends_on 'libsdl'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'mesa'
  depends_on 'gtk3'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-gtk"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
