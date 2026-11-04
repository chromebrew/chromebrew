require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a945b6b59df55457cfd2654e6206415ac7a6588e8501f3177b97ffa7da0c309',
     armv7l: '9a945b6b59df55457cfd2654e6206415ac7a6588e8501f3177b97ffa7da0c309',
       i686: 'a228a3dee4c698a96b37ef426f0cab9e6d80272aa494f799ce650e114b49368a',
     x86_64: 'e3789d7762331f59a756b6792334ce1124bb5b08c48866ad98a9e5cedf67fbf2'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
