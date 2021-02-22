require 'package'

class Libmd < Package
  description 'This library provides message digest functions found on BSD systems.'
  homepage 'https://www.hadrons.org/software/libmd/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://archive.hadrons.org/software/libmd/libmd-1.0.3.tar.xz'
  source_sha256 '5a02097f95cc250a3f1001865e4dbba5f1d15554120f95693c0541923c52af4a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmd-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmd-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmd-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmd-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0a4123d5bdda79101bbf2e9d2dd18a94c22bf3453dadf1f7dbe15b093d1a2194',
     armv7l: '0a4123d5bdda79101bbf2e9d2dd18a94c22bf3453dadf1f7dbe15b093d1a2194',
       i686: 'b551925cc635acc039c5b434d95fbdfb0a6b054a4a3f5cc978cda47cb843860e',
     x86_64: 'cd0bffd8db390ac90830dc435bef352eb38156eb015130556f6fcaa841b119fb',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
