require 'package'

class Libnghttp2 < Package
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  @_ver = '1.45.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{@_ver}"

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.43.0-1_i686/libnghttp2-1.43.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.45.1_x86_64/libnghttp2-1.45.1-chromeos-x86_64.tpxz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.45.1_armv7l/libnghttp2-1.45.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.45.1_armv7l/libnghttp2-1.45.1-chromeos-armv7l.tpxz'
  })
  binary_sha256({
       i686: '2ea5d7dba201696ff274937e47b8a7eb1d202be529d6c20be23a9ea4156e76a8',
     x86_64: 'f1d7369aee4be665d89a1cc582802fa1cc9d0b7803bd5df91cf2eb8b62a79241',
    aarch64: 'a53af4ca732b343d976f729e809dff883159482b6338dfcb1541e9d20da469db',
     armv7l: 'a53af4ca732b343d976f729e809dff883159482b6338dfcb1541e9d20da469db'
  })

  depends_on 'jansson'
  depends_on 'jemalloc'
  depends_on 'libevent' => :build
  depends_on 'libev' => :build
  depends_on 'py3_cython' => :build

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
        -DENABLE_SHARED_LIB=ON \
        -DENABLE_STATIC_LIB=ON .."
      system 'samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test'
  end
end
