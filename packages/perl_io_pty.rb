require 'buildsystems/perl'

class Perl_io_pty < PERL
  description 'Pseudo TTY object class'
  homepage 'https://metacpan.org/pod/IO::Pty'
  version "1.31-#{CREW_PERL_VER}"
  license 'perl_5'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/T/TO/TODDR/IO-Tty-#{version.split('-')[0]}.tar.gz"
  source_sha256 'df8b5143d9a7de99c47b55f1a170bd1f69f711935c186a6dc0ab56dd05758e35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95b438d4b9aa7660056886b9a8278e08dfbf0bdfa8ccf685c0887974d7b965df',
     armv7l: '95b438d4b9aa7660056886b9a8278e08dfbf0bdfa8ccf685c0887974d7b965df',
       i686: 'cc2afd8a967fa6f711a21dbf5ee3309ce090b0e4a3af0501aa07710be72a92a1',
     x86_64: 'a2e027fbffb345f1ca530076e910f7fc27ffb8ae188fb5f3e4610c059a71f977'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
end
