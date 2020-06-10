require 'package'

class Libmad < Package
  description 'MAD is a high-quality MPEG audio decoder.'
  homepage 'https://www.underbit.com/products/mad/'
  version '0.15.1b'
  compatibility 'all'
  source_url 'ftp://ftp.mars.org/pub/mpeg/libmad-0.15.1b.tar.gz'
  source_sha256 'bbfac3ed6bfbc2823d3775ebb931087371e142bb0e9bb1bee51a76a6e0078690'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmad-0.15.1b-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmad-0.15.1b-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmad-0.15.1b-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmad-0.15.1b-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd4694b736be240c5f8a979fa6e4bdab8620a53178b156ebde91eba46897512f4',
     armv7l: 'd4694b736be240c5f8a979fa6e4bdab8620a53178b156ebde91eba46897512f4',
       i686: 'fc86b5ff463282571c274db18c96891b479e23fa959dcdee881f7a7c8ff4a198',
     x86_64: '502ea142d67c8d4d3cce64c7945c07c529cbda4e4efe0dd3aa770c29b168bd46',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "sed -i 's,-fforce-mem ,,' Makefile"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
