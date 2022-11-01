require 'package'

class Jp2a < Package
  description 'jp2a is a simple JPEG/PNG to ASCII converter.'
  homepage 'https://github.com/Talinx/jp2a'
  version '1.1.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/Talinx/jp2a/releases/download/v1.1.1/jp2a-1.1.1.tar.bz2'
  source_sha256 '3b91f26f79eca4e963b1b1ae2473722a706bf642218f20bfe4ade5333aebb106'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jp2a/1.1.1_armv7l/jp2a-1.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jp2a/1.1.1_armv7l/jp2a-1.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jp2a/1.1.1_i686/jp2a-1.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jp2a/1.1.1_x86_64/jp2a-1.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5904d25a8d64927b4daf67d3c8982eeaf748b5e7f4c7b5aa547cad30a9394182',
     armv7l: '5904d25a8d64927b4daf67d3c8982eeaf748b5e7f4c7b5aa547cad30a9394182',
       i686: 'd036f8479acad0db26fe5b315b0d4f3266b6ab0ed1eb28972bf2c85fe38f8722',
     x86_64: '261e542c36ee596b0682e4a949f4a5f8be73d65b610c8b477a08c878e6ce2c29'
  })

  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'termcap'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-curl"
    system 'make'
  end

  def self.check
    system 'make check || true'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
