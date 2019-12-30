require 'package'

class Libsass < Package
  description 'LibSass is a C/C++ port of the Sass engine'
  homepage 'https://sass-lang.com/libsass'
  version '3.6.3'
  source_url 'https://github.com/sass/libsass/archive/3.6.3.tar.gz'
  source_sha256 'dadb470bb9141e91b437119d367654427180ed2b3d04b8000eab5b0ca47cd5bb'

  binary_url ({
  })
  binary_sha256 ({
  })


  def self.build
    system 'autoreconf', '-i'
    system './configure', "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
