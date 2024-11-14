require 'buildsystems/autotools'

class Stunnel < Autotools
  description "Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code."
  homepage 'https://www.stunnel.org/index.html'
  version '5.73'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://www.stunnel.org/downloads/stunnel-#{version}.tar.gz"
  source_sha256 'bc917c3bcd943a4d632360c067977a31e85e385f5f4845f69749bce88183cb38'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17ef99aef231bb24c69c9a4d82b1ea1b09477ba989aa6144ba1250e3bf9f07c3',
     armv7l: '17ef99aef231bb24c69c9a4d82b1ea1b09477ba989aa6144ba1250e3bf9f07c3',
       i686: 'fafe61e47d8d257e2d646dd9f5c2891280b0e7ebb369e2da55f1a05ae3901f3f',
     x86_64: 'b0c5f60c70d1463a4d19bb5642b999283ac6e83936ddfbc63f1dc15a59702942'
  })

  depends_on 'openssl'
end
