require 'buildsystems/ruby'

class Ruby_nkf < RUBY
  description 'Ruby extension for Network Kanji Filter'
  homepage 'https://github.com/ruby/nkf'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '6d253a775655cb03ae0a30d3d3d638844d9735df3629a166a79d3f012d488b14',
     armv7l: '6d253a775655cb03ae0a30d3d3d638844d9735df3629a166a79d3f012d488b14',
       i686: '30a5076b3fe7c6f5fe8094b8443d345138c4c98c09cc9e28d82127097fcb97fb',
     x86_64: '37184992d5efe2dc2e5c3f1cf08a16219655f3dcec0a996103004f82cc4496c8'
  })

  conflicts_ok
  gem_compile_needed
end
