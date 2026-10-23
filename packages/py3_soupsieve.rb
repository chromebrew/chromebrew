require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "3.0.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a665cf158910ff4e46c2bf5548a3b008b63b55ff69b17c1f173cebec36bb6a98',
     armv7l: 'a665cf158910ff4e46c2bf5548a3b008b63b55ff69b17c1f173cebec36bb6a98',
       i686: '2d74181cd73371b5fd0c5ef05e33de4c458d7a33a88ce325cb44cdb78c866cbc',
     x86_64: 'e4c58617902238fceb45b6ad02cfa1303aad30f2e88d66714d90a30c9a6c8989'
  })

  depends_on 'python3' => :logical

  no_source_build
end
