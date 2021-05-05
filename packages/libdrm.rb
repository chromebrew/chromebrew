require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  @_ver = '2.4.105'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://dri.freedesktop.org/libdrm/libdrm-#{@_ver}.tar.xz"
  source_sha256 '1d1d024b7cadc63e2b59cddaca94f78864940ab440843841113fbac6afaf2a46'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.105_armv7l/libdrm-2.4.105-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.105_armv7l/libdrm-2.4.105-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.105_i686/libdrm-2.4.105-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.105_x86_64/libdrm-2.4.105-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '457114332298eceb569af56d616ad691090c916c30e4aab132787f231e2b10b1',
     armv7l: '457114332298eceb569af56d616ad691090c916c30e4aab132787f231e2b10b1',
       i686: 'e55e2df9df10d55c9f25a1c4c44adf8f400afc076742377a2717bc7062f01bd7',
     x86_64: '868460097f1ac8928b165655b8effbc265134a1205887e3003ed6ec2c0d6a678'
  })

  depends_on 'libpciaccess' # R
  depends_on 'xorg_lib' => :build
  depends_on 'eudev' => :build
  depends_on 'libxslt' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dfreedreno-kgsl=true \
      -Damdgpu=true \
      -Dradeon=true \
      -Dnouveau=true \
      -Dintel=true \
      -Dvmwgfx=true \
      -Dvc4=true \
      -Dfreedreno=true \
      -Detnaviv=true \
      -Dlibkms=true \
      -Dexynos=true \
      -Dudev=true \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
