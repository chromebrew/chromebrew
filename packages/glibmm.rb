require 'package'

class Glibmm < Package
  description 'C++ bindings for GLib'
  homepage 'https://www.gtkmm.org'
  version '2.68.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/glibmm/2.68/glibmm-2.68.0.tar.xz'
  source_sha256 'c1f38573191dceed85a05600888cf4cf4695941f339715bd67d51c2416f4f375'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.68.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.68.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.68.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.68.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a9e342573e021fd5ce8fe3a31a00eae0ea8bb4468986556c5333b5e404d1377a',
     armv7l: 'a9e342573e021fd5ce8fe3a31a00eae0ea8bb4468986556c5333b5e404d1377a',
       i686: '97befe025c500e4b94c7d5d82a422e9cbb1772f2f688d1531ce861dbcabbe7b6',
     x86_64: '42beab5465b595e90359d71e05ef6c90b66846b5fbe64108cf8568fe2658ca8f'
  })

  depends_on 'libsigcplusplus3'
  depends_on 'mm_common' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    --default-library=both \
    -Dbuild-documentation=false \
    -Dbuild-demos=false \
    -Dbuild-tests=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
