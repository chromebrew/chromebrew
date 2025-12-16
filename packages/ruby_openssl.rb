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
    aarch64: 'cb4765949d9bcfaab3e082d4fb6ae30344713b34d87a3428ae0d5120fd76401e',
     armv7l: 'cb4765949d9bcfaab3e082d4fb6ae30344713b34d87a3428ae0d5120fd76401e',
       i686: 'a73bd598c4411279ec52c74b07ac38053d29c996686a52e811beee72124d7538',
     x86_64: '09becd26ed8eaa549e8d2e233c5ee9c2eb7c9fd26d8047278bf890ce5c308456'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
