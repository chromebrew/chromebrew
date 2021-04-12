require 'package'

class Pangomm_2_48 < Package
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  @_ver = '2.48.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/pangomm/-/archive/#{@_ver}/pangomm-#{@_ver}.tar.bz2"
  source_sha256 '744ba9156ca642f6cbbe049f965c741319c9f71629b153b6888dbca239fa770b'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm_2_48-2.48.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm_2_48-2.48.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm_2_48-2.48.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm_2_48-2.48.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '720f11d212bf078bbac66bf6751ebc24e5040fa2d7d5908a637b3d6c83a8d28d',
     armv7l: '720f11d212bf078bbac66bf6751ebc24e5040fa2d7d5908a637b3d6c83a8d28d',
       i686: '8aab1853da7476426c766f453535056e9d57c8bac1b9eb575bbb3b4f3ed37ceb',
     x86_64: 'e6093416abe7406abfe366d07850591d2da70bc0c90591ce00b438b5f9598a32'
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
