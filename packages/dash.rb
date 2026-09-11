require 'buildsystems/autotools'

class Dash < Autotools
  description 'The Debian Almquist Shell (dash) is a POSIX-compliant shell derived from ash that executes scripts faster than bash and has fewer library dependencies.'
  homepage 'https://salsa.debian.org/debian/dash/'
  version '0.5.13.5'
  license 'BSD'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/utils/dash/dash.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a9afd1b141790a308f022e80f8aef0cbe0c96d0303f0c689d33bebc1513bc39',
     armv7l: '9a9afd1b141790a308f022e80f8aef0cbe0c96d0303f0c689d33bebc1513bc39',
       i686: '199c06d51f19292315a790c0470d3f493bd4159f30d9341fe0a919c3d8b0e138',
     x86_64: 'e2d601df37cc360fe4f4b324f636780424f9c9a4e17624f8900de7368a4ec4d9'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libedit' => :executable

  autotools_configure_options '--with-libedit'

  run_tests
end
