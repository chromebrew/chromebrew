require 'package'

class Libnghttp2 < Package
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  @_ver = '1.50.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.50.0_armv7l/libnghttp2-1.50.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.50.0_armv7l/libnghttp2-1.50.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.50.0_i686/libnghttp2-1.50.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.50.0_x86_64/libnghttp2-1.50.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6a791dffcb9fe605f95f2e822b7aa3b111009895b6bc5280c871243c2ef9a93f',
     armv7l: '6a791dffcb9fe605f95f2e822b7aa3b111009895b6bc5280c871243c2ef9a93f',
       i686: 'e07cd661c9896e5397124e826e2f6aae4f422e8ffc9a7c4080f80533d66fdc15',
     x86_64: '0c28ae576d708afd41c95df79283b7b26f1eecd022acd3ee4143e52a230b6bd6'
  })

  depends_on 'jansson'
  depends_on 'jemalloc'
  depends_on 'libev' => :build
  depends_on 'py3_cython' => :build

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "mold -run cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
        -DENABLE_SHARED_LIB=ON \
        -DENABLE_STATIC_LIB=ON .."
      system 'mold -run samu'
    end
  end

  def self.check
    system 'samu -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
