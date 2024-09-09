require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version '3.0.4-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '796f1c01882498826449902f1eebee3b859976950d1cd36d7c829972919e38e8',
     armv7l: '796f1c01882498826449902f1eebee3b859976950d1cd36d7c829972919e38e8',
       i686: '6f7646b7258d5fc500448b9cacf701de60a76d74734d8666d4ebc40cb8240824',
     x86_64: '796be94191e2bf51885afb4d0b7d91004095fb96650a113d751aef5159891194'
  })

  depends_on 'python3' => :build

  no_source_build
end
