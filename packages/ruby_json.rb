require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.7.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'c18db783b43782c59dc2e2a7d7beca8e382fc37315acfbeb4bb25b564556d479',
     armv7l: 'c18db783b43782c59dc2e2a7d7beca8e382fc37315acfbeb4bb25b564556d479',
       i686: 'bb423f98e12d9acce4455b0705f2bf6a468f14809ca55bcf7821983844e84e50',
     x86_64: '476854b7a819ac0879ceae886b2788c985e5235e0252f7b4ceb487594b612ed9'
  })

  conflicts_ok
  gem_compile_needed
  no_source_build
end
