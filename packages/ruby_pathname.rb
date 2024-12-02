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
    aarch64: 'be0b6a326ee13db3a877dd9ebd230ba55a6bd6a5b13d2905435ec25494bea643',
     armv7l: 'be0b6a326ee13db3a877dd9ebd230ba55a6bd6a5b13d2905435ec25494bea643',
       i686: '914c1d0cca87b8d87d8cd1e50a43eff9ee63a4b71277db918aac3320fd0dac18',
     x86_64: 'a16e9673646b917273395c96ca05238a2a44f448d497d8a1033c742415dc19aa'
  })

  conflicts_ok
  gem_compile_needed
end
