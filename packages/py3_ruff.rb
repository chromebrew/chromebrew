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
       i686: 'fd50f7ecd6668123f2a103d1c7e05cd5f58bb481cfa413ddfa56b7ae5ddb3512',
     x86_64: '1e2abb4d756268314a6b21a4c736026d431b88c779965597d84eb136fdc2c6d4'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
