# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.11.4-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f72901b5d79ce3ca913fc1e386e006cfa2cb4b2d577a6c3effde557f0ceb50e2',
     armv7l: 'f72901b5d79ce3ca913fc1e386e006cfa2cb4b2d577a6c3effde557f0ceb50e2',
       i686: 'fa360b95f3589d16e4da960b7efc4ce3814517ee756fbdf3e0b85df180a57fc6',
     x86_64: 'ca0a7705affd92c0c59acdd3d390d98926c83d67ab73aa4a905bc95bdda705e0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
