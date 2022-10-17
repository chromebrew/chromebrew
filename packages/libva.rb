require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.17.0-65c67dd'
  version @_ver.to_s
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag '65c67dd2bd6b68afa5d86a8f9bdba6aa592e686f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.17.0-65c67dd_armv7l/libva-2.17.0-65c67dd-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.17.0-65c67dd_armv7l/libva-2.17.0-65c67dd-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.17.0-65c67dd_i686/libva-2.17.0-65c67dd-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.17.0-65c67dd_x86_64/libva-2.17.0-65c67dd-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'efd4503cce64adac7d896910a91d4810f3a9f4a7aaa5a151f1a4f7eb2bfcf809',
     armv7l: 'efd4503cce64adac7d896910a91d4810f3a9f4a7aaa5a151f1a4f7eb2bfcf809',
       i686: '451310b158efdc080fe14516c394f6345ba9ec17a3946cc391fa8096b6aeffaa',
     x86_64: '7836a07d6c3f7c951687b0e5a779536e30d3668d3fa211beb547b97bb4d3094c'
  })

  depends_on 'glibc' # R
  depends_on 'libdrm'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'mesa'
  depends_on 'wayland'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    system 'ninja -C builddir test'
  end
end
