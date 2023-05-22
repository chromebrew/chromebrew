require 'package'

class Perl_locale_messages < Package
  description 'Perl Locale::Messages - Gettext Like Message Retrieval'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.33-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.33.tar.gz'
  source_sha256 '5126eda9ccd0eeb10db82ddef63cbcaf7dbd771e78cc0fb110cc3b5a6b8679e7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.36_armv7l/perl_locale_messages-1.33-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.36_armv7l/perl_locale_messages-1.33-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.36_i686/perl_locale_messages-1.33-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.36_x86_64/perl_locale_messages-1.33-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b7dfeefeb3b49098f7bcd87bbde7b34bdf5468c66d66b8418b0acd0fb093ec12',
     armv7l: 'b7dfeefeb3b49098f7bcd87bbde7b34bdf5468c66d66b8418b0acd0fb093ec12',
       i686: '0e40a1d342ec6e7ab26f74235b08628cec94189d046edb064c386340f63afe56',
     x86_64: '2a1ce4d3247864cd53fc1a8328b45cdad997a515a2521f27f9fd8acc792b2372'
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
