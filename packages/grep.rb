
require 'package'

class Grep < Package
  description 'A string search utility'
  homepage 'https://www.gnu.org/software/grep/'
  version '3.6'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/grep/grep-3.6.tar.xz'
  source_sha256 '667e15e8afe189e93f9f21a7cd3a7b3f776202f417330b248c2ad4f997d9373e'

  binary_url ({
     aarch64: 'file:///usr/local/tmp/packages/grep-3.6-chromeos-armv7l.tar.xz',
      armv7l: 'file:///usr/local/tmp/packages/grep-3.6-chromeos-armv7l.tar.xz',
        i686: 'file:///usr/local/tmp/packages/grep-3.6-chromeos-i686.tar.xz',
      x86_64: 'file:///usr/local/tmp/packages/grep-3.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '87ebec000c54b032f1e2720b03a30dfb13f14dc3a2a68a4c943daae64dc5ee34',
      armv7l: '87ebec000c54b032f1e2720b03a30dfb13f14dc3a2a68a4c943daae64dc5ee34',
        i686: 'a6a62d2c91c346041fc4408727e387e2cc415e304d2ca7d372a97256520d6f64',
      x86_64: '0106cbf95ada69fc0205b4af06af4e46144156934555b5bd9376e4c00d61092f',
  })


  depends_on 'glibc'
  depends_on 'pcre'
  depends_on 'texinfo' => ':build'

  def self.build
    ENV['CFLAGS'] = '-flto'
    system "./configure #{CREW_OPTIONS}\
    --without-included-regex"
    system "make"
  end
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
