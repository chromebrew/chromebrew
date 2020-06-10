require 'package'

class Libdca < Package
  description 'libdca is a free library for decoding DTS Coherent Acoustics streams.'
  homepage 'https://www.videolan.org/developers/libdca.html'
  version '0.0.6'
  compatibility 'all'
  source_url 'https://get.videolan.org/libdca/0.0.6/libdca-0.0.6.tar.bz2'
  source_sha256 '98f98a9aa000a26b927c6facd15d18dcf664238adfc5db24f533c5932cdb1f40'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdca-0.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdca-0.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdca-0.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdca-0.0.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '73bdbbcd5c16feaeacaa87f1d09df7b3646ff94dde3ce229de16912bd3745910',
     armv7l: '73bdbbcd5c16feaeacaa87f1d09df7b3646ff94dde3ce229de16912bd3745910',
       i686: '5742c94ef3e054707072f9fbc4b8d1cd8d3ea158600e1736cea068bcd2b7ec91',
     x86_64: '87f86eb8cb95340ff00e13943526199983453e68b6a8033aeb4cdcdc4ac951e4',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
