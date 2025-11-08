require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.16.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '40409580226eeb17033fb16a5089022022e5a02190549b8f8f94c61d8db33348',
     armv7l: '40409580226eeb17033fb16a5089022022e5a02190549b8f8f94c61d8db33348',
       i686: '9ef6bab4ba908358a2af70c4af7e791830bd7f8647f4a04828d3c0a20c188985',
     x86_64: '78b0742b3064b893ce72192a5169a885505d5d6e4964558fcf8ae73ba539ea91'
  })

  conflicts_ok
  gem_compile_needed
end
