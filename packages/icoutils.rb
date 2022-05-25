require 'package'

class Icoutils < Package
  description 'The icoutils are a set of command-line programs for extracting and converting images in Microsoft Windows(R) icon and cursor files.'
  homepage 'https://www.nongnu.org/icoutils/'
  version '0.32.3'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://savannah.nongnu.org/download/icoutils/icoutils-0.32.3.tar.bz2'
  source_sha256 '17abe02d043a253b68b47e3af69c9fc755b895db68fdc8811786125df564c6e0'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icoutils/0.32.3_armv7l/icoutils-0.32.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icoutils/0.32.3_armv7l/icoutils-0.32.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icoutils/0.32.3_i686/icoutils-0.32.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/icoutils/0.32.3_x86_64/icoutils-0.32.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e0d733295cf7fadcd7ebe9cf517f229785e146c52b1c61edc53feaf46f586d2d',
     armv7l: 'e0d733295cf7fadcd7ebe9cf517f229785e146c52b1c61edc53feaf46f586d2d',
       i686: '4f6d7f02a499f5fb478dcbd6f5ea7cb5c8223c253525169cfa7b8c4f985cb2fa',
     x86_64: '7df6ada3ac2730191aa2e34c143efff61f0db5a4c8faebbc8447c4df7ab1d00f'
  })

  depends_on 'libpng'
  depends_on 'perl'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
