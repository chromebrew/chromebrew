require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.1.7.14-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08c8b6a07b74a99e79350950225159f2886fc60879dde2e68b8b9747312705b2',
     armv7l: '08c8b6a07b74a99e79350950225159f2886fc60879dde2e68b8b9747312705b2',
       i686: '567893a6e19d2368fa292ab58677e22b06e79fdaa85fb22c3d5e5bf61e354548',
     x86_64: 'a4dbd1894af08431555b84c1be3f79a4c6545a1a45596527bff07d14794b704f'
  })

  depends_on 'python3' => :build

  no_source_build
end
