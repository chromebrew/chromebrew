require 'package'

class Libfaudio < Package
  description 'FAudio is an XAudio reimplementation that focuses solely on developing fully accurate DirectX Audio runtime libraries for the FNA project.'
  homepage 'https://fna-xna.github.io/'
  @_ver = '22.01'
  version @_ver
  license 'ZLIB'
  compatibility 'all'
  source_url 'https://github.com/fna-xna/faudio.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfaudio/22.01_armv7l/libfaudio-22.01-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfaudio/22.01_armv7l/libfaudio-22.01-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfaudio/22.01_i686/libfaudio-22.01-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfaudio/22.01_x86_64/libfaudio-22.01-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b3254a7042cf5561d1dcfd7274836be58fefb76c8d51b9fe1c24bec6cdd78ad2',
     armv7l: 'b3254a7042cf5561d1dcfd7274836be58fefb76c8d51b9fe1c24bec6cdd78ad2',
       i686: 'edcb532fa7cba8ce46d377d4550d9289748e87780aa19eb55216a4b802024747',
     x86_64: 'd4a3bd0adf604d19a7596644f8720d607628d2751f9c711f61b9b3f95e3a6977'
  })

  depends_on 'libsdl2'

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
