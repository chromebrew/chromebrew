# Adapted from Arch Linux python-rpds-py PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-rpds-py/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_rpds_py < Pip
  description 'Python bindings to the Rust rpds crate for persistent data structures'
  homepage 'https://github.com/crate-py/rpds'
  version '2026.9.1'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c7e2c6e27a1856690b894bcab6554b0f6d3e4e2fb0466f313a0bab4b28dacc1',
     armv7l: '5c7e2c6e27a1856690b894bcab6554b0f6d3e4e2fb0466f313a0bab4b28dacc1',
       i686: '82029550a46607a6e6372bb2535a59954d9cb3905e4cba51c447ae9e160df83a',
     x86_64: '53900c688cfd6e0c1f9a9c8e935ce845371ef6cec285bc2cf8c22c46d4c08c0c'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
