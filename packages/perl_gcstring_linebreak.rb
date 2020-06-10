require 'package'

class Perl_gcstring_linebreak < Package
  description 'UAX 14 Unicode Line Breaking Algorithm - Perl binding Unicode::LineBreak Unicode::GCString'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version '2018.003'
  compatibility 'all'
  source_url 'https://github.com/hatukanezumi/Unicode-LineBreak/archive/Unicode-LineBreak-2018.003.tar.gz'
  source_sha256 '6f8cb4de140f8b63924786df8b0c2389c342bccdee05fbb1b9af8d8b6a8a3fad'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_gcstring_linebreak-2018.003-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_gcstring_linebreak-2018.003-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_gcstring_linebreak-2018.003-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_gcstring_linebreak-2018.003-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6b4d8c4737b77a5b36be8dacf5cd6671252479ff4f3dd55a9d5c95478923b321',
     armv7l: '6b4d8c4737b77a5b36be8dacf5cd6671252479ff4f3dd55a9d5c95478923b321',
       i686: 'ae3dfe0e317fec4d8c3a0d88fa1dc1733da800fcf23c0053886ee477b94f1057',
     x86_64: 'bb0a1cd5fd243b0c07cd40fdbf77e9c7150807beb418a68f894f58e226f1c24a',
  })

  def self.build
      system "git", "clone", "--recurse-submodules", "https://github.com/hatukanezumi/Unicode-LineBreak", "-b", "Unicode-LineBreak-2018.003"
    Dir.chdir ("Unicode-LineBreak") do
      system "perl", "Makefile.PL"
      system "make"
    end
  end

  def self.install
    Dir.chdir ("Unicode-LineBreak") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
