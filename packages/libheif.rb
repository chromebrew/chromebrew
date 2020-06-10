require 'package'

class Libheif < Package
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  version '1.3.2'
  compatibility 'all'
  source_url 'https://github.com/strukturag/libheif/releases/download/v1.3.2/libheif-1.3.2.tar.gz'
  source_sha256 'a9e12a693fc172baa16669f427063edd7bf07964a1cb623ee57cd056c06ee3fc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1a4a0c34e2e35401d321c4bc0cf2a358faa64faca7d10f42f83d8d8b36af31a2',
     armv7l: '1a4a0c34e2e35401d321c4bc0cf2a358faa64faca7d10f42f83d8d8b36af31a2',
       i686: '03927285a07e05f8f5f30f4d8c40b2cdc18af13cc2ae6be65ecf2a168cd89453',
     x86_64: 'd676736b107aa2245707d64afa0fe49eca476671a44dc34a6a8b013220b72ad0',
  })

  depends_on 'libde265'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libx265'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
