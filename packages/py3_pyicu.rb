require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version "2.13.1-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c0202aeeceddeb01645077b909b4fe26e227974f55f13bc12f509aaa60e526b',
     armv7l: '6c0202aeeceddeb01645077b909b4fe26e227974f55f13bc12f509aaa60e526b',
       i686: '340d3f6151c3f1237ad9b51b864d35674a004cbf24ab595d14c1f6d4332457aa',
     x86_64: '7f9fdbb623860def22fb63647624121bbfad80d7985ef58277e10092c429a155'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibc_lib' # R
  depends_on 'icu4c' # R

  no_source_build
end
