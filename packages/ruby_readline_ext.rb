require 'buildsystems/ruby'

class Ruby_readline_ext < RUBY
  description 'Provides an interface for GNU Readline and Edit Line (libedit).'
  homepage 'https://github.com/ruby/readline-ext'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '660035a29391abafd83eff684f0e43b4a4575ec3f437e4654d3b07c53f077bc9',
     armv7l: '660035a29391abafd83eff684f0e43b4a4575ec3f437e4654d3b07c53f077bc9',
       i686: '866be315140a24aa0b2d9a762d7cd7b355d54ee5310b301a576cd89c3cbc245c',
     x86_64: '5214e295cc09f6e74c0e58a65b7d213ef0d4f07511bb64c83987e6ad3868f738'
  })

  conflicts_ok
  gem_compile_needed
end
