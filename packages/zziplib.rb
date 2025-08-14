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
    aarch64: 'e838dd853f27f34424ff8e2cda20b5c2cc6fd0f04dc9e0e991e79eb399887ba7',
     armv7l: 'e838dd853f27f34424ff8e2cda20b5c2cc6fd0f04dc9e0e991e79eb399887ba7',
       i686: 'af5e49a64ef416c058fc5482146f3719b0884b626b4003fc5386b1a187022a05',
     x86_64: '96114e7f733bb47a2e42fd23d72b86dfc3252d6933df317ec8ca14fe2dead578'
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
