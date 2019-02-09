require 'package'

class Perl_parallel_forkmanager < Package
  description 'Parallel::ForkManager - A simple parallel processing fork manager'
  homepage 'https://metacpan.org/pod/Parallel::ForkManager'
  version '2.02'
  source_url 'https://cpan.metacpan.org/authors/id/Y/YA/YANICK/Parallel-ForkManager-2.02.tar.gz'
  source_sha256 'c1b2970a8bb666c3de7caac4a8f4dbcc043ab819bbc337692ec7bf27adae4404'

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
