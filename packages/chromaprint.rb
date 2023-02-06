require 'package'

class Chromaprint < Package
  description 'Chromaprint is a client-side library that implements a custom algorithm for extracting fingerprints from any audio source.'
  homepage 'https://acoustid.org/chromaprint'
  version '1.5.1-aa67c95'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/acoustid/chromaprint.git'
  git_hashtag 'aa67c95b9e486884a6d3ee8b0c91207d8c2b0551'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chromaprint/1.5.1-aa67c95_armv7l/chromaprint-1.5.1-aa67c95-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chromaprint/1.5.1-aa67c95_armv7l/chromaprint-1.5.1-aa67c95-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chromaprint/1.5.1-aa67c95_i686/chromaprint-1.5.1-aa67c95-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chromaprint/1.5.1-aa67c95_x86_64/chromaprint-1.5.1-aa67c95-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2af4152ec6d6ff7f1051173ed18c8cbd4a3e555751b4adf0528bec080c99ed2d',
     armv7l: '2af4152ec6d6ff7f1051173ed18c8cbd4a3e555751b4adf0528bec080c99ed2d',
       i686: '16a3f75458354abea8c4e037320999569b3d7fcbdb5c5185e2ec9d78af5647d0',
     x86_64: 'ac0c32d428d3277d1ddfe389008b8452139e5c57a280ce7d0fe74e23ac50a517'
  })

  depends_on 'ffmpeg' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R

  def self.build
    system "cmake -B builddir -G Ninja #{CREW_CMAKE_LIBSUFFIX_OPTIONS} \
      -DBUILD_TOOLS=ON \
      -DBUILD_TESTS=ON"
    system 'samu -C builddir'
  end

  def self.check
    system 'samu -C builddir check'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
