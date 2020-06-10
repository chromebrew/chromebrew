require 'package'

class Tcpwrappers < Package
  description 'The tcpwrappers package provides daemon wrapper programs that report the name of the client requesting network services and the requested service.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/6.1/basicnet/tcpwrappers.html'
  version '7.6'
  compatibility 'all'
  source_url 'ftp://ftp.porcupine.org/pub/security/tcp_wrappers_7.6.tar.gz'
  source_sha256 '9543d7adedf78a6de0b221ccbbd1952e08b5138717f4ade814039bb489a4315d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcpwrappers-7.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcpwrappers-7.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcpwrappers-7.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcpwrappers-7.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '69e189227279eba546a162c314b40217ce272a30d6ae9ae5a7ce4715fa8fde16',
     armv7l: '69e189227279eba546a162c314b40217ce272a30d6ae9ae5a7ce4715fa8fde16',
       i686: 'c6b42d5afd6438a2b351d94dc16e0cc2af66610306eea1e13ba62420b973915c',
     x86_64: '6bebba4d4bb3498ecad66271325ab1060c6d019bd0b7d57e4c80d7163b4f9d04',
  })

  def self.patch
    system 'wget http://www.linuxfromscratch.org/blfs/downloads/6.1/tcp_wrappers-7.6-shared_lib_plus_plus-1.patch'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('tcp_wrappers-7.6-shared_lib_plus_plus-1.patch') ) == 'c88af3bc83ad032e58be47cf53a1941c281b7fe4690d2c23ce2923e26146d42a'
    system 'patch -Np1 -i ./tcp_wrappers-7.6-shared_lib_plus_plus-1.patch'
    system 'sed -i -e "s,^extern char \*malloc();,/* & */," scaffold.c'
    system "sed -i 's,/usr/lib,#{CREW_LIB_PREFIX},' Makefile"
    system "sed -i 's,/usr/sbin,#{CREW_PREFIX}/sbin,' Makefile"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,' Makefile"
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,' Makefile"
    system "sed -i 's,-o root,,' Makefile"
    system "sed -i 's,-g root,,' Makefile"
    system "sed -i 's,-m 0755,-Dm755,' Makefile"
    system "sed -i 's,-m 0644,-Dm644,' Makefile"
  end

  def self.build
    system "make REAL_DAEMON_DIR=#{CREW_PREFIX}/sbin linux"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/sbin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man3"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man5"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man8"
    system "make", "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
