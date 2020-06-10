require 'package'

class Libsass < Package
  description 'LibSass is a C/C++ port of the Sass engine'
  homepage 'https://sass-lang.com/libsass'
  version '3.6.3'
  compatibility 'all'
  source_url 'https://github.com/sass/libsass/archive/3.6.3.tar.gz'
  source_sha256 'dadb470bb9141e91b437119d367654427180ed2b3d04b8000eab5b0ca47cd5bb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsass-3.6.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsass-3.6.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsass-3.6.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsass-3.6.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '127212de28af881fef04f4507ddad8dcee18ea8028f1c3549626de311d152ea4',
     armv7l: '127212de28af881fef04f4507ddad8dcee18ea8028f1c3549626de311d152ea4',
       i686: '696212537afd414d5571b23c1ee592fbcccb6ea4e8146f231ea4924d0bb1dd3c',
     x86_64: '37b197a5850c29264a624c55706c2cb8c9eb70c2f9293a41b8dbf6a261a7e85c',
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
