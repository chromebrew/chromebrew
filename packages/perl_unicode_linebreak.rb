require 'package'

class Perl_unicode_linebreak < Package
  description 'Unicode::LineBreak - UAX #14 Unicode Line Breaking Algorithm'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version '2019.001-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://github.com/hatukanezumi/Unicode-LineBreak.git'
  git_hashtag 'Unicode-LineBreak-2019.001'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38_armv7l/perl_unicode_linebreak-2019.001-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38_armv7l/perl_unicode_linebreak-2019.001-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38_i686/perl_unicode_linebreak-2019.001-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_linebreak/2019.001-perl5.38_x86_64/perl_unicode_linebreak-2019.001-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '27454e73ad558afc5c3d003e5c307a1f543b2d88e6948ed54df11f585456c2e5',
     armv7l: '27454e73ad558afc5c3d003e5c307a1f543b2d88e6948ed54df11f585456c2e5',
       i686: 'ae464dbbed0cf6194d3dafe1f240b00cb0eebf8a7bbe9f9379085a2970d65ea3',
     x86_64: '3af3ef60f9793cae6507a3282c6d018edc112f764480d4f014f708d5b0711441'
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
