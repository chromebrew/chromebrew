require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.7.2'
  source_url 'http://www.basic-converter.org/stable/bacon-3.7.2.tar.gz'
  source_sha256 '20ac0b144f1234f3a0f5566783171376a77d2f2117352aab550ec9d9df4f7246'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.7.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.7.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.7.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.7.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aeb9ee1c14b457b613dc5a0df16267597182dc7b308c91d880498232fcc53678',
     armv7l: 'aeb9ee1c14b457b613dc5a0df16267597182dc7b308c91d880498232fcc53678',
       i686: '01a4389f2cd33f1a6dcf3525547a076b31d86441da6f2a60f301b21a52491748',
     x86_64: '6e0497b676d721ab9183158be201b0fa49cc31076f5acb4395a837782f24fdd4',
  })

  def self.build
    system 'sed -i "s,/usr/share,\$\(DATADIR\)," Makefile.in'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-gui'
    system 'make', '-j1' # parallel builds don't work with bacon
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
