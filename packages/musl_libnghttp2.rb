require 'package'

class Musl_libnghttp2 < Package
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  version '1.46.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libnghttp2/1.46.0_armv7l/musl_libnghttp2-1.46.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libnghttp2/1.46.0_armv7l/musl_libnghttp2-1.46.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libnghttp2/1.46.0_i686/musl_libnghttp2-1.46.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libnghttp2/1.46.0_x86_64/musl_libnghttp2-1.46.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '100bc140036d70a07ae3497da6b276b46acadbbe9f214f17c7eea4b2eedea6b7',
     armv7l: '100bc140036d70a07ae3497da6b276b46acadbbe9f214f17c7eea4b2eedea6b7',
       i686: '45ee0ea9e9fbb24681e9da2dabd2191d76b2374521cf9a4ee6bcc200edf9de73',
     x86_64: '7f52972492d8445872028ee6a6c6ca899abd30e2b3fee4d0e2325a9c69300e4c'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_ncurses' => :build
  depends_on 'musl_openssl' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "#{MUSL_CMAKE_OPTIONS} \
      -DENABLE_SHARED_LIB=OFF \
      -DENABLE_STATIC_LIB=ON \
      -DENABLE_LIB_ONLY=ON \
      ../ -G Ninja"
    end
    system "PATH=#{CREW_MUSL_PREFIX}/bin:#{CREW_MUSL_PREFIX}/#{ARCH}-linux-musl#{MUSL_ABI}/bin:#{ENV.fetch('PATH', nil)} \
      samu -C builddir -j#{CREW_NPROC}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
