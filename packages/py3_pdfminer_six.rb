require 'buildsystems/pip'

class Py3_pdfminer_six < Pip
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  version "20240706-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9cbb338cdbed9b99eb12b7283b0fe43e65f9f643f9ea05a2b77b129d6fcba66c',
     armv7l: '9cbb338cdbed9b99eb12b7283b0fe43e65f9f643f9ea05a2b77b129d6fcba66c',
       i686: '504e7a8362bda6a387063b2cffc5724dca443bfec7bdc8fc7f3ddba66eb95aae',
     x86_64: '2ed656bcbc3aa8c3cb6b6fc09a30656982809b76c919a0e4eda6311e5a7ad7be'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  no_source_build
end
