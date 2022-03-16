require 'package'

class Perl_text_wrapi18n < Package
  description 'Text::WrapI18N - Line wrapping module with support for multibyte, fullwidth, and combining characters and languages without whitespaces between words.'
  homepage 'https://metacpan.org/pod/Text::WrapI18N'
  version '0.06-3'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-WrapI18N-0.06.tar.gz'
  source_sha256 '4bd29a17f0c2c792d12c1005b3c276f2ab0fae39c00859ae1741d7941846a488'

  depends_on 'perl_text_charwidth'

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
