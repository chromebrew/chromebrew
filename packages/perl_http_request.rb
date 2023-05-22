require 'package'

class Perl_http_request < Package
  description 'HTTP style request message'
  homepage 'https://metacpan.org/pod/HTTP::Request'
  version '6.44-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Message-6.44.tar.gz'
  source_sha256 '398b647bf45aa972f432ec0111f6617742ba32fc773c6612d21f64ab4eacbca1'

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
