require 'package'

class Chrpath < Package
  description 'Change or delete the rpath or runpath in ELF files'
  homepage 'https://directory.fsf.org/project/chrpath/'
  version '0.16'
  source_url 'http://ftp.debian.org/debian/pool/main/c/chrpath/chrpath_0.16.orig.tar.gz'
  source_sha256 'bb0d4c54bac2990e1bdf8132f2c9477ae752859d523e141e72b3b11a12c26e7b'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
