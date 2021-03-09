require 'package'

class Avisynthplus < Package
  description 'An improved version of the AviSynth frameserver'
  homepage 'https://avs-plus.net/'
  version '3.7.0'
  compatibility 'all'
  source_url 'https://github.com/AviSynth/AviSynthPlus/archive/v3.7.0/avisynthplus-3.7.0.tar.gz'
  source_sha256 '8906d9e46dc90a194413d69b710e3106c0aafddc0c5c62004885d0c3beb79862'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/avisynthplus-3.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/avisynthplus-3.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/avisynthplus-3.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/avisynthplus-3.7.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '041ab6c783a42f1ffa0ecbb27b5fee4b49a1e5083b00a48454fc5a29069264ef',
     armv7l: '041ab6c783a42f1ffa0ecbb27b5fee4b49a1e5083b00a48454fc5a29069264ef',
       i686: 'a94ac5f71b9dba1fb0175d828effe302603fa7b72efa09683660ddc9e992d2cd',
     x86_64: '84f41b0ea157e9f53267f9e9212c9ad5eea5ee31d2cb1dc7cd516475e10e04ba'
  })

  depends_on 'devil' => ':build'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -I#{CREW_PREFIX}/include/harfbuzz' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
