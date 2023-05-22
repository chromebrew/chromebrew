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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.36_armv7l/perl_locale_gettext-1.07-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.36_armv7l/perl_locale_gettext-1.07-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.36_i686/perl_locale_gettext-1.07-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.36_x86_64/perl_locale_gettext-1.07-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f6747ac7827416d6760cf45e80b536b8ec715c354a4d450665875a27c5a507b8',
     armv7l: 'f6747ac7827416d6760cf45e80b536b8ec715c354a4d450665875a27c5a507b8',
       i686: '67d06e710eeb3702b0902ba222c2d8c72c0ddc8c6819b330c6abde5c9e8921be',
     x86_64: 'e3f3153dc1f70563af390909d7da7b76ce2757812e32cbab2a494cc10d9038b5'
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
