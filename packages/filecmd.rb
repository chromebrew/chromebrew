require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'ftp://ftp.astron.com/pub/file'
  version '5.35'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.35.tar.gz'
  source_sha256 '30c45e817440779be7aac523a905b123cba2a6ed0bf4f5439e1e99ba940b5546'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.35-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.35-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.35-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.35-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1b18c244b4f38a931cb3647782325e34b1345d7ecbb4aca03294cc7a9a066052',
     armv7l: '1b18c244b4f38a931cb3647782325e34b1345d7ecbb4aca03294cc7a9a066052',
       i686: '39efe5224d49ff887a7aac593b0532e7fb8e4618418342d438383030a69eee68',
     x86_64: '277f3393963a2c5c897f02c46832d15bea5a3b994e422f8a8278e81d9997115c',
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
