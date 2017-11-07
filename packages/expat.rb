require 'package'

class Expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.2.2'
  source_url 'https://downloads.sourceforge.net/project/expat/expat/2.2.2/expat-2.2.2.tar.bz2'
  source_sha256 '4376911fcf81a23ebd821bbabc26fd933f3ac74833f74924342c29aad2c86046'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ada9387de1b33c8178ceb1bfb354f5567e2aaa3f89141e839fa65c2e27cc0160',
     armv7l: 'ada9387de1b33c8178ceb1bfb354f5567e2aaa3f89141e839fa65c2e27cc0160',
       i686: 'ba40cbbe4d2ed9266ee47a04782f612e0a355e1b16084ebf2589e5f01adce3d4',
     x86_64: '87a7ece1bfee774c109f61c6c82979d72576624318f943af536098917489e097',
  })

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
