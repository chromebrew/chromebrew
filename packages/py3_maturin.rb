# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.12.2-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38632366b25d2959de60a1200ca75348cb615e5c381b863c36bcff739066ed82',
     armv7l: '38632366b25d2959de60a1200ca75348cb615e5c381b863c36bcff739066ed82',
       i686: '43bc2334bfb05cee5f6ec43025dc8d00b38afeaea73d07ccda56de7fe2751a05',
     x86_64: 'bcd3af9796f6d8d4ad83c6fa08e1a019c7212f1ae90292926af51670fbdd7c16'
  })

  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'python3' => :executable_only
  depends_on 'rust'
end
