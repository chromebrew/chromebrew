require 'package'

class Perl_locale_messages < Package
  description 'Perl Locale::Messages - Gettext Like Message Retrieval'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.32'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.32.tar.gz'
  source_sha256 '80108298f2564ecbfc7110a3042008e665ed00c2e155b36b0188e6c1135ceba5'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.32_i686/perl_locale_messages-1.32-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.32_x86_64/perl_locale_messages-1.32-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '05ca31eeda58be92c2510c96702c0e8d9d9ee39a2ee2452445ca5f27c721a482',
  x86_64: '4708965e84aba6bf3c46f342261b5972c44f5a33bcaf0686c37fe0412324a6f3'
  })

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
