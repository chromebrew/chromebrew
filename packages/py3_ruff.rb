require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.8.5-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9836b3f91766bac488af78cf8a81b12b0caadd3d2751258f32331c977954c0fd',
     armv7l: '9836b3f91766bac488af78cf8a81b12b0caadd3d2751258f32331c977954c0fd',
       i686: 'd74ba07b5de97fbe541df8b83d3023b4b882ab749bc8959a92f5fe1ab2e9649f',
     x86_64: '68c085533fed6bb9a0b9e93a42557599c9c51ca7209251d450770bac987c8ece'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
