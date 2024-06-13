require 'package'

class Perl_http_request < Package
  description 'HTTP style request message'
  homepage 'https://metacpan.org/pod/HTTP::Request'
  version '6.46-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Message-6.46.tar.gz'
  source_sha256 'e27443434150d2d1259bb1e5c964429f61559b0ae34b5713090481994936e2a5'
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
