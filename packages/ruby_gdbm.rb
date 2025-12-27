require 'buildsystems/ruby'

class Ruby_gdbm < RUBY
  description 'Ruby extension for GNU dbm.'
  homepage 'https://github.com/ruby/gdbm'
  version "2.1.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '86d731b194df8c5ee8990887d9360a4c1e6a2e03d95411cce48bca8d125b655a',
     armv7l: '86d731b194df8c5ee8990887d9360a4c1e6a2e03d95411cce48bca8d125b655a',
       i686: 'df559f4d96bb8af423a1a552be6aab79b0017290e4e7feccecd5feb3f8dde72e',
     x86_64: '3954165b9abf540336b2f0b8a541c65b94965d74897eb928e495735770e4e9eb'
  })

  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
