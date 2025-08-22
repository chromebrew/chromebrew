require 'buildsystems/autotools'

class Xorg_macros < Autotools
  description 'GNU autoconf macros shared across X.Org projects'
  homepage 'https://gitlab.freedesktop.org/xorg/util/macros'
  version '1.20.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/util/macros.git'
  git_hashtag "util-macros-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b13fa6adacf10c308178a81443257f73b17102fb4bc8e84f1c4b0d4d4ec418ae',
     armv7l: 'b13fa6adacf10c308178a81443257f73b17102fb4bc8e84f1c4b0d4d4ec418ae',
       i686: '34bbf333454e4b65794316ca93d5a80fff52170049f7a91c88a2870a4688481d',
     x86_64: '376b3c9723460ddc0707d12e171bd948aa2723184dc8849bfee638bd29b12cc2'
  })
end
