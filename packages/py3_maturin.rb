# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.12.6-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6bd4e028d30af59c805460e3777037313e0e74766b7430241d5702176605c4ee',
     armv7l: '6bd4e028d30af59c805460e3777037313e0e74766b7430241d5702176605c4ee',
       i686: '16209d1dd2950751995176fbdfbd55928dc651d88e9ce5543136388ae51ec2c3',
     x86_64: '98479f257ea00fd286aaf66927243322f64dafb4dc0ee7576bf0bb0f2da4a819'
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
