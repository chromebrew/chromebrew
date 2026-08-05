require 'buildsystems/autotools'

class Libunbound < Autotools
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.26.0'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 '77458a7156e275c0b7b17fabcb357cb12445d95cfcb26fb9bb7d5ecba45e0b63'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09400cce47e8f593772e5ebba0960cc7308e9b4da16209089815e3956523f710',
     armv7l: '09400cce47e8f593772e5ebba0960cc7308e9b4da16209089815e3956523f710',
       i686: '101bda1bd2e91d18e5c60e56b0d0a0b3a4eedca80f4b40461699c26872d059d9',
     x86_64: 'ae2347b4118ef838ac1b3967b60eafca6d663a1c355a6494423a5753ee2e61b3'
  })

  depends_on 'expat' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library

  autotools_configure_options '--enable-shared \
    --enable-static \
    --with-pic'

  def self.postinstall
    # Use IPv4 if default fails.
    system "#{CREW_PREFIX}/sbin/unbound-anchor -a '#{CREW_PREFIX}/etc/unbound/root.key' || #{CREW_PREFIX}/sbin/unbound-anchor -4 -a '#{CREW_PREFIX}/etc/unbound/root.key'"
  end
end
