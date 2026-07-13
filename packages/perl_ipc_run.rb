require 'buildsystems/perl'

class Perl_ipc_run < PERL
  description 'system() and background procs w/ piping, redirs, ptys (Unix, Win32)'
  homepage 'https://metacpan.org/dist/IPC-Run'
  version "20260402.0-#{CREW_PERL_VER}"
  license 'perl_5'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/T/TO/TODDR/IPC-Run-#{version.split('-')[0]}.tar.gz"
  source_sha256 'df8b5143d9a7de99c47b55f1a170bd1f69f711935c186a6dc0ab56dd05758e35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02316ca0164dd85ac8779510bbaaa68db371eafa29907d03ac157a1f0dd7a843',
     armv7l: '02316ca0164dd85ac8779510bbaaa68db371eafa29907d03ac157a1f0dd7a843',
       i686: '386930aa83897116f7fee97616fb01876dffa449044d141249da55eead5304d3',
     x86_64: '03435fb8e2923c62e1187919f0274f0372c340275df0fed5aa7fbc21c2b1de0c'
  })

  depends_on 'perl' => :logical
  depends_on 'perl_io_pty' => :library
end
