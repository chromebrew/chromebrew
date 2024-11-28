require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "44.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5236c482abe4067ebbb1e0bdc71ffef34b4e26206fd13a35986812210bb362ba',
     armv7l: '5236c482abe4067ebbb1e0bdc71ffef34b4e26206fd13a35986812210bb362ba',
       i686: 'cbaadc230213d01d74a747274a94746811a45aa8fd27a5148e43defa95d37b1e',
     x86_64: '184e30a964cee8123b5db9175fef636cf4a3ca7cd25e3662ff2893867b434a20'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'rust' => :build

  no_source_build
end
