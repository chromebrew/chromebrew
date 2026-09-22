require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.99-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6326daaa9d7cd4f97a84b346601c7e940949388b50b89e249ba516d25b377fd',
     armv7l: 'f6326daaa9d7cd4f97a84b346601c7e940949388b50b89e249ba516d25b377fd',
       i686: 'f415530c8781c9ef404c74ad9f1d3bddd0dbd29b5b52e17ebd576777e680727a',
     x86_64: 'b1173da547da7c43d9447594831d6e1fd5da6026f07201c75310ad47d8b9d410'
  })

  depends_on 'python3' => :logical

  no_source_build
end
