require 'buildsystems/ruby'

class Ruby_ruby_libversion < RUBY
  description 'Ruby bindings for libversion.'
  homepage 'https://github.com/Zopolis4/ruby-libversion'
  version "1.1.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  # TODO: We should be compiling the native extensions, but that is currently broken
  # as the resulting binary does not have GEM_ARCH at the end of the name, causing
  # an empty filelist to be generated.
end
