require 'buildsystems/pip'

class Py3_pyicu < Pip
  description 'PyICU is a Python extension wrapping the ICU C++ API.'
  homepage 'https://pyicu.org/'
  version "2.16.1-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a91f66933dea6aed9200293759602d56a6bc31396adc9f963e5772c3cee9872',
     armv7l: '0a91f66933dea6aed9200293759602d56a6bc31396adc9f963e5772c3cee9872',
       i686: '876ea596977a3d721583d200be27be308926e278e293c4bef6bdc26b537d1331',
     x86_64: 'a1cabe5fb45e5ced367baaf4da9108805eb6ff04b37444734d4d2e14a186e3ed'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'llvm_dev' => :build
  depends_on 'python3' # R

  no_source_build
end
