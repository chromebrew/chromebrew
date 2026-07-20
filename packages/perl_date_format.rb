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
    aarch64: 'c0eeb5529764b0f77caff46e75f241005565c0b4f40cfafa5770d457f3b886f3',
     armv7l: 'c0eeb5529764b0f77caff46e75f241005565c0b4f40cfafa5770d457f3b886f3',
       i686: 'df6797645682a08fceac17eb31961cc1e3b79596087d6b262dd2e454103ffe38',
     x86_64: '0e28216e43b5cef00a1aa855c95b6ec74fc0728b210eddfbf1e42abed2f3dc1c'
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
