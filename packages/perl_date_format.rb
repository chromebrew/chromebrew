require 'package'

class Perl_date_format < Package
  description 'Date formatting subroutines'
  homepage 'https://metacpan.org/pod/Date::Format'
  version "2.33-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AT/ATOOMIC/TimeDate-2.33.tar.gz'
  source_sha256 'c0b69c4b039de6f501b0d9f13ec58c86b040c1f7e9b27ef249651c143d605eb2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6ec73c0f345b2a4ca4717a3556303186d296c41f6883df0571561383825ff9d',
     armv7l: 'd6ec73c0f345b2a4ca4717a3556303186d296c41f6883df0571561383825ff9d',
       i686: '40e897780576adb61f60dc4233b74d1a379afc0ef2cf525053b6412a75f77426',
     x86_64: '6e3d3486448140ccf77a8dcee0591275b46cf8cd0ca88bdb3d22a986f7286332'
  })

  conflicts_ok #  conflicts with perl_xml_parser

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # Conflict with perl_xml_parser package.
    # FileUtils.rm "#{CREW_PREFIX}/lib/perl5/site_perl/5.40.0/Date/Language/Amharic.pm"
  end
end
