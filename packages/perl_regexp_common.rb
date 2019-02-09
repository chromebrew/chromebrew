require 'package'

class Perl_regexp_common < Package
  description 'Regexp::Common - Provide commonly requested regular expressions'
  homepage 'https://metacpan.org/pod/Regexp::Common'
  version '2017060201'
  source_url 'https://cpan.metacpan.org/authors/id/A/AB/ABIGAIL/Regexp-Common-2017060201.tar.gz'
  source_sha256 'ee07853aee06f310e040b6bf1a0199a18d81896d3219b9b35c9630d0eb69089b'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "yes | perl Makefile.PL PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
    system 'make'
  end

  def self.install
    system 'make', 'install'
  end
end
