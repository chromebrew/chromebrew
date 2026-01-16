require 'buildsystems/pip'

class Py3_meson_python < Pip
  description 'Meson Python build backend (PEP 517)'
  homepage 'https://pypi.org/project/meson-python'
  version "0.19.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'beac1fa2a8b610db8d612dce94660df4d447c912e0f1d736ad4c8bf5020aec66',
     armv7l: 'beac1fa2a8b610db8d612dce94660df4d447c912e0f1d736ad4c8bf5020aec66',
       i686: '21ebc041ba3c9dd85a40efb05912e6487c0731f765dd306ff1331c8aa152fe9b',
     x86_64: 'b360aca5192208ca089faedb94bfb3ce530eab834a6da1f9eb261c4e9368d213'
  })

  depends_on 'python3'

  no_source_build
end
