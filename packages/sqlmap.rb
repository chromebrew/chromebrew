require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.10.7-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8f0cf86585678c1d6f0cb2312937ecd219a83e77d5ee0ac4a4715c63df399f5',
     armv7l: 'f8f0cf86585678c1d6f0cb2312937ecd219a83e77d5ee0ac4a4715c63df399f5',
       i686: '0b68abce8e4eba92a2465e176c9b117c7f2c20736111ac828d102e65aac17ff6',
     x86_64: 'f3153e607cfba792d611399a742cf71c96f78b9785cc3eaa69fa321ef2efd8b5'
  })

  depends_on 'python3' => :logical
  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
