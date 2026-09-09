require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a703f208069de5d2bcf2d3785ef3458d230973420b5688546b46a4abbc04b151',
     armv7l: 'a703f208069de5d2bcf2d3785ef3458d230973420b5688546b46a4abbc04b151',
       i686: '3f1736b3cdb8a30935b80a91c0b2238dee5690ba9904d7e8531e2ff65a61aa0f',
     x86_64: 'd9239bc94ac2d47e9f442ae78067007d0665c92029f530721134096e5353bd76'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
