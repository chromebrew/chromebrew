require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "6.0.5-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '0385cd4efe898a82aecccc3ee322145eb6bb26070216107f879b310b0ccf6c77',
     armv7l: '0385cd4efe898a82aecccc3ee322145eb6bb26070216107f879b310b0ccf6c77',
       i686: '0ac54c74effcb0670d8552abe41cef786737afdfcf7de387e0de60cd52f4a47e',
     x86_64: '64e31a25ca4b9630fc40b62f2a004735cffc4c5f00743d90323aca9141923998'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
