require 'buildsystems/pip'

class Py3_attrs < Pip
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  version '24.2.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

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
