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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-3_armv7l/perl_text_wrapi18n-0.06-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-3_armv7l/perl_text_wrapi18n-0.06-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-3_i686/perl_text_wrapi18n-0.06-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-3_x86_64/perl_text_wrapi18n-0.06-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '73c382d02a1f51ff81656322b8e0d5e5f77d430e85f977a90644ff8349a600bd',
     armv7l: '73c382d02a1f51ff81656322b8e0d5e5f77d430e85f977a90644ff8349a600bd',
       i686: 'ca96847a5e011fefa633ea7db40909dee0675646bc7e55941defbcc04722ebd1',
     x86_64: 'e5ff4381cfb80b6d4729e59a41e56b48130506c8beddb46a4466447ea8d1f6c2'
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
