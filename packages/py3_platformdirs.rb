require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.14.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74d90b6be8d314788f786e127c3811cacf684693786556c36599120fb43aec4c',
     armv7l: '74d90b6be8d314788f786e127c3811cacf684693786556c36599120fb43aec4c',
       i686: 'babb62d58db805cb61512104b4375f4902556537d4efed1cba580d91afdf22fa',
     x86_64: '1237af82da8b52ee568bcd5dee705c95c29dda6ba8775d207b626153929793a2'
  })

  depends_on 'python3' => :logical

  no_source_build
end
