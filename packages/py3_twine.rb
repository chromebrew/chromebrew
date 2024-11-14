# Twine 5.1.1 currently breaks on some uploads.
# Install twine from https://github.com/pypa/twine/pull/1123 instead.
require 'buildsystems/pip'

class Py3_twine < Pip
  description 'A utility for interacting with PyPI'
  homepage 'https://pypi.python.org/pypi/twine'
  version "5.1.2.dev32+gd53a8a6-#{CREW_PY_VER}"
  license 'APACHE'
  compatibility 'all'
  source_url 'https://github.com/pypa/twine.git@bugfix/1116-pkginfo-warnings'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e7b5889ae113d3773c37c88b4a613db5bc890c72ce9675c8d7d17a11a315ee5',
     armv7l: '6e7b5889ae113d3773c37c88b4a613db5bc890c72ce9675c8d7d17a11a315ee5',
       i686: 'ab757fa629e962d0770c343e1984375cbf501b127235b0580f24e52322a7d3ef',
     x86_64: '0383384d726bb8268befb77fae5b9a8bcdb670ba9ea85d72526879f320488a63'
  })

  depends_on 'py3_setuptools'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
  prerelease
end
