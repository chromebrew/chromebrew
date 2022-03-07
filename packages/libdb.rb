require 'package'

class Libdb < Package
  description 'Berkeley DB is a family of embedded key-value database libraries providing scalable high-performance data management services to applications.'
  homepage 'https://github.com/berkeleydb/libdb'
  version '5.3.28-1'
  license 'ASM, BSD, CDDL, custom and SPL.'
  compatibility 'all'
  source_url 'https://github.com/berkeleydb/libdb/releases/download/v5.3.28/db-5.3.28.tar.gz'
  source_sha256 'e0a992d740709892e81f9d93f06daf305cf73fb81b545afe72478043172c3628'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdb/5.3.28-1_armv7l/libdb-5.3.28-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdb/5.3.28-1_armv7l/libdb-5.3.28-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdb/5.3.28-1_i686/libdb-5.3.28-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdb/5.3.28-1_x86_64/libdb-5.3.28-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '29f77d25f61cd4492244121f23872e7248d91ae08b12cc479706ef63fdebdae3',
     armv7l: '29f77d25f61cd4492244121f23872e7248d91ae08b12cc479706ef63fdebdae3',
       i686: 'a813b4c1bcd84254e9f1fb45ecb37b6f1d7ca60beb3b435759338e4d1914d3d7',
     x86_64: 'c3af1fe7d33a0453e7bf33425a310666cd6239be1d38729c69af52350cc350aa'
  })

  depends_on 'glibc' # R

  def self.build
    Dir.chdir 'build_unix' do
      system "../dist/configure #{CREW_OPTIONS} \
      --enable-compat185 \
      --enable-dbm"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build_unix' do
      system 'make', "docdir=#{CREW_PREFIX}/share/doc/db-5.3.28", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
