# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.16.0-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0364da3273b66ae817e83530e2a194cc9de7393444c9895cbf8b81fa8cef1bc',
     armv7l: 'e0364da3273b66ae817e83530e2a194cc9de7393444c9895cbf8b81fa8cef1bc',
       i686: 'de41110c9a7a17e31951c6566087fb2142b62e6f9d48744d0a54f8c51984fe6a',
     x86_64: '67e497747adf41cc56124e7b7d13cc0a5012d1162e6cb2bdbde683455b3fe81b'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'python3' => :executable
  depends_on 'python3' => :logical
  depends_on 'rust'

  def self.postinstall
    ExitMessage.add "\nType 'maturin' to get started.\n"
  end
end
