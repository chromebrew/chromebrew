require 'package'

class Libglvnd < Package
  description 'The GL Vendor-Neutral Dispatch library'
  homepage 'https://gitlab.freedesktop.org/glvnd/libglvnd'
  version '1.6.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/glvnd/libglvnd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52555ba2aab442a4d3b336e164ad35f64ec8ea09db9340751729363e6e5d51ba',
     armv7l: '52555ba2aab442a4d3b336e164ad35f64ec8ea09db9340751729363e6e5d51ba',
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
