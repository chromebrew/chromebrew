require 'package'

class Libxvmc < Package
  description 'X.org X-Video Motion Compensation Library'
  homepage 'https://www.x.org/wiki/'
  version '1.0.15'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://gitlab.freedesktop.org/xorg/lib/libxvmc/-/archive/libXvMC-#{version}/libxvmc-libXvMC-#{version}.tar.gz"
  source_sha256 'd75333e43ec7d04052e5851b461c7a14a43b28fba2434378d35dc8c7fea69704'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7541a7a6c59cee021f31cb970481b21f3cc742eb5b69735a84451fc740d99ce',
     armv7l: 'c7541a7a6c59cee021f31cb970481b21f3cc742eb5b69735a84451fc740d99ce',
     x86_64: '4afd9912c25216a5dbc05826284193aa88f96795210c6f06847976a7ae437231'
  })

  depends_on 'glibc' # R
  depends_on 'libx11'
  depends_on 'libxext' # R
  depends_on 'libxv'

  conflicts_ok # xorg_proto: /usr/local/include/X11/extensions/vldXvMC.h

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
