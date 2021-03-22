require 'package'

class Glibmm_2_68 < Package
  description 'C++ bindings for GLib'
  homepage 'https://www.gtkmm.org'
  @_ver = '2.68.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://ftp.gnome.org/pub/GNOME/sources/glibmm/#{@_ver_prelastdot}/glibmm-#{@_ver}.tar.xz"
  source_sha256 'c1f38573191dceed85a05600888cf4cf4695941f339715bd67d51c2416f4f375'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm_2_68-2.68.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm_2_68-2.68.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm_2_68-2.68.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm_2_68-2.68.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ac6be3527b1b77d5a31c0f9af2a382c8793805541c30d0c1050fde4da99d110a',
     armv7l: 'ac6be3527b1b77d5a31c0f9af2a382c8793805541c30d0c1050fde4da99d110a',
       i686: 'ffe1dae2a2d674a62d07c00798b329203680442424623c7dc3ed5efa2747f3f0',
     x86_64: '71c115fd638c96c9244602f149709876e83f31f245a4ec8b843fa054d4dbcac5'
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
