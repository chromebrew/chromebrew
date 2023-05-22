require 'package'

class Perl_text_wrapi18n < Package
  description 'Text::WrapI18N - Line wrapping module with support for multibyte, fullwidth, and combining characters and languages without whitespaces between words.'
  homepage 'https://metacpan.org/pod/Text::WrapI18N'
  version '0.06-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-WrapI18N-0.06.tar.gz'
  source_sha256 '4bd29a17f0c2c792d12c1005b3c276f2ab0fae39c00859ae1741d7941846a488'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-perl5.36_i686/perl_text_wrapi18n-0.06-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-perl5.36_x86_64/perl_text_wrapi18n-0.06-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '148dd4536d42b9c4795f6a9908bd4302aadbd8cbc047129416b1b19599dc4ae0',
  x86_64: '77b27d44fd628031c4e917e22be90a2200b48ef4035c0a22f6b122de76893790'
  })

  depends_on 'perl_text_charwidth' => :build

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
