require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "4.1.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a83260c42e3c0d938fad6e9b5aa44c43d71faef7f7b9f2b0c949a86bb707896',
     armv7l: '7a83260c42e3c0d938fad6e9b5aa44c43d71faef7f7b9f2b0c949a86bb707896',
       i686: 'fb44e138b4392cbca7f78a32ed2150b4dd39b425d5186e538aab0d85db332493',
     x86_64: 'b02adf4b5b10ca7c7c7769a86e5f1a151134c5ab7e6f1dbae06ea7395e989aca'
  })

  depends_on 'python3' => :logical

  no_source_build
end
