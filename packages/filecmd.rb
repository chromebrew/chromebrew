require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'ftp://ftp.astron.com/pub/file'
  version '5.37'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.37.tar.gz'
  source_sha256 'e9c13967f7dd339a3c241b7710ba093560b9a33013491318e88e6b8b57bae07f'

  binary_url ({
  })
  binary_sha256 ({
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
