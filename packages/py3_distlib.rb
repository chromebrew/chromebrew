require 'buildsystems/pip'

class Py3_distlib < Pip
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  version "0.4.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '30891836908d69fb88aeed420d7e10155987ebfc850ab16a3963e23388898de1',
     armv7l: '30891836908d69fb88aeed420d7e10155987ebfc850ab16a3963e23388898de1',
       i686: 'e441af0049a3b14468f51d623b7c1fe202b476aa79480aa0ccbaf9b19ff47171',
     x86_64: '6d6640dd77500bf484015a3641ded051bf0b52e0b33f0cd3c34d3eed873ef75b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
