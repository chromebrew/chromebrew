require 'package'

class Pkgconf < Package
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://git.sr.ht/~kaniini/pkgconf'
  version '1.7.3'
  compatibility 'all'
  source_url 'https://git.sr.ht/~kaniini/pkgconf/archive/pkgconf-1.7.3.tar.gz'
  source_sha256 '88e93bbd1d4dc81fc08bfc7a39b3eca241aee3131091c9ba0684531ee4d9d2b3'

  depends_on 'glibc'

# Can be enabled for packages by setting
# ENV['PKG_CONFIG'] = "#{CREW_PREFIX}/bin/pkgconf"

def self.build
    system "./autogen.sh"
    system "./configure #{CREW_OPTIONS} \
    --with-system-libdir=#{CREW_LIB_PREFIX} \
    --with-system-includedir=#{CREW_PREFIX}/include"
    system "make"
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
