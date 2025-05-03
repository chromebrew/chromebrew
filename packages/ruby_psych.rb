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
     armv7l: '2e2f03b3a65ef035f9b878623b33783eb8bda65327c55608d65d5f0d82ef2437'
  })

  depends_on 'ruby_stringio' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
