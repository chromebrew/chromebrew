require 'buildsystems/autotools'

class Libunbound < Autotools
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.25.2'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 '0d92275c703d5f5f8baba3dab22117dd8c29b495588a5c229768ed6581566600'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3f69a521e396a556fa5cab12ade1a2f26304802a809173b0cb9707356490fb3',
     armv7l: 'a3f69a521e396a556fa5cab12ade1a2f26304802a809173b0cb9707356490fb3',
       i686: '2d7fbd9e3bb54b82f666407b17de8ef926b69f83f93f7724e93eecf473eae71e',
     x86_64: 'c0465e0fcaee9c42f869e12909715a184ced753e2c63e0daa4a57690784c9192'
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
