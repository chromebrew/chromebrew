require 'buildsystems/cmake'

class Openexr < CMake
  description 'OpenEXR is a high dynamic-range (HDR) image file format developed by Industrial Light & Magic for use in computer imaging applications.'
  homepage 'http://www.openexr.com/'
  version '3.2.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v3.2.1.tar.gz'
  source_sha256 '61e175aa2203399fb3c8c2288752fbea3c2637680d50b6e306ea5f8ffdd46a9b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '790cd3fba4398fea18376924db32bbe58c547ebf652ab7d9cb029b4772e83602',
     armv7l: '790cd3fba4398fea18376924db32bbe58c547ebf652ab7d9cb029b4772e83602',
       i686: '1fa2bf8fa2709282fd43329ae05f14f261b4e021a49fd78fb0bc506a6cc4d433',
     x86_64: 'e11aa055cbace1b83b088aae1d68a95a44863df3a1276639f28838cab3e6977c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libdeflate' # R
end
