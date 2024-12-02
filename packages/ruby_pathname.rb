require 'buildsystems/ruby'

class Ruby_pathname < RUBY
  description 'Representation of the name of a file or directory on the filesystem.'
  homepage 'https://github.com/ruby/pathname'
  version "0.4.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'e65142157112fb9730a5e885ee1c60f8dd29cc73cd2086f24ee9e00085bc9e2a',
     armv7l: 'e65142157112fb9730a5e885ee1c60f8dd29cc73cd2086f24ee9e00085bc9e2a',
       i686: 'f2929b41903a8fe0b525b7e8a99101cd42b11578db585a040725737709e16d48',
     x86_64: 'a16e9673646b917273395c96ca05238a2a44f448d497d8a1033c742415dc19aa'
  })

  conflicts_ok
  gem_compile_needed
end
