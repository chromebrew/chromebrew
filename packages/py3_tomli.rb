require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed94e24db2cbf20909e45940de4a91575418ff7e9d2fd410dd73a66225eeea87',
     armv7l: 'ed94e24db2cbf20909e45940de4a91575418ff7e9d2fd410dd73a66225eeea87',
       i686: '52ee0c7aac555493d4aa55ad43aea7e6aae697c68c4309ccf870faaf3dfdbc58',
     x86_64: '32a3d44a5b0ebc95ebcfcbb6c2c5287a7e0cb1ea468e8a4122daa67d0701165a'
  })

  depends_on 'glibc' => :library
  depends_on 'py3_flit_core'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
