require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '10b50b409e7b96e5bca2a7163333f4aefdb61514d227a27904d7406dfea91c11',
     armv7l: '10b50b409e7b96e5bca2a7163333f4aefdb61514d227a27904d7406dfea91c11',
       i686: '2935bbae6e0f6d7e2bfaad4f2f93558fa757df611d37bd377843e4b64126e353',
     x86_64: 'f5c041096d981a0bc2d5ea098efb88616739ae32c2da73c29c6ace49e816333c'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
