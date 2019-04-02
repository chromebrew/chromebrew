require 'package'

class Gdb < Package
  description 'GDB, the GNU Project debugger, allows you to see what is going on \'inside\' another program while it executes -- or what another program was doing at the moment it crashed.'
  homepage 'https://www.gnu.org/software/gdb/'
  version '8.2.1'
  source_url 'https://ftpmirror.gnu.org/gdb/gdb-8.2.1.tar.xz'
  source_sha256 '0a6a432907a03c5c8eaad3c3cffd50c00a40c3a5e3c4039440624bae703f2202'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9bd4500d8af36782c5e047e15aef059fc0562e0f1c7acc391692d6287d88276a',
     armv7l: '9bd4500d8af36782c5e047e15aef059fc0562e0f1c7acc391692d6287d88276a',
       i686: '2078a79d604628c270576be8fb96e8ccaa087ef207e3f6d14356c606898027e8',
     x86_64: '95fe8fac708e2c28b4c8c8453bfbd7d85d5fe795d80ceaf86ff255d574b2c5b1',
  })

  depends_on 'libx11'
  depends_on 'python3'
  depends_on 'python27'

  def self.build
    system './configure',
           '--with-x',
           '--with-lzma',
           '--enable-sim',
           '--with-expat',
           '--enable-tui',
           '--with-python',
           '--with-curses',
           '--enable-shared',
           '--with-system-zlib',
           '--enable-64-bit-bfd',
           '--enable-host-shared',
           '--with-system-readline',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-pkgversion=Chromebrew'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
