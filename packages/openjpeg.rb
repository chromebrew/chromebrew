require 'package'

class Openjpeg < Package
  description 'An open source JPEG 2000 codec, written in C.'
  homepage 'https://github.com/uclouvain/openjpeg'
  version '2.4.0'
  compatibility 'all'
  source_url 'https://github.com/uclouvain/openjpeg/archive/v2.4.0.tar.gz'
  source_sha256 '8702ba68b442657f11aaeb2b338443ca8d5fb95b0d845757968a7be31ef7f16d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.4.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '595710bad9c20bb9cf549c4ac128c38a7b95d765482a4686f92e9a7c2436492c',
     armv7l: '595710bad9c20bb9cf549c4ac128c38a7b95d765482a4686f92e9a7c2436492c',
       i686: 'bab4acb957c546518cff701f1c004778351c7d973bb0c3f42bd4c5e89fd37f87',
     x86_64: '490073608d724068424b594ef15e77bdef75bcb44beebe6c8fe09eb99f06bd0a'
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
