require 'package'

class Openjpeg2 < Package
  description 'An open source JPEG 2000 codec, version ${pkgver}'
  homepage 'https://github.com/uclouvain/openjpeg'
  version '2.4.0'
  compatibility 'all'
  source_url 'https://github.com/uclouvain/openjpeg/archive/v2.4.0.tar.gz'
  source_sha256 '8702ba68b442657f11aaeb2b338443ca8d5fb95b0d845757968a7be31ef7f16d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg2-2.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg2-2.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg2-2.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg2-2.4.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a7c67af7623a7ab2fc66b203d698fb9c9090a59cd6dc8252e1e36f25d53b256f',
     armv7l: 'a7c67af7623a7ab2fc66b203d698fb9c9090a59cd6dc8252e1e36f25d53b256f',
       i686: 'aff2bc38195bd963339ad70f82deb2dee09ae62008370eb17260633bc7b792be',
     x86_64: 'ce81a4fbddcc40c52c628e503b1a5f98e96ed665611d1739f6f6f6566c6d27fe'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS=ON \
        -DOPENJPEG_INSTALL_LIB_DIR='lib#{CREW_LIB_SUFFIX}' \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
