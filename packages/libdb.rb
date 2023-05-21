require 'package'

class Libdb < Package
  description 'Berkeley DB is a family of embedded key-value database libraries providing scalable high-performance data management services to applications.'
  homepage 'https://github.com/berkeleydb/libdb'
  version '5.3.28-dfsg2-1'
  license 'ASM, BSD, CDDL, custom and SPL.'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/db5.3.git'
  git_hashtag 'debian/5.3.28+dfsg2-1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdb/5.3.28-dfsg2-1_armv7l/libdb-5.3.28-dfsg2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdb/5.3.28-dfsg2-1_armv7l/libdb-5.3.28-dfsg2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdb/5.3.28-dfsg2-1_i686/libdb-5.3.28-dfsg2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdb/5.3.28-dfsg2-1_x86_64/libdb-5.3.28-dfsg2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '13c6a2e5b7482bf638b3a37d924a31a782dfc21dd9ac6834885e11d0d7730223',
     armv7l: '13c6a2e5b7482bf638b3a37d924a31a782dfc21dd9ac6834885e11d0d7730223',
       i686: 'f632cf996b72841a48ca0201aaf5dd9a98fc3a51d81ea3e526c2bca9e12b7d13',
     x86_64: 'd849400eb1a1b0ea3797b96ae6e7361c3c392ec11ceeb025d4dca37d1a3c2ae6'
  })

  depends_on 'glibc' # R
  depends_on 'gcc' # R

  def self.patch
    system 'for i in $(cat debian/patches/series); do patch -Np1 -i debian/patches/${i}; done'
  end

  def self.build
    Dir.chdir 'build_unix' do
      system "mold -run ../dist/configure #{CREW_OPTIONS} \
      --enable-compat185 \
      --enable-cxx \
      --enable-dbm \
      --enable-stl"
      system "make -j #{CREW_NPROC} || make"
    end
  end

  def self.install
    Dir.chdir 'build_unix' do
      system 'make', "docdir=#{CREW_PREFIX}/share/doc/db-5.3.28", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
