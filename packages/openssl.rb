require 'package'

class Openssl < Package
  description 'OpenSSL is a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.'
  homepage 'https://www.openssl.org/'
  version '3.0.2'
  compatibility 'all'

  is_fake

  depends_on 'libressl'
end
