require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "5.1.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'e156960d6c780cd2fb2912a5ad346c0fe37af25ec85fcea232468b1147c3faf5',
     armv7l: 'e156960d6c780cd2fb2912a5ad346c0fe37af25ec85fcea232468b1147c3faf5',
       i686: '6cfdb6a9664ef71941b1600cf50da584c07661cf07d7d5e778814f6370f58362',
     x86_64: 'f20bf47698007e4519cc750090eb10bb96d18c58bb7af56211d310ff15c5f8bb'
  })

  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
