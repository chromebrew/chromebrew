require 'buildsystems/autotools'

class Apr_util < Autotools
  description 'APR-util provides a number of helpful abstractions on top of APR.'
  homepage 'http://apr.apache.org/'
  version '1.6.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://dlcdn.apache.org/apr/apr-util-1.6.3.tar.bz2'
  source_sha256 'a41076e3710746326c3945042994ad9a4fcac0ce0277dd8fea076fec3c9772b5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apr_util/1.6.3_armv7l/apr_util-1.6.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apr_util/1.6.3_armv7l/apr_util-1.6.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apr_util/1.6.3_i686/apr_util-1.6.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/apr_util/1.6.3_x86_64/apr_util-1.6.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '51950f0c56c7f9c8e8e86dd2783a6f2ca4f3f3867a043f0e267218c9d4f42915',
     armv7l: '51950f0c56c7f9c8e8e86dd2783a6f2ca4f3f3867a043f0e267218c9d4f42915',
       i686: '377343921064393e2f63b891df8dc1e485c2b4ff87611e91aeb17096fac12dc7',
     x86_64: '501d3d799eda2eb77a76994ca0ef00ccf56b231acd59de3a915e598b3555e5db'
  })

  depends_on 'apr'
  depends_on 'expat'

  configure_options "--with-apr=#{CREW_PREFIX}"
end
