require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version '1.8.8'
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3', '>= 3.12.0'
end
