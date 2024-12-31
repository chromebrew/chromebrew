require 'buildsystems/ruby'

class Ruby_sdbm < RUBY
  description 'Provides a simple file-based key-value store with String keys and values.'
  homepage 'https://github.com/ruby/sdbm'
  version "1.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'ec6e32d972b86e80dec1fa13b45f98c3b5fe7bfbf05bca6a616b58d54bb0aff8',
     armv7l: 'ec6e32d972b86e80dec1fa13b45f98c3b5fe7bfbf05bca6a616b58d54bb0aff8',
       i686: 'b53d96f851a19e8ae95b7eeb009dff8192655479408a1b88b85e3bfd230e68b3',
     x86_64: '7ec5550b8f9d7851a42b193f8beb36f7c9f8830e97c03e4407d31cbe52fd0e3f'
  })

  conflicts_ok
  gem_compile_needed
end
