require 'buildsystems/ruby'

class Ruby_ruby_libversion < RUBY
  description 'Ruby bindings for libversion.'
  homepage 'https://github.com/Zopolis4/ruby-libversion'
  version "1.0.0-1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '3695d5a8f942a6586b0ec2f521a8a3ffc66e70e2cb09259a3d4a70f6e3c219b8',
     armv7l: '3695d5a8f942a6586b0ec2f521a8a3ffc66e70e2cb09259a3d4a70f6e3c219b8',
       i686: '7929685c52eb57310365fade401bd03a313011a136d665cfaaf902c6b8ee79b9',
     x86_64: 'd01237a0dc9a72a6a623273eef7d4df7df333945e8c45e7f5f8e96b9d97e9855'
  })

  depends_on 'libversion' # R
  gem_compile_needed
  no_source_build
end
