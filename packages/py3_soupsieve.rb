require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.8.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '552badc716b45ece4bb922ee468eb4b836ee57cfad1c3fa8b00c7546ae966a89',
     armv7l: '552badc716b45ece4bb922ee468eb4b836ee57cfad1c3fa8b00c7546ae966a89',
       i686: 'bd2346d458f8af393f311c8e7acb1b19b307ec89c002ccab64a349603a5abb7e',
     x86_64: '84a438d3081b667f77b448a5123c8386f1891bb30f364612c30846e8b764f345'
  })

  depends_on 'python3' => :build

  no_source_build
end
