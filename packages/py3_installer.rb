require 'buildsystems/python'

class Py3_installer < Python
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  @_ver = '0.7.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/installer.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.7.0-py3.12_armv7l/py3_installer-0.7.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.7.0-py3.12_armv7l/py3_installer-0.7.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.7.0-py3.12_i686/py3_installer-0.7.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.7.0-py3.12_x86_64/py3_installer-0.7.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4f302c9f93e2c68f69f59006fbc25bfda1928b0c56b11bed14842bdd5a3884a0',
     armv7l: '4f302c9f93e2c68f69f59006fbc25bfda1928b0c56b11bed14842bdd5a3884a0',
       i686: 'ff57359c8eaf07a3d0e5bd4eb469f68a099a098e1c511feefda8149767146c24',
     x86_64: '987a0e28faeeed4765c8f0878ac7fbfa9fe9151e3d2541e9133534e87e1885c9'
  })

  depends_on 'python3'
end
