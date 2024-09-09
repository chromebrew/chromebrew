require 'buildsystems/pip'

class Py3_setuptools_rust < Pip
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust'
  version '1.10.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2276465669c094472911ae9ddbc3c571aa1a11758156fc3b6761900d8e09c6d',
     armv7l: 'a2276465669c094472911ae9ddbc3c571aa1a11758156fc3b6761900d8e09c6d',
       i686: '5fc04e2e18f47c0e838ec3f7364855116d2de15482f0ac1c410eeede08d7bd9c',
     x86_64: '952b75c25e84015b64fb0c68bc3d0af5a863b61e9693e7f7a11908bc6cfeeb37'
  })

  depends_on 'rust'
  depends_on 'py3_setuptools_scm' => :build
  depends_on 'py3_typing_extensions' => :build
  depends_on 'python3'

  no_source_build
end
