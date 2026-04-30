require 'buildsystems/autotools'

class Libunbound < Autotools
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.25.0'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 '062a6eda723fe2f041bee4079b76981569f1d12e066bbd74800242fc1ebddec7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7dfbcbfc6b8ca3757ca1d6f58076694589f173d4262b1c6c630dde9d8b8e4ab8',
     armv7l: '7dfbcbfc6b8ca3757ca1d6f58076694589f173d4262b1c6c630dde9d8b8e4ab8',
       i686: '7c1996a727fcbfe8e8c547c3f5755086f958a6617f58bec41520a28b63190577',
     x86_64: 'e54baf5b53114e3615b3f17c4e2aee02f2e33a4b5df7e99e2e02271d4fa2b118'
  })

  depends_on 'expat' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'openssl' => :library

  autotools_configure_options '--enable-shared \
    --enable-static \
    --with-pic'

  def self.postinstall
    # Use IPv4 if default fails.
    system "#{CREW_PREFIX}/sbin/unbound-anchor -a '#{CREW_PREFIX}/etc/unbound/root.key' || #{CREW_PREFIX}/sbin/unbound-anchor -4 -a '#{CREW_PREFIX}/etc/unbound/root.key'"
  end
end
