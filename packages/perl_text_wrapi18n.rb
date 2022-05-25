require 'package'

class Perl_text_wrapi18n < Package
  description 'Text::WrapI18N - Line wrapping module with support for multibyte, fullwidth, and combining characters and languages without whitespaces between words.'
  homepage 'https://metacpan.org/pod/Text::WrapI18N'
  version '0.06-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-WrapI18N-0.06.tar.gz'
  source_sha256 '4bd29a17f0c2c792d12c1005b3c276f2ab0fae39c00859ae1741d7941846a488'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-perl5.38_armv7l/perl_text_wrapi18n-0.06-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-perl5.38_armv7l/perl_text_wrapi18n-0.06-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-perl5.38_i686/perl_text_wrapi18n-0.06-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-perl5.38_x86_64/perl_text_wrapi18n-0.06-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '593d4a8d191f49be64202917c580d736596e5a40ee3f04ac6063753a38924674',
     armv7l: '593d4a8d191f49be64202917c580d736596e5a40ee3f04ac6063753a38924674',
       i686: '5d5760894ae7630944b1dea313de471552d3a4425a78ee7ff0da72038842be84',
     x86_64: '8e17a408a94046a84bb18031785c9774bdfb66e806389ee5a6b425fc6743522a'
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
