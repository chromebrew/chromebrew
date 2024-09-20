require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version '2.23.4-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7d5a7dde84278629b45987013dce32b646567e708b815d7b2250f238baa9015',
     armv7l: 'd7d5a7dde84278629b45987013dce32b646567e708b815d7b2250f238baa9015',
       i686: '8576c9fbc6789966a1d75f57b2dd74bc1ba1515b3f70ef3c19cfc31a89d465ee',
     x86_64: '926563c9013f5ab45629b2a4d1d6d1c26b4b34ebca011f90612f481611d1d80c'
  })

  depends_on 'python3' => :build

  no_source_build
end
