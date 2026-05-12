# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.13.3-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '86fa2317436cdb71d727b2d4741aaece1fefc9626832526f3db61426231907b8',
     armv7l: '86fa2317436cdb71d727b2d4741aaece1fefc9626832526f3db61426231907b8',
       i686: 'daf6ccf140953c0232138e364283b032660bc67afb0ba656ea2f4921b90c8414',
     x86_64: 'b0c389e4b935b67e594333862fedac9a092ab6df5ac819fa1df470c92d3233d0'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'python3' => :executable
  depends_on 'python3' => :logical
  depends_on 'rust'
end
