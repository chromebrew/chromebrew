require 'buildsystems/autotools'

class Lftp < Autotools
  description 'LFTP is a sophisticated file transfer program for ftp/http/sftp/fish/torrent'
  homepage 'https://lftp.yar.ru'
  version '4.9.3'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://lftp.yar.ru/ftp/lftp-#{version}.tar.xz"
  source_sha256 '96e7199d7935be33cf6b1161e955b2aab40ab77ecdf2a19cea4fc1193f457edc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'de3ce92cfea7a78528a1838621d71783458eab0ed12fe5a614d562062fa1f9a6',
     armv7l: 'de3ce92cfea7a78528a1838621d71783458eab0ed12fe5a614d562062fa1f9a6',
       i686: 'a87599a505f1ff68712074d375db00e3eef299c7968c89f5b1e67929c57a84ca',
     x86_64: '428ea5e80bbe8d51d53b991532275f6bb1c2b3a4e2475b18bf1eb103fee0a67a'
  })

  depends_on 'brotli' => :executable
  depends_on 'expat' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gmp' => :executable
  depends_on 'gnutls' => :executable
  depends_on 'libidn2' => :executable
  depends_on 'libtasn1' => :executable
  depends_on 'libunistring' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'nettle' => :executable
  depends_on 'p11kit' => :executable
  depends_on 'readline' => :executable
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  autotools_configure_options '--disable-nls --with-linux-crypto'

  def self.patch
    # Fix error: weak declaration of 'thrd_exit' must be public.
    system "sed -i 's,static C11THREADS_INLINE void thrd_exit(,public C11THREADS_INLINE void thrd_exit(,' #{CREW_PREFIX}/include/threads.h"
  end
end
