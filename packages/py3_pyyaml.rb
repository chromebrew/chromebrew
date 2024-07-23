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
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bbc7b4b957aeface6608ead58485471925135277349e95b199c86af4c0a4b8a6',
     armv7l: 'bbc7b4b957aeface6608ead58485471925135277349e95b199c86af4c0a4b8a6',
       i686: 'd3aea082e6209a30b56ae96634d92db119daf8536a5a3f050219b90c5426264c',
     x86_64: '3bedebe429f6ec3710043f45798815264c31b46325a79c3e96cfeb225ed7d0f1'
  })

  depends_on 'python3' => :build
end
