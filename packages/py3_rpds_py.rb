# Adapted from Arch Linux python-rpds-py PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-rpds-py/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_rpds_py < Pip
  description 'Python bindings to the Rust rpds crate for persistent data structures'
  homepage 'https://github.com/crate-py/rpds'
  version '2026.5.1'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0deb8774da4548c4b10ba811fe0e423b2260578be523c0e1dccf1e932eb4b577',
     armv7l: '0deb8774da4548c4b10ba811fe0e423b2260578be523c0e1dccf1e932eb4b577',
       i686: '3049e4b3fd211d34070ff670eb255ec6fa38e7bc0fc2fbe9bd0a8f8e31b893b0',
     x86_64: 'ad51a98eb84f5a19f250270e55b35c2027c7c11bee45adbb48b5dddfdd5b87e8'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
