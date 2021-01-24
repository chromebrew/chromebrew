require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.102'
  compatibility 'all'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.102.tar.xz'
  source_sha256 '8bcbf9336c28e393d76c1f16d7e79e394a7fce8a2e929d52d3ad7ad8525ba05b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.102-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.102-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.102-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.102-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd02b90125434ef5bd9f1bd86514929edc09a08089792cafdfaf2b678d3dc2ed5',
     armv7l: 'd02b90125434ef5bd9f1bd86514929edc09a08089792cafdfaf2b678d3dc2ed5',
       i686: '9d0cd25cdc0a2193ef30b1549d6d2979c94dd941a95c7a07f5ed84413da89cbe',
     x86_64: '5f67dd18f9bf9653addbf2989b9179fa9c3d55fe855a3b1681243239a32987c4',
  })

  depends_on 'libpciaccess'
  depends_on 'xorg_lib'
  depends_on 'eudev'
  depends_on 'libxslt'

  def self.build
    system "meson", "setup",
           "-Dfreedreno-kgsl=true",
           "-Damdgpu=true",
           "-Dradeon=true",
           "-Dnouveau=true",
           "-Dintel=true",
           "-Dvmwgfx=true",
           "-Dvc4=true",
           "-Dfreedreno=true",
           "-Detnaviv=true",
           "-Dlibkms=true",
           "-Dexynos=true",
           "-Dudev=true",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--prefix=#{CREW_PREFIX}",
           "builddir/"

    system "ninja -C builddir/"
  end

  def self.install
    system "cd builddir && DESTDIR=#{CREW_DEST_DIR} meson install"
  end
end
