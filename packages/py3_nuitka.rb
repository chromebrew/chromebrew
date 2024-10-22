require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.4.10-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '19e00f92db747bdb521733c2e231ec22f90b5e679e1758eaa76a735ccd2b8585',
     armv7l: '19e00f92db747bdb521733c2e231ec22f90b5e679e1758eaa76a735ccd2b8585',
       i686: '7808a0586cb5a9eee9cfbf1a44111ca4052017f4b7403ad53b7af8dd4d5c998a',
     x86_64: '2f5ea981175a4678ea8132582090923005d17db0da4834f65dc4c982d1f9938c'
  })

  depends_on 'python3' => :build

  no_source_build
end
