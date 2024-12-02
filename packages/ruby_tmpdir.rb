require 'buildsystems/ruby'

class Ruby_tmpdir < RUBY
  description 'Extends the dir class to manage the os temporary file path.'
  homepage 'https://github.com/ruby/tmpdir'
  version "0.3.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_fileutils' # R

  conflicts_ok
  no_compile_needed
end
