require 'buildsystems/cmake'

class Zziplib < CMake
  description 'The ZZIPlib provides read access on ZIP-archives and unpacked data.'
  homepage 'https://zziplib.sourceforge.net/'
  version '0.13.80'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/gdraheim/zziplib.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2670ba6fa4866b63fd6e70070a169e530355ccc66938189ac9b679a2d9fb4f92',
     armv7l: '2670ba6fa4866b63fd6e70070a169e530355ccc66938189ac9b679a2d9fb4f92',
       i686: '2e80d0c5286bf3fdaa1b8e1e2a03aefc34c979c716eb89098d855973e5fcc94d',
     x86_64: 'cf37a998b62be10582f351b78173f87788a9006deb31bb4fed0cfe63d50e3fc3'
  })

  depends_on 'glibc' # R
  depends_on 'samurai' => :build
  depends_on 'xmlto' => :build
  depends_on 'zlib' # R

  cmake_options "-DCP=/bin/cp \
        -DGZIP=/bin/gzip \
        -DMKZIP=#{CREW_PREFIX}/bin/zip \
        -DMV=/bin/mv \
        -DPKG_CONFIG_EXECUTABLE=#{CREW_PREFIX}/bin/pkg-config \
        -DPYTHON_EXECUTABLE=/usr/local/bin/python3 \
        -DRM=/bin/rm \
        -DTAR=/bin/tar \
        -DUNZIP=#{CREW_PREFIX}/bin/unzip"
end
