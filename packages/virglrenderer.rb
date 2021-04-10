require 'package'

class Virglrenderer < Package
  description 'Virtual OpenGL renderer for QEMU virtual machines'
  homepage 'https://virgil3d.github.io/'
  @_ver = '0.8.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/virgl/virglrenderer/-/archive/virglrenderer-#{@_ver}/virglrenderer-virglrenderer-#{@_ver}.tar.gz"
  source_sha256 '9fa93095cd9a3e5b13c740e5e3b656a989356732bdaf3e22acb7c38a1f1f4411'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/virglrenderer-0.8.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/virglrenderer-0.8.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/virglrenderer-0.8.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/virglrenderer-0.8.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f46f083b032dec6c8e9c2627e94315c45f535ec8288d3b8c323af763d49b9d1',
     armv7l: '8f46f083b032dec6c8e9c2627e94315c45f535ec8288d3b8c323af763d49b9d1',
       i686: '7e5c6d1f4b0353e6c0e58ac61f0f52471df71b42230cd3510c9045c94dd04b54',
     x86_64: 'f14a81a9209bbd1cf6b3127512dc489e6971db28b84f8a56bb14e324561c5094',
  })

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
