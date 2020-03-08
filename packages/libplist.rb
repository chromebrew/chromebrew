require 'package'

class Libplist < Package
  description 'A library to handle Apple Property List format'
  homepage 'http://www.libimobiledevice.org/'
  version '2.1.0'
  source_url 'https://github.com/libimobiledevice/libplist/archive/2.1.0.tar.gz'
  source_sha256 '4b33f9af3f9208d54a3c3e1a8c149932513f451c98d1dd696fe42c06e30b7f03'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib'

  def self.build
    system './autogen.sh CC=gcc CXX=g++'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
