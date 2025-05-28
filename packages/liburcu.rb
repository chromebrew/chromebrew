require 'buildsystems/autotools'

class Liburcu < Autotools
  description 'Userspace RCU (read-copy-update) library.'
  homepage 'https://liburcu.org/'
  version '0.14.0-2'
  license 'LGPLv2.1'
  compatibility 'all'
  source_url "https://lttng.org/files/urcu/userspace-rcu-#{version.split('-').first}.tar.bz2"
  source_sha256 'ca43bf261d4d392cff20dfae440836603bf009fce24fdc9b2697d837a2239d4f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a28e5a8fb742bde0e3177aaee4b59a39cbbc36a4b462897a3e63ca7fa31d5f9',
     armv7l: '2a28e5a8fb742bde0e3177aaee4b59a39cbbc36a4b462897a3e63ca7fa31d5f9',
       i686: '7806f53b85628320cf866aafc7c2d3add0b0b42a6afbea1fd5dd15d465ee152f',
     x86_64: 'c3cfb3686d8d76b611380ac84d2f6c15cffda194a804560413b49ce7998165e5'
  })

  depends_on 'glibc' # R

  autotools_configure_options '--disable-static'

  run_tests
end
