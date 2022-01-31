require 'package'

class Libfaudio < Package
  description 'FAudio is an XAudio reimplementation that focuses solely on developing fully accurate DirectX Audio runtime libraries for the FNA project.'
  homepage 'https://fna-xna.github.io/'
  @_ver = '22.01'
  version @_ver
  compatibility 'all'
  license 'ZLIB'
  source_url 'https://github.com/fna-xna/faudio.git'
  git_hashtag @_ver

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} .. \
              -DBUILD_TESTS=ON \
              -DGSTREAMER=OFF" # GStreamer support is depreciated
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
