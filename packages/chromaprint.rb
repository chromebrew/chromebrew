require 'package'

class Chromaprint < Package
  description 'Chromaprint is a client-side library that implements a custom algorithm for extracting fingerprints from any audio source.'
  homepage 'https://acoustid.org/chromaprint'
  version '1.5.1-aa67c95-1'
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/acoustid/chromaprint.git'
  git_hashtag 'aa67c95b9e486884a6d3ee8b0c91207d8c2b0551'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chromaprint/1.5.1-aa67c95-1_armv7l/chromaprint-1.5.1-aa67c95-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chromaprint/1.5.1-aa67c95-1_armv7l/chromaprint-1.5.1-aa67c95-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/chromaprint/1.5.1-aa67c95-1_x86_64/chromaprint-1.5.1-aa67c95-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '50ac01fa69b92c8a140a3ab02c26cfcb9974a2e4917d626ca523a2b22edb775f',
     armv7l: '50ac01fa69b92c8a140a3ab02c26cfcb9974a2e4917d626ca523a2b22edb775f',
     x86_64: '05f5a2e30fcbd6ccc344388701b9b2e27a867d2d7e0fe39f71a9a989cee7aa23'
  })

  depends_on 'ffmpeg' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "mold -run cmake -B builddir -G Ninja #{CREW_CMAKE_LIBSUFFIX_OPTIONS} \
      -DBUILD_TOOLS=ON \
      -DBUILD_TESTS=ON"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.check
    system "#{CREW_NINJA} -C builddir check"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
