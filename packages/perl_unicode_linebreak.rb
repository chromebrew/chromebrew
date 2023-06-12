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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.36_armv7l/perl_unicode_linebreak-2019.001-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.36_armv7l/perl_unicode_linebreak-2019.001-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.36_i686/perl_unicode_linebreak-2019.001-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.36_x86_64/perl_unicode_linebreak-2019.001-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ddf06319525408d46d08bf364c6d4f18fd103af8080cf0f2cfacbca208d71508',
     armv7l: 'ddf06319525408d46d08bf364c6d4f18fd103af8080cf0f2cfacbca208d71508',
       i686: '34f186375c3431108966f528a6560e9f25386cec190209d389643a14a1cbf2a6',
     x86_64: '36a7895dfccedf012de2c6a07330b6d09568fb7183e004818d4f7945d3c00c09'
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
