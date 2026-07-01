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
    aarch64: 'e6210da83771b9f51f581f77746a98502965fa3c6ebaa51656503a2f67103370',
     armv7l: 'e6210da83771b9f51f581f77746a98502965fa3c6ebaa51656503a2f67103370',
       i686: '300217bb737958c4da7d8aa93597e70d002ee7e28794b7e57d67dc4494a954a5',
     x86_64: '1d19c4a3217210de647f751fe27c9788657c57106e1b4dffcfca108141243e8e'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
end
