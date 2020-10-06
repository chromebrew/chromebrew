require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.102'
  compatibility 'all'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.102.tar.xz'
  source_sha256 '8bcbf9336c28e393d76c1f16d7e79e394a7fce8a2e929d52d3ad7ad8525ba05b'


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
