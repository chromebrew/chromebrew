require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.10.11-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df776ca511b427f0cafd574456a866b8b6e371251b0172a172f5aafb156bfbac',
     armv7l: 'df776ca511b427f0cafd574456a866b8b6e371251b0172a172f5aafb156bfbac',
       i686: '037ea22dee0282b1ebd8e69059ada3201db7c64ef35cf6d0c9fdacfbe6b7e8b1',
     x86_64: '7eaef6aba232aff5861708798d14d2038551a9c03c935914d5c39401fbdfdab5'
  })

  depends_on 'python3' => :logical
  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
