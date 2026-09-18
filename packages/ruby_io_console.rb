require 'buildsystems/ruby'

class Ruby_io_console < RUBY
  description 'add console capabilities to IO instances.'
  homepage 'https://github.com/ruby/io-console'
  version "0.9.4-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '6805e01ce05ff0fcfe5f687ef7b1236fc68c0efdcd89f605ee19977890da0c25',
     armv7l: '6805e01ce05ff0fcfe5f687ef7b1236fc68c0efdcd89f605ee19977890da0c25',
       i686: '8531b48638730b2552d57e430c87884102ab8bd9805663c91bd6d6bd3af4b819',
     x86_64: '2afad75c52c361f0ebb30e034f015815f2cc77ff11cca80c134ae47ddc0324d4'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
