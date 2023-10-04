require 'buildsystems/python'

class Py3_pyyaml < Python
  description 'PyYAML is a YAML parser and emitter for Python.'
  homepage 'https://pyyaml.org/'
  @_ver = '6.0.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yaml/pyyaml.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0.1-py3.12_armv7l/py3_pyyaml-6.0.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0.1-py3.12_armv7l/py3_pyyaml-6.0.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0.1-py3.12_i686/py3_pyyaml-6.0.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0.1-py3.12_x86_64/py3_pyyaml-6.0.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bbc7b4b957aeface6608ead58485471925135277349e95b199c86af4c0a4b8a6',
     armv7l: 'bbc7b4b957aeface6608ead58485471925135277349e95b199c86af4c0a4b8a6',
       i686: 'd3aea082e6209a30b56ae96634d92db119daf8536a5a3f050219b90c5426264c',
     x86_64: '3bedebe429f6ec3710043f45798815264c31b46325a79c3e96cfeb225ed7d0f1'
  })

  depends_on 'python3' => :build
end
