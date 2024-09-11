require 'buildsystems/pip'

class Py3_pyproject_hooks < Pip
  description 'This package contains wrappers to call hooks on build backends for pyproject.toml -based projects'
  homepage 'https://pyproject-hooks.readthedocs.io/'
  version '1.1.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77bfe04652ed2a2940c25b83633c497c376d5d4fdebcd201267464704e62580c',
     armv7l: '77bfe04652ed2a2940c25b83633c497c376d5d4fdebcd201267464704e62580c',
       i686: 'c33947873a0cd97c42e0c4e4d158b52fe77c57dafb4626f770104d64b5a280c4',
     x86_64: '501ce787ae83229071f823f75b754dcdbf7647de1ddc7809ddb965d081dffa78'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'

  no_source_build
end
