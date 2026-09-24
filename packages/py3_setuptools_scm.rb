require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "10.3.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8381b9392278f62e88a7a8170683cb1bd4ef59470df8a57fd37bfcd8e89cec0a',
     armv7l: '8381b9392278f62e88a7a8170683cb1bd4ef59470df8a57fd37bfcd8e89cec0a',
       i686: '36bc8db047885fbdcf444189cb61e5a86168957d81be08384ad12701729a878f',
     x86_64: 'abb4f3e0fb988693d5dcf11711274b08d2793f12e83054279e9a68e9fd634a8d'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
