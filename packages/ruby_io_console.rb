require 'buildsystems/ruby'

class Ruby_io_console < RUBY
  description 'add console capabilities to IO instances.'
  homepage 'https://github.com/ruby/io-console'
  version "0.8.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '4bd9e8ffcbaa25d61c39f225069cb27717439d6d57f920947bd855855af51a6d',
     armv7l: '4bd9e8ffcbaa25d61c39f225069cb27717439d6d57f920947bd855855af51a6d',
       i686: 'd73b01dd00b1109b75f8e5a3e456f1bd12ab288e63214810e08bf8411256c71b',
     x86_64: '613c9358a90b4929580ff57795de137368150e3958e7e7c144ecd038bc1eb78a'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
