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
    aarch64: '15f572df584acbeeb037b3972efb05b61f50e595b6e22fd915b1d4ce63df0678',
     armv7l: '15f572df584acbeeb037b3972efb05b61f50e595b6e22fd915b1d4ce63df0678',
       i686: '4013756ae0a7f52972b10ca0f55f54fae5dd43ee777382855a3bf5acba4a944f',
     x86_64: 'c61f4ee459e26f7c8bc8f28568a2d17814e87474d2a1e189c48a55313af773a0'
  })

  depends_on 'perl' => :logical
  depends_on 'perl_io_pty' => :library
end
