require 'buildsystems/autotools'

class Editres < Autotools
  description 'Editres is a tool that allows users and application developers to view the full widget hierarchy of any Xt Toolkit application that speaks the Editres protocol.'
  homepage 'https://www.x.org/wiki/'
  version '1.1.1'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://x.org/archive/individual/app/editres-#{version}.tar.xz"
  source_sha256 'e0a29b2f5e178362f71950c45ec49b43ccc75cacf44356948377e71cdfee119b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '055f1e4ac9ccc05d918abe12f6d8159c5f16dbb17701293fc9e6ce33afacda98',
     armv7l: '055f1e4ac9ccc05d918abe12f6d8159c5f16dbb17701293fc9e6ce33afacda98',
     x86_64: 'b4d64fdf5d723ae9dcb19ec69a6f9372664d12ba4b5969d7b42462886aa6ab25'
  })

  depends_on 'glibc' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxaw' => :executable
  depends_on 'libxkbfile' => :executable
  depends_on 'libxmu' => :executable
  depends_on 'libxt' => :executable
  depends_on 'xorg_proto' => :executable

  run_tests
end
