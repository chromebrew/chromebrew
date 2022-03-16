require 'package'

class Perl_locale_gettext < Package
  description 'Locale::gettext - message handling functions'
  homepage 'https://metacpan.org/pod/Locale::gettext'
  license 'GPL-1+ or Artistic'
  version '1.07-3'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/P/PV/PVANDRY/gettext-1.07.tar.gz'
  source_sha256 '909d47954697e7c04218f972915b787bd1244d75e3bd01620bc167d5bbc49c15'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-3_i686/perl_locale_gettext-1.07-3-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-3_x86_64/perl_locale_gettext-1.07-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'fef52c8881d250360e06e2620acc4973fdd383ca0ec033d1c43d487368256c38',
  x86_64: 'fed7d57b687fc8ec6b3705f85bed9fe510404f847207de4208e3886d3741e238'
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
