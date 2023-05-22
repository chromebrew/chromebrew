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
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_csv/2.02-perl5.36_i686/perl_text_csv-2.02-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_csv/2.02-perl5.36_x86_64/perl_text_csv-2.02-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '8428258149269a1bf6079bb9cf0f5731c71ee83fc38a6a708351559728b642f9',
  x86_64: 'd7563c2942c6f0303f916fec70d8468f3b8436a50943bd06eabfb6216d1a3ea5'
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
