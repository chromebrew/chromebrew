require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version "2.15.2-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2bc9eff930898f207f45cc88eeb9dff8ac5c207455c607bfd9e6b21fa46105fb',
     armv7l: '2bc9eff930898f207f45cc88eeb9dff8ac5c207455c607bfd9e6b21fa46105fb',
       i686: 'f1dba9c7995ab0896b43fb922decea3d899750e3841b2a40b46916b74ae47309',
     x86_64: 'fb464855fa1cd7e067408b1c96a041894416b887fac1683fe8dc62af8ea00cde'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R

  no_source_build
end
