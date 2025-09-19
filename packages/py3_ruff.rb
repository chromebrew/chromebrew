require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.13.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'beafe3fd4bf7ebd4a5f3a45364143e8a15225efc1b3d2a41a913378afb901870',
     armv7l: 'beafe3fd4bf7ebd4a5f3a45364143e8a15225efc1b3d2a41a913378afb901870',
       i686: 'bf19bd09c5ebb5aacf1acf6bfc28dd2dc57634b6f356326d9759578b988dec97',
     x86_64: '67cd4415abf78ecd104d84c2fe4447c337ebcf65d9f2a0b91f3f6f0f442830be'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
