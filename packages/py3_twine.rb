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
    aarch64: '88d5221118b3e99f26641c6bfd7bacfe70560581ffc334d9a80dfff6e6b831da',
     armv7l: '88d5221118b3e99f26641c6bfd7bacfe70560581ffc334d9a80dfff6e6b831da',
       i686: '6deda0090ed750c2a6d4e253e4c6068d78c2a1bc39376e7d3171c6125efe9dae',
     x86_64: 'e2b9d778632deb60fd90d55c02798d1bd97c75c165e54132a0b54774c187c57d'
  })

  depends_on 'py3_certifi'
  depends_on 'py3_readme_renderer'
  depends_on 'py3_requests'
  depends_on 'py3_rich'
  depends_on 'py3_setuptools'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
