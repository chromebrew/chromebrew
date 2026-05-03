require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.10.5-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0fa8953ce00c27b0cda4e089b3f692d63e97dfb6b993d6aec1c38a78d719748',
     armv7l: 'b0fa8953ce00c27b0cda4e089b3f692d63e97dfb6b993d6aec1c38a78d719748',
       i686: '6a014154afea3fbf979ffcf5ca7f5731549fc7efe17dbe0b045bbd1d0b3a1256',
     x86_64: 'aab00074f6c14c1220e63dfb73e30d54b47966357f8aa5f5fbf0060e80990480'
  })

  depends_on 'python3' => :logical
  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
