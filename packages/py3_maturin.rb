# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.11.2-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '688b0d8c07c3c733e4a3693d1bcdd2fa8da1cd8f29a45b49791053967a9fc62a',
     armv7l: '688b0d8c07c3c733e4a3693d1bcdd2fa8da1cd8f29a45b49791053967a9fc62a',
       i686: '253bc3de2da6686ac32c09dcea552f4f64d832078997322bfec62f5bcf6100c9',
     x86_64: '92a451f25cc7fecca4a5310828e5dafed324f1c4eaa5e292a944b5596b56830e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
