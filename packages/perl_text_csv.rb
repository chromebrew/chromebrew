require 'package'

class Perl_text_csv < Package
  description 'Comma-separated values manipulator (using XS or PurePerl)'
  homepage 'https://metacpan.org/pod/Text::CSV'
  version '2.02-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/Text-CSV-2.02.tar.gz'
  source_sha256 '84120de3e10489ea8fbbb96411a340c32cafbe5cdff7dd9576b207081baa9d24'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_csv/2.02-perl5.36_armv7l/perl_text_csv-2.02-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_csv/2.02-perl5.36_armv7l/perl_text_csv-2.02-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_csv/2.02-perl5.36_i686/perl_text_csv-2.02-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_csv/2.02-perl5.36_x86_64/perl_text_csv-2.02-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b3791f8fd11680d25b2071392eb622ba25c1734ad3e8763de0838ffe884760b6',
     armv7l: 'b3791f8fd11680d25b2071392eb622ba25c1734ad3e8763de0838ffe884760b6',
       i686: 'a3c419980f73e6f9a1c62b20124a1d0accd765ed464646e38d8e1e186ea26271',
     x86_64: 'b25e40e39bec7d8f4eafec508f5a802f111de72a187e5668d531a507e7a49809'
  })

  no_compile_needed

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
