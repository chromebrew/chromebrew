require 'buildsystems/ruby'

class Ruby_racc < RUBY
  description 'Racc is a LALR(1) parser generator.'
  homepage 'https://github.com/ruby/racc'
  version "1.8.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'd463a733734336c4087fc9f578e1161a9f32e754f5931de3f562543839555bcc',
     armv7l: 'd463a733734336c4087fc9f578e1161a9f32e754f5931de3f562543839555bcc',
       i686: 'aa6668bf2079ec35e8888b12889dab02a169f982d3a1fcc0b6b356c1643e8afe',
     x86_64: '923654c7e27ba05b10a28bd4f008e789b1455a053ad379de6b7c7b4208586756'
  })

  conflicts_ok
  gem_compile_needed
end
