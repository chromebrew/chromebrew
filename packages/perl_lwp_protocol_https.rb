require 'package'

class Perl_lwp_protocol_https < Package
  description 'Provide https support for LWP::UserAgent'
  homepage 'https://metacpan.org/pod/LWP::Protocol::https'
  version '6.10-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/LWP-Protocol-https-6.10.tar.gz'
  source_sha256 'cecfc31fe2d4fc854cac47fce13d3a502e8fdfe60c5bc1c09535743185f2a86c'

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
