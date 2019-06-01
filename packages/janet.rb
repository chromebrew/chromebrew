require 'package'

class Janet < Package
  description 'a functional and imperative programming language.'
  homepage 'https://janet-lang.org/'
  version '0.6.0'
  source_url 'https://github.com/janet-lang/janet/archive/v0.6.0.tar.gz'
  source_sha256 '1226240f8ed7f5faafbff6d93e5802c7959c4b40f9212ac6f020d67ef3aa599e'

  def self.build
    system 'make',"PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'sed -i "s#-ldconfig#/usr/local/sbin/ldconfig#g" Makefile'
    system 'make', "PREFIX=#{CREW_PREFIX}",
           "LIBDIR=#{CREW_DEST_LIB_PREFIX}",
           "BINDIR=#{CREW_DEST_PREFIX}/bin/",
           "MANPATH=#{CREW_DEST_PREFIX}/share/man/man1/",
           "INCLUDEDIR=#{CREW_DEST_PREFIX}/include/",
           "JANET_PATH=#{CREW_DEST_PREFIX}/lib/janet",
           "PKG_CONFIG_PATH=#{CREW_DEST_LIB_PREFIX}/pkgconfig",
           'install'
  end
end
