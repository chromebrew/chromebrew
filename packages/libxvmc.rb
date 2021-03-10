require 'package'

class Libxvmc < Package
  description 'X.org X-Video Motion Compensation Library'
  homepage 'http://www.x.org'
  version '1.0.12'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXvMC-1.0.12.tar.gz'
  source_sha256 '024c9ec4f001f037eeca501ee724c7e51cf287eb69ced8c6126e16e7fa9864b5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxvmc-1.0.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxvmc-1.0.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxvmc-1.0.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxvmc-1.0.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de7b0488e06370113a6fe8328f9bb7930a780d881a7532265378bc262b324c74',
     armv7l: 'de7b0488e06370113a6fe8328f9bb7930a780d881a7532265378bc262b324c74',
       i686: 'a7282ab86a3545c068795f719d1dec124fc10a9c61d8ce058e724c4c32f288e0',
     x86_64: '1aa077674ba2b1c3ed3fc6397589ad2a16b4d29bcab9c20fafac64a2e19a673b',
  })

  depends_on 'libxv'
  depends_on 'libx11'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
            LDFLAGS='-flto=auto' \
            ./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
