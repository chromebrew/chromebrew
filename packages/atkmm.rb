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
    aarch64: 'bdf1a9c594244ba93b4ea98b38064cc67bfc6364d8edddf5135aaf53891fcc48',
     armv7l: 'bdf1a9c594244ba93b4ea98b38064cc67bfc6364d8edddf5135aaf53891fcc48',
       i686: '411689a402104d3b0e91cc7edb4781ffa247fb2ec361bae6ab97d3c39398ff6e',
     x86_64: '86017c202ce153168975d2bac00d6777961dc9af26ded6d058e8a70537400a8e'
  })

  depends_on 'atk_spi2_core'
  depends_on 'glibmm'
  depends_on 'gcc' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
  depends_on 'libsigcplusplus' # R
  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
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
