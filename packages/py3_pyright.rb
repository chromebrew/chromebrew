require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.408-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e38d515eb19c360f77465bb0a7723261cc99b782c406351147af2d81e46de175',
     armv7l: 'e38d515eb19c360f77465bb0a7723261cc99b782c406351147af2d81e46de175',
       i686: '3c4454db84c34077787e39cc6c53005fbe360f8f2bb1b94acfa92ea28ab5c09e',
     x86_64: '6c929918536019b37bf4f6fdd0560ec475178c1c968eae88137ef6f08c74e74a'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
