require 'package'

class Yajl < Package
  description 'A fast streaming JSON parsing library in C.'
  homepage 'http://lloyd.github.io/yajl/'
  version '2.1.0-3'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/lloyd/yajl/archive/refs/tags/2.1.0.tar.gz'
  source_sha256 '3fb73364a5a30efe615046d07e6db9d09fd2b41c763c5f7d3bfb121cd5c5ac5a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yajl/2.1.0-3_armv7l/yajl-2.1.0-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yajl/2.1.0-3_armv7l/yajl-2.1.0-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yajl/2.1.0-3_i686/yajl-2.1.0-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yajl/2.1.0-3_x86_64/yajl-2.1.0-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ea5d04c8b8e356b3d2e7bfc72832da5501ea13adac7bea73f46ea84908b2eef7',
     armv7l: 'ea5d04c8b8e356b3d2e7bfc72832da5501ea13adac7bea73f46ea84908b2eef7',
       i686: '8cf7bea8291e23db0bccc346b5d37348c22f1be4e75bdc2210b48c2ef5f55984',
     x86_64: '66ce37f06d1b48a593fd3cfb99263337c65597e12719c203641da0a0980e96f2'
  })

  depends_on 'glibc' # R

  def self.patch
    # Fix CVE-2022-24795
    downloader 'https://patch-diff.githubusercontent.com/raw/lloyd/yajl/pull/242.patch',
               '28cf573e61ad5d442dc3ea23912e1d1a3a714c6f20a647304fbd5a886b457f29'
    system 'patch -Np1 -i 242.patch'
  end

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake -G Ninja \
        #{CREW_CMAKE_LIBSUFFIX_OPTIONS} \
        -Wno-dev \
        .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
