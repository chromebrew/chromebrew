require 'buildsystems/ruby'

class Ruby_byebug < RUBY
  description 'Byebug is a Ruby debugger.'
  homepage 'https://github.com/deivid-rodriguez/byebug'
  version "13.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '1bdbcd3eab6d9d76757969af9147c60425de2cceaeb0e984a742d702e30c595a',
     armv7l: '1bdbcd3eab6d9d76757969af9147c60425de2cceaeb0e984a742d702e30c595a',
       i686: '0845453c18bac828dc2e2711c9704db26d644cd1dee262c031d7287e5b497c67',
     x86_64: '61330d4baa0e4c63b904e6d9846712593c71b275ba774a70006ef2f2294631ed'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
