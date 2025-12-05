require 'buildsystems/pip'

class Py3_twine < Pip
  description 'A utility for interacting with PyPI'
  homepage 'https://pypi.python.org/pypi/twine'
  version "6.2.0-#{CREW_PY_VER}"
  license 'APACHE'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8af47fafc774e234b6bb6c2849b2fea5bb363dce9b5b9c281df2e9e6faf27b5',
     armv7l: 'd8af47fafc774e234b6bb6c2849b2fea5bb363dce9b5b9c281df2e9e6faf27b5',
       i686: '7f856334a6eadc87ad0f50453ee69beac1f57c746e41262a5e652ac2b8d76632',
     x86_64: 'c96395c791a54d9b5aeae94fef798393f91e6bff6f25549e0bfdebae8fac8a98'
  })

  depends_on 'py3_certifi'
  depends_on 'py3_id'
  depends_on 'py3_keyring'
  depends_on 'py3_readme_renderer'
  depends_on 'py3_requests'
  depends_on 'py3_requests_toolbelt'
  depends_on 'py3_rfc3986'
  depends_on 'py3_rich'
  depends_on 'py3_setuptools'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
