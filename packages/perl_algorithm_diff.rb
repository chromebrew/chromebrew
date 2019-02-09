require 'package'

class Perl_algorithm_diff < Package
  description 'Algorithm::Diff - Compute `intelligent\' differences between two files / lists'
  homepage 'https://metacpan.org/pod/Algorithm::Diff'
  version '1.1903'
  source_url 'https://cpan.metacpan.org/authors/id/T/TY/TYEMQ/Algorithm-Diff-1.1903.tar.gz'
  source_sha256 '30e84ac4b31d40b66293f7b1221331c5a50561a39d580d85004d9c1fff991751'

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
