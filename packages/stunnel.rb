require 'buildsystems/autotools'

class Stunnel < Autotools
  description "Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code."
  homepage 'https://www.stunnel.org/index.html'
  version '5.75'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://www.stunnel.org/downloads/stunnel-#{version}.tar.gz"
  source_sha256 '0c1ef0ed85240974dccb94fe74fb92d6383474c7c0d10e8796d1f781a3ba5683'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '75268660f310062a51be36c114a8bf658cae38fdf85d4a53f65430767283f6cd',
     armv7l: '75268660f310062a51be36c114a8bf658cae38fdf85d4a53f65430767283f6cd',
       i686: 'a910279777b46c6b2c85debfac69dc5e57e1a541e27b41653dba03bb63325bdb',
     x86_64: 'b337876d9a7ac28168a07d7b5b3969dc2a08110ac3eca5363132942931afa538'
  })

  depends_on 'glibc' # R
  depends_on 'openssl'
end
