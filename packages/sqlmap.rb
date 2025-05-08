require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.9.5-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '571eaa07abc45e76850682033260d2efc9af87912d92fd6c6c9a006a2cc4abcc',
     armv7l: '571eaa07abc45e76850682033260d2efc9af87912d92fd6c6c9a006a2cc4abcc',
       i686: '97b3d565be61f1cee0595e25039053c28c4c97595e51db816ec348c6c31f73d6',
     x86_64: '81e1d47b59b64e47b42f27ffdedca4c7d01ca64feddfb342e15c00c99ac8fa45'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
