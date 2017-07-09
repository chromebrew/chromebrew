require 'package'

class Aspell_en < Package
  description 'English Aspell Dictionary'
  homepage 'ftp://ftp.gnu.org/gnu/aspell/dict/0index.html'
  version '2017.01.22-0'
  source_url 'ftp://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-2017.01.22-0.tar.bz2'
  source_sha256 '93c73fae3eab5ea3ca6db3cea8770715a820f1b7d6ea2b932dd66a17f8fd55e1'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/aspell_en-2017.01.22-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/aspell_en-2017.01.22-0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/aspell_en-2017.01.22-0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/aspell_en-2017.01.22-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c6d97d026cc14813d7e056108c9078114b197664dea6f505d8c3306ba7dd0a26',
     armv7l: 'c6d97d026cc14813d7e056108c9078114b197664dea6f505d8c3306ba7dd0a26',
       i686: '747eee5456cb1009913a6f14751049c80dbc297a4e546bfd5c8627d5d7b55be9',
     x86_64: '35c69030c15d7fb6a656c1562564026e666cbecdbbd6931c1a2eef95770ecc72',
  })

  depends_on 'aspell'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
