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
    aarch64: '5b4216c688df8aaa90b6522aacea6d954cfc66ce3cce84a0cd2e538def855b1e',
     armv7l: '5b4216c688df8aaa90b6522aacea6d954cfc66ce3cce84a0cd2e538def855b1e',
       i686: 'f2e9743113677940a5fdfed69d917276832a5cfef89f2e0050e94bc7c5655e92',
     x86_64: '0361f5bdeccfbf2a6694ea1cf6d6b8d2b44036b8ec181fb0dd41c4d06f1012cc'
  })

  depends_on 'py3_setuptools'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
  prerelease
end
