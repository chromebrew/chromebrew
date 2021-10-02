require 'package'

class Perl_gcstring_linebreak < Package
  description 'UAX 14 Unicode Line Breaking Algorithm - Perl binding Unicode::LineBreak Unicode::GCString'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version '2019.001-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/hatukanezumi/Unicode-LineBreak.git'
  git_hashtag 'Unicode-LineBreak-2019.001'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_gcstring_linebreak/2019.001-1_armv7l/perl_gcstring_linebreak-2019.001-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_gcstring_linebreak/2019.001-1_armv7l/perl_gcstring_linebreak-2019.001-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_gcstring_linebreak/2019.001-1_i686/perl_gcstring_linebreak-2019.001-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_gcstring_linebreak/2019.001-1_x86_64/perl_gcstring_linebreak-2019.001-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '376dfc3b39d861076e0ead658cc62ae07d5d753eaaf86bb70d440a537c3a4da4',
     armv7l: '376dfc3b39d861076e0ead658cc62ae07d5d753eaaf86bb70d440a537c3a4da4',
       i686: 'bedf57b7890ffb8ad84fce620bc07b28c1128901829a9453905ce8f64982a3eb',
     x86_64: '2ccb5f0a0e9d96e02b13d1d4e16719b9df93d82354642f8f94feae76fa0cbd87'
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
