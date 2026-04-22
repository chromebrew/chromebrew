require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "6.0.4-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '5b0dcca149e5c10f113a2caa33ec50fb5d19391b1a5e2d645b7879493ab0eec1',
     armv7l: '5b0dcca149e5c10f113a2caa33ec50fb5d19391b1a5e2d645b7879493ab0eec1',
       i686: '15d7dad415ca77e5dd22c04bea25f71e39305b8d9841c5f7f7e44b93f6e1fbc8',
     x86_64: 'ad05835a856ff75993dee10ec9da30d9152fa18d3bfcf52e430a06a673f31122'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
