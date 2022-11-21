require 'package'

class Perl_uri < Package
  description 'Uniform Resource Identifiers (absolute and relative)'
  homepage 'https://metacpan.org/pod/URI'
  version '5.17'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/URI-5.17.tar.gz'
  source_sha256 '5f7e42b769cb27499113cfae4b786c37d49e7c7d32dbb469602cd808308568f8'

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
