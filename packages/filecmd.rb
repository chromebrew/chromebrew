require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'ftp://ftp.astron.com/pub/file'
  version '5.37'
  compatibility 'all'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.37.tar.gz'
  source_sha256 'e9c13967f7dd339a3c241b7710ba093560b9a33013491318e88e6b8b57bae07f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.37-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.37-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.37-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.37-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '26c0e8ccc7d7d64e422d7f4deae71550646f16f3228cdd9dcc926c5dbea5eb8e',
     armv7l: '26c0e8ccc7d7d64e422d7f4deae71550646f16f3228cdd9dcc926c5dbea5eb8e',
       i686: '495d8a50dabff55cf4bf288aa9e8a4ab3ceadf18de20aacd96a79d0bb42219ae',
     x86_64: '5df86414a61540346de2712eb7eb553a5562d17f4c3d325f4a42aa8a2bf43829',
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
