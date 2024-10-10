require 'buildsystems/pip'

class Py3_openpyxl < Pip
  description 'Openpyxl is a Python library to read/write Excel 2010 xlsx/xlsm files.'
  homepage 'https://openpyxl.readthedocs.io/'
  version "3.1.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a77c68631a7c2111e53cb7721081bcaf7a5cfe179f80966fd59588246bde724',
     armv7l: '2a77c68631a7c2111e53cb7721081bcaf7a5cfe179f80966fd59588246bde724',
       i686: '76c5fa33bcde46581395b57e18749835fac76c8d139559386bcd83d45c70a0d7',
     x86_64: '4d723c5456da0c06c7e8e8650ccb3f80102cf893b183ba8fa6be7c609135e736'
  })

  depends_on 'py3_et_xmlfile'
  depends_on 'python3' => :build

  no_source_build
end
