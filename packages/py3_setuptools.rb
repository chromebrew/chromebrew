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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/68.2.2-py3.12_armv7l/py3_setuptools-68.2.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/68.2.2-py3.12_armv7l/py3_setuptools-68.2.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/68.2.2-py3.12_i686/py3_setuptools-68.2.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/68.2.2-py3.12_x86_64/py3_setuptools-68.2.2-py3.12-chromeos-x86_64.tar.zst'
  })
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
