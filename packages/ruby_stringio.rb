require 'buildsystems/ruby'

class Ruby_stringio < RUBY
  description 'Pseudo `io` class from/to `string`.'
  homepage 'https://github.com/ruby/stringio'
  version "3.1.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '18e05f38a4e6c1c48225d56f88bcf458bc2efa8931b12cbaae01fd709819be74',
     armv7l: '18e05f38a4e6c1c48225d56f88bcf458bc2efa8931b12cbaae01fd709819be74',
       i686: '9c43d6d403bc481fbfce2acb640f8ff96d1fabc77980fd52df76fff7aff2856c',
     x86_64: 'e54382155a8cf7922dfcfc2b3abe921b998bd9f34ceb0f586a698319e652adf8'
  })

  conflicts_ok
  gem_compile_needed
end
