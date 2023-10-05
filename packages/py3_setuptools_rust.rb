require 'buildsystems/pip'

class Py3_setuptools_rust < Pip
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust'
  @_ver = '1.7.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.7.0-py3.12_armv7l/py3_setuptools_rust-1.7.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.7.0-py3.12_armv7l/py3_setuptools_rust-1.7.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.7.0-py3.12_i686/py3_setuptools_rust-1.7.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.7.0-py3.12_x86_64/py3_setuptools_rust-1.7.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5ab3e71c6289d2db9538bb2522f032d7beb22b861a894c22d44ed80e365c3c05',
     armv7l: '5ab3e71c6289d2db9538bb2522f032d7beb22b861a894c22d44ed80e365c3c05',
       i686: '9faef0a822d15be394cb058943cd6d25c3882acbdc9dfd02d233d4f88ce2ad4f',
     x86_64: '5047617d98212cb43a68e3f1facd0fc72fd8783d8effb4f60c8abf860e6badd0'
  })

  depends_on 'rust'
  depends_on 'py3_semantic_version'
  depends_on 'python3'
  depends_on 'py3_setuptools_scm' => :build
  depends_on 'py3_typing_extensions' => :build
end
