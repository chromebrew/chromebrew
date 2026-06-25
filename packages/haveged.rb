require 'buildsystems/autotools'

class Haveged < Autotools
  description 'A simple entropy daemon based on the HAVEGE algorithm, significantly faster than /dev/urandom.'
  homepage 'https://issihosts.com/haveged/'
  version '1.9.26'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/jirka-h/haveged.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ea889df2fe1f2eaf483a49bdb291e0855adad6d70e59711f11ac49b0e12c39b',
     armv7l: '3ea889df2fe1f2eaf483a49bdb291e0855adad6d70e59711f11ac49b0e12c39b',
       i686: '8d04ff58822a53772a9c40fbb6a30b1acc3f3c8f07b90e3968ffe5a1ed1baf5e',
     x86_64: '2955e8df7e08fc75917faffebdbbb4e82496f0744b24731fc927d66511f1fc82'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options ' \
    --disable-daemon \
    --enable-nistest \
    --enable-enttest \
    --enable-olt \
    --enable-threads'

  def self.prebuild
    system 'autoreconf -fiv'
  end

  run_tests
end
