require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'ftp://ftp.astron.com/pub/file'
  version '5.34'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.34.tar.gz'
  source_sha256 'f15a50dbbfa83fec0bd1161e8e191b092ec832720e30cd14536e044ac623b20a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.34-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.34-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.34-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.34-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4468657f5add5e6f6b3d92eb48f9e3b15daa27700ba6f53465497dea1d2d6a2a',
     armv7l: '4468657f5add5e6f6b3d92eb48f9e3b15daa27700ba6f53465497dea1d2d6a2a',
       i686: '6422e05633b289b5e7a25f9c1d553f98a95cd71bdf809c81bbd8a2e485a11d55',
     x86_64: '0662f414ad1da35ea0664cdf79d85f4b758c2d3a4442bd5c11620afb5647d4d1',
  })

  def self.build
    # The filefix command changes the full path of the file command in configure scripts.
    # Execute this command from your source code root directory.
    system "echo '#!/bin/bash' > filefix"
    system "echo 'for f in $(find . -name configure); do sed -i \'s,/usr/bin/file,#{CREW_PREFIX}/bin/file,g\' $f; done' >> filefix"
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-libseccomp"
    system "make"
  end

  def self.check
    system "make", "check"
  end
  
  def self.install
    system "install -Dm755 filefix #{CREW_DEST_PREFIX}/bin/filefix"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end
end
