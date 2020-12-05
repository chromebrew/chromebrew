require 'package'

class Glib_networking < Package
  description 'Network extensions for GLib'
  homepage 'https://github.com/GNOME/glib-networking'
  version '2.66.0'
  compatibility 'all'
  source_url 'https://github.com/GNOME/glib-networking/archive/2.66.0.tar.gz'
  source_sha256 '186a670c00525d62aa160bc3e492d9efd2f59c540c50477982eb732ed62ee96c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib_networking-2.66.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib_networking-2.66.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib_networking-2.66.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib_networking-2.66.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ec999a6e4353ea7d38d018e29f6e3afb66203d8336135edcd773028715e0955',
     armv7l: '5ec999a6e4353ea7d38d018e29f6e3afb66203d8336135edcd773028715e0955',
       i686: '9336de8df82c434274c2b7ccdb206dc4bd3603ec1e9e8f97b85071bf97524131',
     x86_64: 'fd74a47da0dce066856b4105673187db2e411d032e59ea8a1f3df646209ccb32',
  })

  depends_on 'libproxy'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'meson' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} -Dstatic_modules=true builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
