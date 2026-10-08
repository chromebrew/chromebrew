require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd55f1994789f7e5e60f5fef1ee62f16f5b84e6ebef27bafa52b59f348e11c32',
     armv7l: 'dd55f1994789f7e5e60f5fef1ee62f16f5b84e6ebef27bafa52b59f348e11c32',
       i686: 'e9af3308873b75e1968ba508f9849a31a73c492ec4fc27c127040dae8c4aaf18',
     x86_64: '8ebec129cef6b711c92a43f4d263b7402a37108a75f1a820e0a8b243b1324c0c'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'py3_flit_core'
  depends_on 'python3' => :logical

  no_source_build
end
