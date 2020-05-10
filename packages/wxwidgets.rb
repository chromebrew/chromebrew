require 'package'

class Wxwidgets < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.0.4'
  compatibility 'all'
  source_url 'https://github.com/wxWidgets/wxWidgets/releases/download/v3.0.4/wxWidgets-3.0.4.tar.bz2'
  source_sha256 '96157f988d261b7368e5340afa1a0cad943768f35929c22841f62c25b17bf7f0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b91d482d148f8132c67e40e8b3c33d7d2e29744cade8f39b2797c3a8bef52081',
     armv7l: 'b91d482d148f8132c67e40e8b3c33d7d2e29744cade8f39b2797c3a8bef52081',
       i686: 'aba2a4d219b45436427b01d8e6f1b245971966b946e906668595710a63b74f01',
     x86_64: '56a888743624497531f4896cc9c3de3feb041c2c963f2ce08c770c5745e9c983',
  })

  depends_on 'gst_plugins_base'
  depends_on 'libnotify'
  depends_on 'libsdl'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'mesa'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
