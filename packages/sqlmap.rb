require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.9.9-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d5ecd7131f5d6a3b77608a214ff2f95ae9f6385b34db3272d3c0726bec35196',
     armv7l: '0d5ecd7131f5d6a3b77608a214ff2f95ae9f6385b34db3272d3c0726bec35196',
       i686: '7c3707cf2457ef8bb855b07fcee848590d522492fddd5942e34678e990b19b2b',
     x86_64: '6a6972498b6e7af2e7a3bf7ebd9f9521f9f0721c4c9ed4cdb92c01616b126bec'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
