require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.9.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d25b4fb2ede7966b1efbbd8fe1fb650a1ad745f645613edef9058c2a3bd63a6',
     armv7l: '1d25b4fb2ede7966b1efbbd8fe1fb650a1ad745f645613edef9058c2a3bd63a6',
       i686: '99a2078bf0a6374face9e1261db687f2ff5e3450401d8257b71a9e32d5668df5',
     x86_64: '9236a6f86061f007bd2380b8dbc3bca6903ed7dc1a4ff079f33adb0808b704db'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
