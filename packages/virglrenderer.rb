require 'package'

class Virglrenderer < Package
  description 'Virtual OpenGL renderer for QEMU virtual machines'
  homepage 'https://virgil3d.github.io/'
  @_ver = '0.8.2'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/virgl/virglrenderer/-/archive/virglrenderer-#{@_ver}/virglrenderer-virglrenderer-#{@_ver}.tar.gz"
  source_sha256 '9fa93095cd9a3e5b13c740e5e3b656a989356732bdaf3e22acb7c38a1f1f4411'

  depends_on 'mesa'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end