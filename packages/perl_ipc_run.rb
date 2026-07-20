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
    aarch64: 'c21c5403de81682e4265dea3d408acc6abaeba7a71960fe50083beac4829203d',
     armv7l: 'c21c5403de81682e4265dea3d408acc6abaeba7a71960fe50083beac4829203d',
       i686: '286185e92f46574798bb3167a6d57b003496ae327969eabdf75654b5834091fe',
     x86_64: 'c61f4ee459e26f7c8bc8f28568a2d17814e87474d2a1e189c48a55313af773a0'
  })

  depends_on 'perl' => :logical
  depends_on 'perl_io_pty' => :library
end
