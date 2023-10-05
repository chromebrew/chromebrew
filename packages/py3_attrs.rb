require 'buildsystems/python'

class Py3_attrs < Python
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  @_ver = '23.1.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-attrs/attrs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/23.1.0-py3.12_armv7l/py3_attrs-23.1.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/23.1.0-py3.12_armv7l/py3_attrs-23.1.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/23.1.0-py3.12_i686/py3_attrs-23.1.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_attrs/23.1.0-py3.12_x86_64/py3_attrs-23.1.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '57e52146352bafb1bb479df276c66bca71793054ed0bb0628fc2b54a1b982b07',
     armv7l: '57e52146352bafb1bb479df276c66bca71793054ed0bb0628fc2b54a1b982b07',
       i686: '4a7de667ea62ac4dd2ac687ba8a4015aa7a08a9c9499edabd4c5526dc01916eb',
     x86_64: 'd48c4cde2273bdc89b0dd17422605f25d99577cbf3e51d4df05b3fc864ff6828'
  })

  depends_on 'python3' => :build
  depends_on 'py3_hatchling' => :build
  depends_on 'py3_hatch_vcs' => :build
end
