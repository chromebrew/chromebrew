require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.21.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '228db24110e03ad583b29f9ff8d996b28b9fb3adf1470538a41f24cd4b1cd6f6',
     armv7l: '228db24110e03ad583b29f9ff8d996b28b9fb3adf1470538a41f24cd4b1cd6f6',
       i686: 'd18dbf2e74749ee468e6d6114e8d153ddb123be9be9f2c522a9d03731b459ba6',
     x86_64: '3ac24c069455d79504920c44714018f37e6fd7e90b7a29c2302fb8c1765654aa'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
