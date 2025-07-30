require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.7-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7e40844fd1f5514ed6804f8effb0aad6a4f9ca085e9b11e35408bf5af507cc2',
     armv7l: 'a7e40844fd1f5514ed6804f8effb0aad6a4f9ca085e9b11e35408bf5af507cc2',
       i686: '516cf3f90d63ebaf5d775c12098101b81f461b4c4c2fb252edcd3c00a55ebd95',
     x86_64: '6b78198abd7190434e1555bf735c49297902311079e9e21643b90abc5c1becb0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build

  no_source_build
end
