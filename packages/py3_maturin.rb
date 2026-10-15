# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.15.0-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5708a45a5ed14f1cda7518842af1b7adf263d4f4a9542d53453788fe5a8fd90',
     armv7l: 'c5708a45a5ed14f1cda7518842af1b7adf263d4f4a9542d53453788fe5a8fd90',
       i686: 'a238f5c22cd5997cb3de05e99563eecb5f182c5103a526496a006e9fc69157cc',
     x86_64: 'd79d1746b398fc38676cae51334c32d74da2cd7deba6136bc91ec2cadee1eb6d'
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
