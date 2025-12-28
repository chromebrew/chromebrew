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
    aarch64: 'b937bfd6041b647b71dda88d7a5ceb5911be051a12eb45b835c2e4dedcfe3f27',
     armv7l: 'b937bfd6041b647b71dda88d7a5ceb5911be051a12eb45b835c2e4dedcfe3f27',
       i686: '952be7ef51d147a4f46928593b3ae4091b13a399132db387bd0fbcfa5582139a',
     x86_64: '416956a3e4a00890c0467ae382748a8958d14dc5e667d50111a646d74553246f'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
