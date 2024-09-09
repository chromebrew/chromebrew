require 'buildsystems/pip'

class Py3_jeepney < Pip
  description 'Jeepney is a low-level, pure Python DBus protocol wrapper.'
  homepage 'https://gitlab.com/takluyver/jeepney/'
  version '0.8.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d46d11b888ec34ae7356fd9d544427d8c9d1fc3893ff97b46e44904b45c7cb9',
     armv7l: '3d46d11b888ec34ae7356fd9d544427d8c9d1fc3893ff97b46e44904b45c7cb9',
       i686: '2e41d52b4466a663508b329d2ba836afba95dece8b35a867400318ca9f0886ee',
     x86_64: 'bf42878e5c0f405583b849c0407682654383c75042c33d1ba85903bdcbb5f118'
  })

  depends_on 'python3' => :build

  no_source_build
end
