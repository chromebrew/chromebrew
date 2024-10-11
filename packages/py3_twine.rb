# Twine 5.1.1 currently breaks on some uploads.
# Install twine from https://github.com/pypa/twine/pull/1123 instead.
require 'buildsystems/pip'

class Py3_twine < Pip
  description 'A utility for interacting with PyPI'
  homepage 'https://pypi.python.org/pypi/twine'
  version "5.1.2.dev26+gc577765-#{CREW_PY_VER}"
  license 'APACHE'
  compatibility 'all'
  source_url 'https://github.com/pypa/twine.git@bugfix/1116-pkginfo-warnings'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7630a3f553f6c9fd2701e383774f66d35accac4ce743c1dd7eaa4f30d3c1b2af',
     armv7l: '7630a3f553f6c9fd2701e383774f66d35accac4ce743c1dd7eaa4f30d3c1b2af',
       i686: '2240d133df220b5d710bab65933bd64a4b22a00c29a7500dc601d321ffcdb076',
     x86_64: '28775f5e96a5975aa6c23d6d4f4f3723adef74b29e16c6d9f91e55bf994450b7'
  })

  depends_on 'py3_setuptools'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
  prerelease
end
