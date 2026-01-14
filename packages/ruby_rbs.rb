require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.10.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '8cc89a7db7a93f872c5e248d10e523496f73b727260a62bafa3e0dcb88293359',
     armv7l: '8cc89a7db7a93f872c5e248d10e523496f73b727260a62bafa3e0dcb88293359',
       i686: 'dd280655fec2284119a274c8e390b208ca002be7ce0733e50344975ec8400e9e',
     x86_64: '925bd7e783b247701ab41c1cc3f513c3a1c738699586ef6bfd62ef2007d50412'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R
  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
