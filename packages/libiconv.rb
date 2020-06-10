require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.15-1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libiconv/libiconv-1.15.tar.gz'
  source_sha256 'ccf536620a45458d26ba83887a983b96827001e92a13847b45e4925cc8913178'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cfa05a46d37d49479047f205e3d4ab2a8c11f953ed91e11465a1195ff2d95d01',
     armv7l: 'cfa05a46d37d49479047f205e3d4ab2a8c11f953ed91e11465a1195ff2d95d01',
       i686: 'b080cd1e667dd9efba1a4392c7c177f5b8292f1b6fc29e862634b7ad41d29ab5',
     x86_64: '7ac97b03fff5d1befecb26ac471daa239c2c23ab1bc774a5366e6c46d1bb9ad3',
  })

  def self.build
    system './configure',
           '--enable-shared',
           '--enable-static',
           '--enable-relocatable',
           "--prefix=#{CREW_PREFIX}",
           '--enable-extra-encodings',
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
