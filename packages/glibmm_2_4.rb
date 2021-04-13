require 'package'

class Glibmm_2_4 < Package
  description 'C++ bindings for GLib'
  homepage 'https://www.gtkmm.org'
  @_ver = '2.66.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://ftp.gnome.org/pub/GNOME/sources/glibmm/#{@_ver_prelastdot}/glibmm-#{@_ver}.tar.xz"
  source_sha256 '9e1db7d43d2e2d4dfa2771354e21a69a6beec7c446b711619cf8c779e13a581e'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/glibmm_2_4-2.66.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/glibmm_2_4-2.66.0-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/glibmm_2_4-2.66.0-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/glibmm_2_4-2.66.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c6c0459c412f133ac1d581a4db4a8d4c6ae69227755f191822d59272502d0455',
     armv7l: 'c6c0459c412f133ac1d581a4db4a8d4c6ae69227755f191822d59272502d0455',
       i686: '8a3dade9644c0be55d3fb3ddf21f470466562020e5313e3f97557e2243db42fe',
     x86_64: 'cd9b610bceadc050a09099d80815cfe4c092cb5cb8b67d0bc73c5d71e2f5f63c'
  })

  depends_on 'libsigcplusplus'
  depends_on 'mm_common' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
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
