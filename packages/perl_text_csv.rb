require 'package'

class Perl_text_csv < Package
  description 'Comma-separated values manipulator (using XS or PurePerl)'
  homepage 'https://metacpan.org/pod/Text::CSV'
  version '2.04-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/Text-CSV-2.04.tar.gz'
  source_sha256 '4f80122e4ea0b05079cad493e386564030f18c8d7b1f9af561df86985a653fe3'
  binary_compression 'tar.zst'

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
