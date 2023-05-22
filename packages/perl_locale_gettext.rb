require 'package'

class Perl_locale_gettext < Package
  description 'Locale::gettext - message handling functions'
  homepage 'https://search.cpan.org/dist/Locale-gettext/'
  license 'GPL-1+ or Artistic'
  version '1.07-perl5.36'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/P/PV/PVANDRY/gettext-1.07.tar.gz'
  source_sha256 '909d47954697e7c04218f972915b787bd1244d75e3bd01620bc167d5bbc49c15'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-3_armv7l/perl_locale_gettext-1.07-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-3_armv7l/perl_locale_gettext-1.07-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-3_i686/perl_locale_gettext-1.07-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-3_x86_64/perl_locale_gettext-1.07-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4a5989e5abe52832555940fdd822060668995e90214af56863615d0f91b6da1f',
     armv7l: '4a5989e5abe52832555940fdd822060668995e90214af56863615d0f91b6da1f',
       i686: '741691fa07003c4a48271729f3132963347ce1fece484a3c7afbbdf181653fdd',
     x86_64: '9ffa2023c67efa19ee4bce9f720b26e452a72110d675aeca7232a122338cea22'
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
