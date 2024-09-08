require 'buildsystems/pip'

class Py3_installer < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f302c9f93e2c68f69f59006fbc25bfda1928b0c56b11bed14842bdd5a3884a0',
     armv7l: '4f302c9f93e2c68f69f59006fbc25bfda1928b0c56b11bed14842bdd5a3884a0',
       i686: 'ff57359c8eaf07a3d0e5bd4eb469f68a099a098e1c511feefda8149767146c24',
     x86_64: '987a0e28faeeed4765c8f0878ac7fbfa9fe9151e3d2541e9133534e87e1885c9'
  })

  depends_on 'python3'
end
