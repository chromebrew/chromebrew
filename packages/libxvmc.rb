require 'package'

class Libxvmc < Package
  description 'X.org X-Video Motion Compensation Library'
  homepage 'https://www.x.org/wiki/'
  version '1.0.14'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://gitlab.freedesktop.org/xorg/lib/libxvmc/-/archive/libXvMC-#{version}/libxvmc-libXvMC-#{version}.tar.gz"
  source_sha256 '08d9a9f8ebdd353ef0d831641a8959c01824db618ef833453f6f0707488ae300'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3cab83d90a45a4342a6c222a5cada082ebfb8397f4f4be4d3115cd3aa264eaa',
     armv7l: 'f3cab83d90a45a4342a6c222a5cada082ebfb8397f4f4be4d3115cd3aa264eaa',
     x86_64: 'af01cdf69aa30b98e0ad29bee967f264a88a652438d614ed8a59637088bd52c0'
  })

  depends_on 'glibc' # R
  depends_on 'libx11'
  depends_on 'libxext' # R
  depends_on 'libxv'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
            builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
