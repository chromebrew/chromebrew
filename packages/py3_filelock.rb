require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.0.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd530eb385d1a857e51a88a57884dec5c0935a0ba2febeeb5ec1aabcfe9a5edb3',
     armv7l: 'd530eb385d1a857e51a88a57884dec5c0935a0ba2febeeb5ec1aabcfe9a5edb3',
       i686: '217199fd8c5484ca6754a4e7aa147ab9fdf41a4a1168d573be73ff7c4b4434bb',
     x86_64: '49e16707d4b75ce1486b0ba5b1d57fbabdfde7d1861f7057b65c09ed508e1383'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
