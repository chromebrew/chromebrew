require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.8.4-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce014ef198a763f7a65f2b6519bd5f7781ad5f36d01424563da7ab9cafca4da5',
     armv7l: 'ce014ef198a763f7a65f2b6519bd5f7781ad5f36d01424563da7ab9cafca4da5',
       i686: 'd74ba07b5de97fbe541df8b83d3023b4b882ab749bc8959a92f5fe1ab2e9649f',
     x86_64: 'eda6a029bd7bee80c93376738552f68b025275ac61f4ba4b13229f6271c9d9c6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
