require 'buildsystems/cmake'

class Utfcpp < CMake
  description 'UTF-8 with C++ in a Portable Way'
  homepage 'https://github.com/nemtrif/utfcpp'
  version '4.0.9'
  license 'BSL-1.0'
  compatibility 'all'
  source_url 'https://github.com/nemtrif/utfcpp.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe45ad94ae60884ff9359376a8f864c0f00f54e161542bdc1d6eea0e1c69c3ef',
     armv7l: 'fe45ad94ae60884ff9359376a8f864c0f00f54e161542bdc1d6eea0e1c69c3ef',
       i686: 'f334879e6f625a9ceb1bcff22c356d103eb26b0ed4f8220659e537ad646bb423',
     x86_64: '13cf3c5d20a2ab50c2ca3248dbf9cad0ff58ef6e582117ebdd1ed9610a4fc8ab'
  })
end
