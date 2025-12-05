require 'buildsystems/pip'

class Py3_pyproject_hooks < Pip
  description 'This package contains wrappers to call hooks on build backends for pyproject.toml -based projects'
  homepage 'https://pyproject-hooks.readthedocs.io/'
  version "1.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba5fd74a421c6d656263a52412fdcb393cbf9928b34f0c9aaf906162b9d26d22',
     armv7l: 'ba5fd74a421c6d656263a52412fdcb393cbf9928b34f0c9aaf906162b9d26d22',
       i686: '3e06d4591b3a1d096435c9e25b704c4de9ffefb9a4ca7b85626c6889f8e5b819',
     x86_64: 'f5e37a3b3b889401440d7daf473deb3b5c1488315eaad5e54b0fbb64f102f096'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'

  no_source_build
end
