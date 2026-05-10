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
    aarch64: '1aa3180f8f74204f86fee315fb524c096a42b2d0400fda78bcf190c9ce6724fa',
     armv7l: '1aa3180f8f74204f86fee315fb524c096a42b2d0400fda78bcf190c9ce6724fa',
       i686: '4f1f4d6990fe068b49e8e1889477720824a957fbcd1abdcef2e609430b03570e',
     x86_64: '686c8ec61d64864eb803bdb70be5e47acbc42e4dffc3bc26bec28f32419c4760'
  })

  depends_on 'py3_et_xmlfile'
  depends_on 'python3' => :logical

  no_source_build
end
