require 'buildsystems/ruby'

class Ruby_dbm < RUBY
  description 'Provides a wrapper for the UNIX-style Database Manager Library.'
  homepage 'https://github.com/ruby/dbm'
  version "1.1.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'da0ace268b4084f769d3b521cf8b8cda8a45a352533595127e57b937f1d61ded',
     armv7l: 'da0ace268b4084f769d3b521cf8b8cda8a45a352533595127e57b937f1d61ded',
       i686: 'cbed7a0dbb899968d9f2128b3f6abea146aea2e66d1776d0a62fd474c50d333f',
     x86_64: '43af5c5483c3168bc69329b686a31e87fc725d3b8df888b6ae9039deb92e9dbd'
  })

  depends_on 'glibc' # R
  depends_on 'libdb' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
