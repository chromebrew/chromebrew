require 'buildsystems/pip'

class Py3_secretstorage < Pip
  description 'Python bindings to Freedesktop.org Secret Service API'
  homepage 'https://secretstorage.readthedocs.io/'
  version "3.4.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f21c960f54a2608623033491e2b56dc049598a9b71fea0f805ab8351d436605',
     armv7l: '9f21c960f54a2608623033491e2b56dc049598a9b71fea0f805ab8351d436605',
       i686: '68c9f20fb8407164395bf8de71ab450a746bbd34b9a19aeddce501526f1d5db3',
     x86_64: 'e15ec606a5406ac5d2ebf1fdf097df41c1074d0c05d2f3920c4ab2e887e0e82f'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_cryptography'
  depends_on 'python3' => :build

  no_source_build
end
