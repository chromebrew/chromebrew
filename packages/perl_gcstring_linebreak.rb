require 'package'

class Perl_gcstring_linebreak < Package
  description 'UAX 14 Unicode Line Breaking Algorithm - Perl binding Unicode::LineBreak Unicode::GCString'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version '2019.001'
  compatibility 'all'
  source_url 'https://github.com/hatukanezumi/Unicode-LineBreak/archive/Unicode-LineBreak-2019.001.tar.gz'
  source_sha256 'bc9f96cf8bea60665e8ad67e90b0db3cc0bcdb97101e15c8c44ea671ba256577'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_gcstring_linebreak-2019.001-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_gcstring_linebreak-2019.001-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_gcstring_linebreak-2019.001-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_gcstring_linebreak-2019.001-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f3305554fcb79da45098b3b13aa792f74ba773447d2ca7c0b1c114e1fcfd6511',
     armv7l: 'f3305554fcb79da45098b3b13aa792f74ba773447d2ca7c0b1c114e1fcfd6511',
       i686: 'e98342303364ca0faaa8cb272147c4b12aa172ff2d923fb2ee3f3ad160f6c7b2',
     x86_64: '155551083e64b975e1019808f89ca3d42a8ff318367124ad5eedaff610e3f3f0',
  })

  depends_on 'perl'

  def self.build
    system 'git', 'clone', '--recurse-submodules', 'https://github.com/hatukanezumi/Unicode-LineBreak', '-b', "Unicode-LineBreak-#{version}"
    Dir.chdir 'Unicode-LineBreak' do
      system 'perl', 'Makefile.PL'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'Unicode-LineBreak' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
