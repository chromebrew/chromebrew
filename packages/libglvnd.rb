require 'package'

class Libglvnd < Package
  description 'The GL Vendor-Neutral Dispatch library'
  homepage 'https://gitlab.freedesktop.org/glvnd/libglvnd'
  version '1.6.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/glvnd/libglvnd.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.6.0_armv7l/libglvnd-1.6.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.6.0_armv7l/libglvnd-1.6.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.6.0_i686/libglvnd-1.6.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.6.0_x86_64/libglvnd-1.6.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '52555ba2aab442a4d3b336e164ad35f64ec8ea09db9340751729363e6e5d51ba',
     armv7l: '52555ba2aab442a4d3b336e164ad35f64ec8ea09db9340751729363e6e5d51ba',
       i686: '14fbc324b9e8cd2d168af66add8f40e6b55ac7068a30df0fcefa66c5ebe3f1a3',
     x86_64: 'e076f11dae10b4fd8c21076b33a85be40bc585cc7612f3da29802e6b09e58ba5'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glproto' => :build
  depends_on 'libx11' # R
  depends_on 'libxext' => :build
  depends_on 'python3' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
