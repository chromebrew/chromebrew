require 'package'

class Bashdb < Package
  description 'The Bash Debugger Project is a source-code debugger for bash that follows the gdb command syntax.'
  homepage 'http://bashdb.sourceforge.net/'
  version '4.3-0.91'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/bashdb/bashdb/4.3-0.91/bashdb-4.3-0.91.tar.bz2'
  source_sha256 '60117745813f29070a034c590c9d70153cc47f47024ae54bfecdc8cd86d9e3ea'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bashdb-4.3-0.91-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bashdb-4.3-0.91-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bashdb-4.3-0.91-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bashdb-4.3-0.91-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '833df9e8e4b7eebdf1d84021614e1f96e36246f8b3a6885b3a1cb453bd3721e2',
     armv7l: '833df9e8e4b7eebdf1d84021614e1f96e36246f8b3a6885b3a1cb453bd3721e2',
       i686: '0a8ef27b0d6c4f82e8918ea12955b76dae0b2c4b43cce6a7ed7d8f59a3616585',
     x86_64: 'b86e37e76d360d4cd0ec70d2658770844eec81fed829ca0a51fc0bb3da0efa96',
  })

  depends_on 'compressdoc' => :build

  def self.build
    system "./configure \
            --bindir=#{CREW_PREFIX}/bin \
            --datadir=#{CREW_PREFIX}/share \
            --infodir=#{CREW_PREFIX}/info \
            --mandir=#{CREW_PREFIX}/man"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/man/man1"
  end
end
