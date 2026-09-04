require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.10.9-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8cf1b5283bc83ab9e548befee9b573e83de7e4e96487dc6c8fab679639c7ba7',
     armv7l: 'f8cf1b5283bc83ab9e548befee9b573e83de7e4e96487dc6c8fab679639c7ba7',
       i686: '1c7d7adaff5957d233c9daff7aee8d56b14038ae131bd8749983db70c120e292',
     x86_64: '7d290e525ba498673de92ca722df6d78d92d0b4a90099f050b0f5c8c63f945bd'
  })

  depends_on 'python3' => :logical
  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
