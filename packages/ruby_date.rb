require 'buildsystems/ruby'

class Ruby_date < RUBY
  description 'A subclass of object includes comparable module for handling dates.'
  homepage 'https://github.com/ruby/date'
  version "3.6.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'bc3fb5e74bf5a11695384d5805b0faffdba2e40d2897c4b8d94e913045f61e65',
     armv7l: 'bc3fb5e74bf5a11695384d5805b0faffdba2e40d2897c4b8d94e913045f61e65',
       i686: '414d03cc6f6cb04d82b6deaef50d8501644870acf9942304dd1b0a00bcf32ccf',
     x86_64: '0c3dc71a2ce0e9dc851f773794861192ddb5b539ed3c899f48b42a55345f6c61'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
  no_source_build
end
