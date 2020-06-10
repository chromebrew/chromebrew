require 'package'

class Ttf2pt1 < Package
  description 'Converter of various scalable font formats (most notably TTF) and of the bitmapped BDF format into PostScript Type 1 fonts and metrics (.pfa, .pfb, .afm).'
  homepage 'http://ttf2pt1.sourceforge.net/'
  version '3.4.4'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/ttf2pt1/ttf2pt1/3.4.4/ttf2pt1-3.4.4.tgz'
  source_sha256 'ae926288be910073883b5c8a3b8fc168fde52b91199fdf13e92d72328945e1d0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ttf2pt1-3.4.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ttf2pt1-3.4.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ttf2pt1-3.4.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ttf2pt1-3.4.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2ec84f7e4625661c6566c5252ca8fb6034d854a87593856c187a9587f10e286c',
     armv7l: '2ec84f7e4625661c6566c5252ca8fb6034d854a87593856c187a9587f10e286c',
       i686: 'eb43e1cee6093de979abdcfd11409149bba328f0e4ac73e77305d5e3baea322f',
     x86_64: 'e8faecc72638a7df553126f461d87b278ed0cb064a19bad8d9d1f28240ee8e76',
  })

  depends_on 'help2man' => :build

  def self.patch
    system "sed -i '242,262d' Makefile"
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' scripts/inst_dir"
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' scripts/html2man"
  end

  def self.build
    system 'make veryclean'
    system 'make all'
    system "help2man -N --no-discard-stderr -o t1asm.1 ./t1asm"
    system "sed -i 's,This is t1asm .,t1asm,g' t1asm.1"
    system "sed -i 's,This \\\\- m,M,' t1asm.1"
    system "sed -i 's,THIS,T1ASM,' t1asm.1"
    system "sed -i '12,18d' t1asm.1"
    system "sed -i '7d' t1asm.1"
  end

  def self.install
    system "install -Dm755 t1asm #{CREW_DEST_PREFIX}/bin/t1asm"
    system "install -Dm755 ttf2pt1 #{CREW_DEST_PREFIX}/bin/ttf2pt1"
    system "install -Dm755 scripts/x2gs #{CREW_DEST_PREFIX}/bin/ttf2pt1_x2gs"
    system "install -Dm755 scripts/convert #{CREW_DEST_PREFIX}/bin/ttf2pt1_convert"
    system "install -Dm644 t1asm.1 #{CREW_DEST_PREFIX}/share/man/man1/t1asm.1"
    system "install -Dm644 ttf2pt1.1 #{CREW_DEST_PREFIX}/share/man/man1/ttf2pt1.1"
    system "install -Dm644 ttf2pt1_x2gs.1 #{CREW_DEST_PREFIX}/share/man/man1/ttf2pt1_x2gs.1"
    system "install -Dm644 ttf2pt1_convert.1 #{CREW_DEST_PREFIX}/share/man/man1/ttf2pt1_convert.1"
    system 'make',
           "INSTDIR=#{CREW_DEST_PREFIX}",
           "OWNER=#{USER}",
           "GROUP=#{USER}",
           'install'
  end
end
