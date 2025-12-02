require 'buildsystems/ruby'

class Ruby_stringio < RUBY
  description 'Pseudo `io` class from/to `string`.'
  homepage 'https://github.com/ruby/stringio'
  version "3.1.9-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'b4896a6f2ea2abbe7a6021a091bdfc9843e03af1f640071bc9ac3d92e0ea86a6',
     armv7l: 'b4896a6f2ea2abbe7a6021a091bdfc9843e03af1f640071bc9ac3d92e0ea86a6',
       i686: 'ba5c81b032537081771c03ec75c59438510a2c80d2bf24c44e48f28d15d6a0a5',
     x86_64: '4d90bc949a54cc7464ad15826d665a9e936083dc12ef165cd63ba8aed220eff8'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
