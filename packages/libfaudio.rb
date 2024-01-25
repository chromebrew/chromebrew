require 'package'

class Libfaudio < Package
  description 'FAudio is an XAudio reimplementation that focuses solely on developing fully accurate DirectX Audio runtime libraries for the FNA project.'
  homepage 'https://fna-xna.github.io/'
  version '23.01'
  license 'ZLIB'
  compatibility 'all'
  source_url 'https://github.com/fna-xna/faudio.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44a8d21f66f7c203de84fa23f7a62fb4a0ee9336a70723b1be2c6e07a8ab6b24',
     armv7l: '44a8d21f66f7c203de84fa23f7a62fb4a0ee9336a70723b1be2c6e07a8ab6b24',
       i686: '2a066df72e1e98b6ac9ed469965599afe27db630e4d3df4127edf14a6d41f2e5',
     x86_64: 'ea99d746766103f3ffe67feab001c04428c788a2db2d583edb0e3b5b87947e4b'
  })

  depends_on 'glibc' # R
  depends_on 'libsdl2' # R

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} .. \
              -DBUILD_TESTS=ON"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    Dir.chdir 'builddir' do
      system './faudio_tests'
    end
  end
end
