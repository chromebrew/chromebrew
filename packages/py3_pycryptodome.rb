require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "4.4.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f3f8c94016573923ee1de3417e4a76b68ee3df54d60cb50604a705d0dcec46b',
     armv7l: '5f3f8c94016573923ee1de3417e4a76b68ee3df54d60cb50604a705d0dcec46b',
       i686: 'afa8e17a4b5cecf4a6a24d31818c914610e20280e059aba7b52dde27dc6a54b1',
     x86_64: '7af8314fe8f8c2f8fa314e56476a00f61fc43bbdc202b03e43d9fad0647bda8b'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
