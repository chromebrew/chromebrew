require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdf451209124a36c978246d88435031de33294f04e28b0d609817b5480c6bbc8',
     armv7l: 'cdf451209124a36c978246d88435031de33294f04e28b0d609817b5480c6bbc8',
       i686: 'e7f6b4c940e09408d2cd6114b458c6d30bcb6914db53668572beedbe0feb9db4',
     x86_64: '26290fc0583d5f520535e805a1a120bf9cc4b12ece1c64db2ede1d811bd0147b'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'
  depends_on 'glibc' # R

  no_source_build
end
