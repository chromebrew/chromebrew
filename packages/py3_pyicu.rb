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
    aarch64: '7e140e2443be5a29f3498eefad7c41d55dd09038cb32ed8f5ed801f83301352a',
     armv7l: '7e140e2443be5a29f3498eefad7c41d55dd09038cb32ed8f5ed801f83301352a',
       i686: '9ea33b141b9da951d9784f91812f37c0d461b6f2695262aef49825596367aa75',
     x86_64: '74612c26075fde8fb8db8ab400768979c4350c0b3f889b6cfdc2a9dbdb46966d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'python3' # R

  no_source_build
end
