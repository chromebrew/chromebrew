require 'buildsystems/ruby'

class Ruby_dbm < RUBY
  description 'Provides a wrapper for the UNIX-style Database Manager Library.'
  homepage 'https://github.com/ruby/dbm'
  version "1.1.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '25d29549098fda31a380451bdf1e2a94d251702be49d37145dc1bfa8024ebef4',
     armv7l: '25d29549098fda31a380451bdf1e2a94d251702be49d37145dc1bfa8024ebef4',
       i686: 'be5aad368aa33ea7e5dbbf64c5a0ea92442e34b0bbae99caeda5bc469dd6fe40',
     x86_64: 'f8762a798f3421e4a1d6af87077d45bdbc6d8dda50a611d8cffb79feb12bdbc9'
  })

  conflicts_ok
  gem_compile_needed
end
