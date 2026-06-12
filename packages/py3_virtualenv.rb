require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.4.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c38cc003954b0ec3e63139ff3ad108a98178568c3753ef74fe5bc8810de728d6',
     armv7l: 'c38cc003954b0ec3e63139ff3ad108a98178568c3753ef74fe5bc8810de728d6',
       i686: 'ff5433f95935fcae0663d8d70aec3782ce62cdf0cb41e541e3c9ad5264da982d',
     x86_64: '5ae660dc7c4be8f85f9206051f921012a4b6ab7a1142fb77f7b7bf4e765391ad'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
