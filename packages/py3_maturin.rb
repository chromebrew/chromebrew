# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.14.0-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdd79c540588db6b43c6a1f0f4122a5fb3e7b2ab3988ae155127016907a37540',
     armv7l: 'cdd79c540588db6b43c6a1f0f4122a5fb3e7b2ab3988ae155127016907a37540',
       i686: 'b4921fd5bcd87fdba869a264deb5446dd3631d4024e1f1922d35f710acd73b46',
     x86_64: '28247336ced918a06acd92f11b72e63a882dfeac0c8e754b6f8609bc458069b0'
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
