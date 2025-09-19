require 'package'

class Libdb < Package
  description 'Berkeley DB is a family of embedded key-value database libraries providing scalable high-performance data management services to applications.'
  homepage 'https://github.com/berkeleydb/libdb'
  version '5.3.28-dfsg2-9'
  license 'ASM, BSD, CDDL, custom and SPL.'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/db5.3.git'
  git_hashtag 'debian/5.3.28+dfsg2-9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'efa2f54b5f94d526cbee90578d5abd195d509d7f709509cb4b7171fd2bc9f53d',
     armv7l: 'efa2f54b5f94d526cbee90578d5abd195d509d7f709509cb4b7171fd2bc9f53d',
       i686: '05794e6cc1db16bd0168ea96a8cda7734a67a4d5ec312430004eabb103ea679a',
     x86_64: 'aa805c343c1b791f8a6ffa024e43f209342a4fb51df0d30463441a913e8479df'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.patch
    system 'for i in $(cat debian/patches/series); do patch -Np1 -i debian/patches/${i}; done'
  end

  def self.build
    Dir.chdir 'build_unix' do
      system "../dist/configure #{CREW_CONFIGURE_OPTIONS} \
      --disable-java \
      --disable-sql \
      --disable-stl \
      --disable-tcl \
      --enable-compat185 \
      --enable-cxx \
      --enable-dbm \
      --with-mutex=POSIX/pthreads/library"
      system "make -j #{CREW_NPROC} || make"
    end
  end

  def self.install
    Dir.chdir 'build_unix' do
      system 'make', "docdir=#{CREW_PREFIX}/share/doc/db-5.3.28", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
