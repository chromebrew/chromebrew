require 'package'

class Perl_unicode_linebreak < Package
  description 'Unicode::LineBreak - UAX #14 Unicode Line Breaking Algorithm'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version '2019.001-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/hatukanezumi/Unicode-LineBreak.git'
  git_hashtag 'Unicode-LineBreak-2019.001'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.36_i686/perl_unicode_linebreak-2019.001-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.36_x86_64/perl_unicode_linebreak-2019.001-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'c9c65c9b12bb61735dcf0c771fafef3560847c50d05d2a1350540e7be59c078b',
  x86_64: 'a1a6f8ea2a00e25e05d88eea93055061b3774838ff488b6622ce3e99d93e6ab9'
  })

  depends_on 'glibc' # R

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
