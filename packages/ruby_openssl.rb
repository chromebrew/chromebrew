require 'buildsystems/ruby'

class Ruby_openssl < RUBY
  description 'Openssl for ruby provides access to ssl/tls and general-purpose cryptography based on the openssl library.'
  homepage 'https://github.com/ruby/openssl'
  version "4.0.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'ce2e1feb2e0fa1b2ee59091f6520db563ac066bc0d01cdf0bc6d9604542fe435',
     armv7l: 'ce2e1feb2e0fa1b2ee59091f6520db563ac066bc0d01cdf0bc6d9604542fe435',
       i686: '4062ad775aa8c75a81e5208bbc166523e773ce6e7e5e9b57718ac6284d49e9e1',
     x86_64: 'cbd30ac4521e4dd06b87c3eed04d30e8b504b5c35fed732ca86799c6366e2e9f'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
