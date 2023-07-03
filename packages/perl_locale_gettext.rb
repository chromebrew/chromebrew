require 'package'

class Perl_locale_gettext < Package
  description 'Locale::gettext - message handling functions'
  homepage 'https://search.cpan.org/dist/Locale-gettext/'
  license 'GPL-1+ or Artistic'
  version '1.07-perl5.38'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/P/PV/PVANDRY/gettext-1.07.tar.gz'
  source_sha256 '909d47954697e7c04218f972915b787bd1244d75e3bd01620bc167d5bbc49c15'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.38_armv7l/perl_locale_gettext-1.07-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.38_armv7l/perl_locale_gettext-1.07-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.38_i686/perl_locale_gettext-1.07-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-perl5.38_x86_64/perl_locale_gettext-1.07-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '236293fc1eca2efd01b9f159763db91fe2ce32d934590cac86892cf1ff5699b1',
     armv7l: '236293fc1eca2efd01b9f159763db91fe2ce32d934590cac86892cf1ff5699b1',
       i686: '8b845f438dc26b4d4c2e717f306535df198c3211579cdbf42dafdd720454ef78',
     x86_64: '8f2f78ffcff91fe7b00b8a6a97d41fa3d994f2529ef18f8cc3f652b37bb04a55'
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
