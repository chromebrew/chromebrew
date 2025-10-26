require 'buildsystems/pip'

class Py3_psutil < Pip
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  version "7.1.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '410a5a597a448b6b0f02364805a5ad6282dd2e83f32715c0a00b0a2cdb4732e3',
     armv7l: '410a5a597a448b6b0f02364805a5ad6282dd2e83f32715c0a00b0a2cdb4732e3',
       i686: '2885521a78da09a20fb3208e978c8470e84fdde9f936ac3df299653ed5ab068d',
     x86_64: 'fd0a589410e4c72c2dd1fd98c4b3d6c19f624fb2b4f6bb6bf1780bfa0929a4c3'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
