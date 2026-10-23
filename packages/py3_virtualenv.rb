require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.14.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '474003137a7f6554f040c9a7e4ebccea39611c8ced73ffff498fde7277c13b22',
     armv7l: '474003137a7f6554f040c9a7e4ebccea39611c8ced73ffff498fde7277c13b22',
       i686: 'e10404bfd026a28abbdae2867e80abec61745e03c8ef7e24b4cc7108234a7212',
     x86_64: '58ada0f772bf7cddf9e9f090fd1aa2660b1ad274593e2abe4940c7813622f120'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
