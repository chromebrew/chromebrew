require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.8.9-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ad37a768695b6a5a51452a35b789bb95a26fae5e563988277445de8cf32f969',
     armv7l: '7ad37a768695b6a5a51452a35b789bb95a26fae5e563988277445de8cf32f969',
       i686: '288ae7ab7255228c7380e326fac17c60a04984565f89dd2cfee5a94181367867',
     x86_64: '73ef0cd1c7e454ee0a7b5a4db01d5f3ba7f3f22d1d7677478833fc1fa710a11f'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
