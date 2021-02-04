# frozen_string_literal: true

require 'package'

class Gjs < Package
  description 'Javascript Bindings for GNOME'
  version '1.67.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gjs/1.67/gjs-1.67.1.tar.xz'
  source_sha256 '28af0b28efd9d11009b007401e9f96dbff0d988799c15edc812b6d57dd3edbd9'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '77e917bd0b8f07b3b573682789419e55c03fdbbf0f26ad5ab0714aba6eed7a28',
     armv7l: '77e917bd0b8f07b3b573682789419e55c03fdbbf0f26ad5ab0714aba6eed7a28',
       i686: 'ea54f17dad4f34e4cf5dc1ba4e2e4c2d2c48c6ac310dc38255cd4abc6dbf2644',
     x86_64: '5e75223729786f2dba2f74148db6d2225965e0029fd814d5222134f82607bae3'
  })

  depends_on 'cairo'
  depends_on 'gobject_introspection'
  depends_on 'js78'
  depends_on 'dconf'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'dbus' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dinstalled_tests=false \
    -Dskip_dbus_tests=true \
    -Dreadline=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
