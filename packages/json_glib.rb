require 'package'

class Json_glib < Package
  description 'JSON-GLib implements a full suite of JSON-related tools using GLib and GObject.'
  homepage 'https://wiki.gnome.org/Projects/JsonGlib'
  version '1.6.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/40/40.beta/sources/json-glib-1.6.2.tar.xz'
  source_sha256 'a33d66c6d038bda46b910c6c6d59c4e15db014e363dc997a0414c2e07d134f24'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/json_glib-1.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/json_glib-1.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/json_glib-1.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/json_glib-1.6.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '455dcfbda9d20fc22e4ce2ccb33ac87776acd82cdc515ce7bf26af0e0118cd89',
     armv7l: '455dcfbda9d20fc22e4ce2ccb33ac87776acd82cdc515ce7bf26af0e0118cd89',
       i686: '2df0c4c6ba784caa9d308cf25b815ca25b2ad4c8ea410f7105568aecfc5b79ef',
     x86_64: '4ce5550617d0c6a6c61317cf74deba81a0674f0b315f7741db67c3b11b36e3fb'
  })

  depends_on 'gtk_doc'
  depends_on 'glib'
  depends_on 'gobject_introspection'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  # Ticket opened at 
  # https://gitlab.gnome.org/GNOME/json-glib/-/issues/59
  # def self.check
  # system 'ninja test -C builddir'
  # end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
