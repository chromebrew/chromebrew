require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.410-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ead0e24008c9de695b100c9031d924f7bef895ad45e459b58c24caefe402b5dd',
     armv7l: 'ead0e24008c9de695b100c9031d924f7bef895ad45e459b58c24caefe402b5dd',
       i686: 'bbbba2f0e430850e61f89ad58cf74dd321c9bda0834f290e47b6205f13d76d71',
     x86_64: 'e5ce63d91cc738e5708b3512edc435efbb4bf102e0acd1b109d28da333d20386'
  })

  depends_on 'py3_nodeenv'
  depends_on 'python3' => :logical

  no_source_build
end
