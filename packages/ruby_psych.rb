require 'buildsystems/ruby'

class Ruby_psych < RUBY
  description '| psych is a yaml parser and emitter.'
  homepage 'https://github.com/ruby/psych'
  version "5.2.4-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '2e2f03b3a65ef035f9b878623b33783eb8bda65327c55608d65d5f0d82ef2437',
     armv7l: '2e2f03b3a65ef035f9b878623b33783eb8bda65327c55608d65d5f0d82ef2437',
       i686: 'bad042d6fb6384410a6e933ecbe923c165879bbdb40c5eb1e31a267666ad268f',
     x86_64: 'f6f4246d8934f2d8b9c6cf2ed74a34793cdf78cb01e7d1dbe993ef33eb4082c3'
  })

  depends_on 'ruby_stringio' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
