require 'package'

class Pangomm < Package
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  @_ver = '2.42.2'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/GNOME/pangomm/archive/#{@_ver}.tar.gz"
  source_sha256 '51f0a8a60a80630ea008ca42b0c64fa1712c50ac2c56497ee0f59d740c19692f'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.42.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.42.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.42.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.42.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '8b7cf6b5aa32027410cf52af25f7729b1ed7b5ef0304108128f87632a804c51c',
      armv7l: '8b7cf6b5aa32027410cf52af25f7729b1ed7b5ef0304108128f87632a804c51c',
        i686: 'f35a2334b5576ab8ea16dde6506685605e15f1c06e20d107cba8e184dae15d2f',
      x86_64: 'f3dafb0c75d0205ed574988498aa3407d422d621a226114924e4558054d5c38e',
  })

  depends_on 'glibmm'
  depends_on 'cairomm'
  depends_on 'pango'
  depends_on 'graphite'
  depends_on 'mm_common'
  
  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dmaintainer-mode=true \
    -Dbuild-documentation=false \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
