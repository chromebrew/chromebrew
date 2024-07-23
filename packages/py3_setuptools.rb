require 'buildsystems/python'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '68.2.2'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '129be5a5aee22967b1dedefc5def6f8d55dad13c52298c19f1aa42915c152937',
     armv7l: '129be5a5aee22967b1dedefc5def6f8d55dad13c52298c19f1aa42915c152937',
       i686: '946c19613522184203f826635982a84bc0bffc2e5cabe8fc107ff3e6af9d4fd2',
     x86_64: '570386fa604d41e530902c684e7b9950452fcea39d237cef6bccdbacea9f1c01'
  })

  depends_on 'python3', '< 3.13.0'
  depends_on 'py3_packaging'

  conflicts_ok
end
