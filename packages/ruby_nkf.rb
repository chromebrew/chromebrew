require 'buildsystems/ruby'

class Ruby_nkf < RUBY
  description 'Ruby extension for Network Kanji Filter'
  homepage 'https://github.com/ruby/nkf'
  version "0.3.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'dc45be45590bb46bd0fd687915a9bf20038b9287cd4ac6805161d95e19f23e28',
     armv7l: 'dc45be45590bb46bd0fd687915a9bf20038b9287cd4ac6805161d95e19f23e28',
       i686: '824f303a6caaef442ac8ff96e68d5fad2eced8723f7cbc47e791e2dd82f9b507',
     x86_64: 'd488657f6ccc3d8cb4905385dbc4e438920d5c95c527f22b23c38d5a55a6347b'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
