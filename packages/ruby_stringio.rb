require 'buildsystems/ruby'

class Ruby_stringio < RUBY
  description 'Pseudo `io` class from/to `string`.'
  homepage 'https://github.com/ruby/stringio'
  version "3.1.6-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '1d29807f46c9ca3c5fabcb3362b39d2ee0c0d5239f46cfc5401375d9009822d9',
     armv7l: '1d29807f46c9ca3c5fabcb3362b39d2ee0c0d5239f46cfc5401375d9009822d9',
       i686: '91ac82ad1018a6802bc93b2f92aadfd36010d4fe885236b5859516df289ffa2f',
     x86_64: '862fe6bf09bf41d635e9b87eb156744227127966d8695e1d34dfc5a16e43910c'
  })

  conflicts_ok
  gem_compile_needed
end
