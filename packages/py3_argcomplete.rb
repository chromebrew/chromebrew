require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.5.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '184397991453497932fb5885f7d4a0d96ebf18d8f36f551180e4b40d9ce5a8e0',
     armv7l: '184397991453497932fb5885f7d4a0d96ebf18d8f36f551180e4b40d9ce5a8e0',
       i686: '1ab6005f5dc25e9f14e287f37f14672a7ccfcbfa0a840b07f896661adeb4779a',
     x86_64: '2f315965d00530c115775d54fd10681b0d02ffbf29f2dffa764a48e4e399a0e8'
  })

  depends_on 'python3' => :build

  no_source_build
end
