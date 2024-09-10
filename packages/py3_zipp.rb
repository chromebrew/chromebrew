require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version '3.20.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2ec9442fafc3c4341e719b9215e1df245dbbcd0a757c77da652f65e030df0fd',
     armv7l: 'a2ec9442fafc3c4341e719b9215e1df245dbbcd0a757c77da652f65e030df0fd',
       i686: '8211758d6b9bb5b7f2a247ed43bb6a82f6bd23e0e47ebaeb667369080fdb0be6',
     x86_64: '8d30fdb6bef920ecc450457e73abb1f2355c7dae38c0afa1fff4d8640bd7cff9'
  })

  depends_on 'python3' => :build

  no_source_build
end
