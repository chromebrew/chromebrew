require 'package'

class Perl_unicode_eastasianwidth < Package
  description 'Perl Unicode::EastAsianWidth - East Asian Width properties.'
  homepage 'https://metacpan.org/pod/Unicode::EastAsianWidth'
  version '12.0'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AU/AUDREYT/Unicode-EastAsianWidth-12.0.tar.gz'
  source_sha256 '2a5bfd926c4fe5f77e6137da2c31ac2545282ae5fec6e9af0fdd403555a90ff4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_unicode_eastasianwidth-12.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_unicode_eastasianwidth-12.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_unicode_eastasianwidth-12.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_unicode_eastasianwidth-12.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5593ee971d525518b3ceb87f09ac1e72f9588f07560af63eb11ab82da3f69e49',
     armv7l: '5593ee971d525518b3ceb87f09ac1e72f9588f07560af63eb11ab82da3f69e49',
       i686: '6cd20f8a7cfb18799864003c76475c4e8280c7367f7285460facbf44d9279a5d',
     x86_64: 'd200c9e1cc6c1e02a690006914c0f7e7845e7af92d2ec858df58b5f9cd0e3c4c',
  })

  depends_on 'perl'

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
