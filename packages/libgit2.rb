require 'package'

class Libgit2 < Package
  description 'A portable, pure C implementation of the Git core methods'
  homepage 'https://libgit2.org/'
  @_ver = '1.1.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/libgit2/libgit2/releases/download/v#{@_ver}/libgit2-#{@_ver}.tar.gz"
  source_sha256 'ad73f845965cfd528e70f654e428073121a3fa0dc23caac81a1b1300277d4dba'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgit2-1.1.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgit2-1.1.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgit2-1.1.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgit2-1.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '6ace517ea3525066a11071ed20e02eda6862bd944ceaf4f704c2f28b5f0bc6ac',
      armv7l: '6ace517ea3525066a11071ed20e02eda6862bd944ceaf4f704c2f28b5f0bc6ac',
        i686: '560685b52825f1bd4c3e6e45b328dec6a68f31d4d8c91ea2129626c0a7b39e9d',
      x86_64: 'a12810a16d4a054a1a7d05925743562bf28e2b6e5f1c5f0db22f82a87208f7e9',
  })

  depends_on 'python3'
  depends_on 'libssh2'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
        cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
      system 'ninja'
    end
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
