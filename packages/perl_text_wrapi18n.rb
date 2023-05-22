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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-perl5.36_armv7l/perl_text_wrapi18n-0.06-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-perl5.36_armv7l/perl_text_wrapi18n-0.06-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-perl5.36_i686/perl_text_wrapi18n-0.06-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_wrapi18n/0.06-perl5.36_x86_64/perl_text_wrapi18n-0.06-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b750c02e991b11e69a63671988a0ede7413f48cbd6281caaddf314a107f6b0a2',
     armv7l: 'b750c02e991b11e69a63671988a0ede7413f48cbd6281caaddf314a107f6b0a2',
       i686: '71693e5d5b19237d7936dd3ae4438a1e078248adcc8963f048ccb603c4ca2492',
     x86_64: '7bec9e612011701dcdd66d90dd39c68075d95bfc82a89c1bc768293d9b5bd661'
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
