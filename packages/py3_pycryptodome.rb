require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "4.1.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff4b2d26e992d1ecd7e91804caea0bde8d9337af53df3c0963c142e16e359c34',
     armv7l: 'ff4b2d26e992d1ecd7e91804caea0bde8d9337af53df3c0963c142e16e359c34',
       i686: 'e17430e09c833fd2ab512b70b8f9e7f8dc94729b7a8fc0b4316974813380ebd8',
     x86_64: '6068d275713f5ced43a33b63b0c8652481ebb6fb374d6896be9f1341e3fc73e6'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
