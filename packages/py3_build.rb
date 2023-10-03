require 'buildsystems/python'

class Py3_build < Python
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  @_ver = '1.0.3'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/build.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/1.0.3-py3.12_armv7l/py3_build-1.0.3-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/1.0.3-py3.12_armv7l/py3_build-1.0.3-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/1.0.3-py3.12_i686/py3_build-1.0.3-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/1.0.3-py3.12_x86_64/py3_build-1.0.3-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a3fbfa57db5c957f26fc6c879ea39ee452a77d7981b15d7de033fbf1cd724692',
     armv7l: 'a3fbfa57db5c957f26fc6c879ea39ee452a77d7981b15d7de033fbf1cd724692',
       i686: '65546ab271d228ab507331af7d28d4e3a3a33156a7911c554ede710d33133e80',
     x86_64: '97ec2a5122b7190284d2c1c4ef5e7907a5162b0bf513f1cd6d42630f070addf3'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'
end
