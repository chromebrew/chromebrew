require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "6.0.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '235f1e27049caa848cd58fd18cafa4e12e1c30ada061de61d76cca166d8e8664',
     armv7l: '235f1e27049caa848cd58fd18cafa4e12e1c30ada061de61d76cca166d8e8664',
       i686: 'df3f705d5bc89b6455acd5872b94cd13233f97e0757f9608a4c83d73228358d4',
     x86_64: 'ab67c26f0ea3dc25dfbba6d31b1c18945ce4c989280fb94159f30cfb531c5f3d'
  })

  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
