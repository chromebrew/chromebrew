require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.19.3-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '6c9f4bf6d3803a9ebc0975eae3145f8efde55ea1a7d84128d9b1b4b53cd73808',
     armv7l: '6c9f4bf6d3803a9ebc0975eae3145f8efde55ea1a7d84128d9b1b4b53cd73808',
       i686: '748fd5ae2a4ac5715403fa1783cd218e939a037d182fec13c4510a9c19897fbc',
     x86_64: '55eb9f770187aa43db5f65104ffafd806e7866745b6c24e9d06fedcf11e29dea'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
