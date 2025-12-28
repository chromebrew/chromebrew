require 'buildsystems/pip'

class Py3_pdfminer_six < Pip
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  version "20251227-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b7ed9ec91c763584349677b0851a1dde31d8086bbeae076f01ffbc2e479bab3',
     armv7l: '4b7ed9ec91c763584349677b0851a1dde31d8086bbeae076f01ffbc2e479bab3',
       i686: 'd42ede251cdd464c0e746b27f2b7c9e9f2ebca7ca26aba5312d94cafce4258ee',
     x86_64: 'b97303fdf56df7b89828594aca3681bbb75eed000360b1a5ceb79787004d1da6'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  no_source_build
end
