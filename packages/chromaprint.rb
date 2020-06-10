require 'package'

class Chromaprint < Package
  description 'Chromaprint is a client-side library that implements a custom algorithm for extracting fingerprints from any audio source.'
  homepage 'https://acoustid.org/chromaprint'
  version '1.4.3'
  compatibility 'all'
  source_url 'https://github.com/acoustid/chromaprint/releases/download/v1.4.3/chromaprint-1.4.3.tar.gz'
  source_sha256 'ea18608b76fb88e0203b7d3e1833fb125ce9bb61efe22c6e169a50c52c457f82'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/chromaprint-1.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/chromaprint-1.4.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/chromaprint-1.4.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/chromaprint-1.4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c0ea0bbcd43d6211cb11e85f54425d8a0bbea65e31dbf2662358599b1bce256e',
     armv7l: 'c0ea0bbcd43d6211cb11e85f54425d8a0bbea65e31dbf2662358599b1bce256e',
       i686: 'c42f53ac4e2639b6bf5ba55723df112fe95bd1c3dca264383dc681c05e0f3dd6',
     x86_64: '6ed504a7975b1d7dc30eba8d7cf9203ea95c7970948ec5a061a8fc85c691673f',
  })

  depends_on 'ffmpeg'

  def self.build
    suffix = ''
    suffix = '64' if ARCH == 'x86_64'
    system 'cmake',
           "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
           "-DEXEC_INSTALL_PREFIX=#{CREW_PREFIX}",
           "-DLIB_INSTALL_DIR=#{CREW_LIB_PREFIX}",
           '-DCMAKE_BUILD_TYPE=Release',
           "-DLIB_SUFFIX=#{suffix}",
           '-DBUILD_TOOLS=ON',
           '.'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
