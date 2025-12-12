require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.18.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '9e9fff958910c101f783a7822b2614f13d0710d39ac3fc8367e72b27dfc258b0',
     armv7l: '9e9fff958910c101f783a7822b2614f13d0710d39ac3fc8367e72b27dfc258b0',
       i686: '286a6f3a4abafe3b0999b58a394ffbfdfc21f078926872e3ba8bfd05cc45e025',
     x86_64: 'de4017335ab0a10112f25fa161bcfd954aa3b862d1a7ae92808ff36902088624'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
