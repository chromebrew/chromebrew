require 'package'

class P7zip < Package
  description 'p7zip is a port of 7za.exe for POSIX systems like Unix (Linux, Solaris, OpenBSD, FreeBSD, Cygwin, AIX, ...), MacOS X and also for BeOS and Amiga.'
  homepage 'http://p7zip.sourceforge.net/'
  version '16.02'
  source_url 'http://downloads.sourceforge.net/p7zip/p7zip_16.02_src_all.tar.bz2'
  source_sha256 '5eb20ac0e2944f6cb9c2d51dd6c4518941c185347d4089ea89087ffdd6e2341f'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/p7zip-16.02-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/p7zip-16.02-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/p7zip-16.02-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/p7zip-16.02-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8507b82c9a7963e530ae29e42739cea7f77185ab783d27a2463f41f445c0f412',
     armv7l: '8507b82c9a7963e530ae29e42739cea7f77185ab783d27a2463f41f445c0f412',
       i686: 'e01f869ce698b0d15f11b6e0419646c0b2a30e79550fe14ccb9c924bae057808',
     x86_64: '08607cec779619e7e4c3aee457b46dced2f64077e2955c54c727f530af59f78b',
  })

  def self.build
    system "cp", "makefile.linux_any_cpu", "makefile.machine"
    system "make", "all3"
  end

  def self.install
    system "make", "DEST_DIR=#{CREW_DEST_DIR}", "install"
  end
end
