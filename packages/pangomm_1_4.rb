require 'package'

class Pangomm_1_4 < Package
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  @_ver = '2.46.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/pangomm/-/archive/#{@_ver}/pangomm-#{@_ver}.tar.bz2"
  source_sha256 '9582d961e71d5134aeadc73de63baa27424f76ab6d04280d6b6c9177c4b653a9'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/pangomm_1_4-2.46.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/pangomm_1_4-2.46.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/pangomm_1_4-2.46.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/pangomm_1_4-2.46.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '36bd8512279d1f7fe1e33d2a69ec7488404bedd879bd021485ffee036dbc376e',
     armv7l: '36bd8512279d1f7fe1e33d2a69ec7488404bedd879bd021485ffee036dbc376e',
       i686: '28c625ea2df998071dfd1bba523b01989b8e8d8c1dbbdb381d2ca4ac298cbdf9',
     x86_64: 'c29af342514e22182c03946216f4faa04975bcff142c859ba9f5f5b19b8cfcf0'
  })

  depends_on 'glibmm'
  depends_on 'cairomm'
  depends_on 'pango'
  depends_on 'graphite'
  depends_on 'mm_common'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dmaintainer-mode=true \
    -Dbuild-documentation=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
