require 'package'

class Perl_extutils_makemaker < Package
  description 'Create a module Makefile'
  homepage 'https://metacpan.org/pod/ExtUtils::MakeMaker'
  version '7.70-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/B/BI/BINGOS/ExtUtils-MakeMaker-7.70.tar.gz'
  source_sha256 'f108bd46420d2f00d242825f865b0f68851084924924f92261d684c49e3e7a74'

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
    # Remove conflicts with perl package.
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/instmodsh"
    FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man1/instmodsh.1"
  end
end
