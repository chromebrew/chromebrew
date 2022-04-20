require 'package'

class Libxmu < Package
  description 'X.org X interface library for miscellaneous utilities not part of the Xlib standard'
  homepage 'https://www.x.org'
  version '1.1.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXmu-1.1.3.tar.gz'
  source_sha256 '5bd9d4ed1ceaac9ea023d86bf1c1632cd3b172dce4a193a72a94e1d9df87a62e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmu/1.1.3_armv7l/libxmu-1.1.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmu/1.1.3_armv7l/libxmu-1.1.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmu/1.1.3_i686/libxmu-1.1.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxmu/1.1.3_x86_64/libxmu-1.1.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '13b7e9be2a0605f57496e57a4dbf928ed6ea1cfb07e682a7b47348572bda714c',
     armv7l: '13b7e9be2a0605f57496e57a4dbf928ed6ea1cfb07e682a7b47348572bda714c',
       i686: 'a28796da18c49538711e5f69ea5fdd0c9a040c15acb66b5e5199ac64d273fdc9',
     x86_64: 'c69a0f76d5622da115b48cb108c46e3bd2d8c862c6582b77842b022f62defc40'
  })

  depends_on 'libxt'
  depends_on 'libxext'
  depends_on 'util_macros'
  depends_on 'libx11'
  patchelf

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
