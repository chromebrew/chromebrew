require 'package'

class Libdb < Package
  description 'Berkeley DB is a family of embedded key-value database libraries providing scalable high-performance data management services to applications.'
  homepage 'https://github.com/berkeleydb/libdb'
  version '5.3.28'
  compatibility 'all'
  source_url 'https://github.com/berkeleydb/libdb/releases/download/v5.3.28/db-5.3.28.tar.gz'
  source_sha256 'e0a992d740709892e81f9d93f06daf305cf73fb81b545afe72478043172c3628'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdb-5.3.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdb-5.3.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdb-5.3.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdb-5.3.28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bf1e26d40554e30404c8eaba250eb008561113f8742f4d9d07999687881c642d',
     armv7l: 'bf1e26d40554e30404c8eaba250eb008561113f8742f4d9d07999687881c642d',
       i686: '5371ea9f3d3fc18d38bd31dbd97854f4d6a06d995a58776ec1e3c94fbf29dc54',
     x86_64: '0e51467868c7ea8fdf9916bf2ee1b3500b8ea7f0f5cd8f9ec4c9f3a3aafc2213',
  })

  def self.build
    Dir.chdir 'build_unix' do
      system "../dist/configure #{CREW_OPTIONS} --enable-dbm"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build_unix' do
      system "make", "docdir=#{CREW_PREFIX}/share/doc/db-5.3.28", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
