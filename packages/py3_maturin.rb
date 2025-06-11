# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.8.7-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e34eda2a7da489be82c6df2339a502fe42c4f16cd62ba188da0ba81dffa5e072',
     armv7l: 'e34eda2a7da489be82c6df2339a502fe42c4f16cd62ba188da0ba81dffa5e072',
       i686: '343adb0f7a99531619fd7424cad6cd70cbf865bac6f48f5d93f731130a40a57e',
     x86_64: '33c8a001fb8820f0facc137068ff8702c0c2b7f97de0e2350b184981dd7fa6d4'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
