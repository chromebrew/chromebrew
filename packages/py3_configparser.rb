require 'buildsystems/pip'

class Py3_configparser < Pip
  description 'Configparser backports newer configparser modules to earlier python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  version "7.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba4b9e039c64fd31268e15b5ce17a97419cb8b63ae6c6c79026d001ca1bf3cc9',
     armv7l: 'ba4b9e039c64fd31268e15b5ce17a97419cb8b63ae6c6c79026d001ca1bf3cc9',
       i686: '01ad6361a50f72ac94be0bba295da10438070b81095c18cfdc4e6ae8252b9f9b',
     x86_64: '4421f54b5aed8cbcd964fb30100eec5b267ca4f93ed81ef1df1a825936a6f9bc'
  })

  depends_on 'python3' => :build

  no_source_build
end
