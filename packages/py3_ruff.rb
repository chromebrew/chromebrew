require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.11-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd50d2e1aa60b66e37734eb5f890995dc824a3831ac686996201011ad715749ba',
     armv7l: 'd50d2e1aa60b66e37734eb5f890995dc824a3831ac686996201011ad715749ba',
       i686: 'e89ae0fd22f77a85a59b091804d1c67799fb682f5a59533a4e4a055b90d735b3',
     x86_64: '36df885fd7b4385220fe35ebf0f754a3e96651c0b4afb41b501cf98e8ac8a2b7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build

  no_source_build
end
