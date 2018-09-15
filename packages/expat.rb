require 'package'

class Expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.2.6'
  source_url 'https://prdownloads.sourceforge.net/project/expat/expat/2.2.6/expat-2.2.6.tar.bz2'
  source_sha256 '17b43c2716d521369f82fc2dc70f359860e90fa440bea65b3b85f0b246ea81f2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '419210356fe54f15bf2e8c51e436ccffe2e240b6cfb44a12b9c999561611e418',
     armv7l: '419210356fe54f15bf2e8c51e436ccffe2e240b6cfb44a12b9c999561611e418',
       i686: 'bb902406002d8cee6c803dd18a567658d02e60c1fbb0dfa94a5d31a076fe2348',
     x86_64: '9e37b6a5b6ec892b3da12fbd984685e375b3641ed53074da98bd43a7faf75161',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static',
           '--with-pic'
    system 'make'
  end

  def self.check
    system "make", "check"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
