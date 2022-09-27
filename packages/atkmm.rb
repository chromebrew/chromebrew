require 'package'

class Atkmm < Package
  description 'Atkmm is the official C++ interface for the ATK accessibility toolkit library.'
  homepage 'https://www.gtkmm.org/'
  version '2.28.3'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/atkmm/2.28/atkmm-2.28.3.tar.xz'
  source_sha256 '7c2088b486a909be8da2b18304e56c5f90884d1343c8da7367ea5cd3258b9969'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm/2.28.3_armv7l/atkmm-2.28.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm/2.28.3_armv7l/atkmm-2.28.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm/2.28.3_i686/atkmm-2.28.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm/2.28.3_x86_64/atkmm-2.28.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f0e1d2d64a82204014132c2218ca8909d940d89929eb538ea18d530433d27883',
     armv7l: 'f0e1d2d64a82204014132c2218ca8909d940d89929eb538ea18d530433d27883',
       i686: 'aac296de2f47c8fd9dc3cd1bfcf3e1d059ff5665549802e603664862d54d8f77',
     x86_64: 'ceee59dcefe0aa9fe7eac7a6af0b4057d9301661aceb87a62741e6a097b11b32'
  })

  depends_on 'atk'
  depends_on 'glibmm'
  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dbuild-documentation=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
