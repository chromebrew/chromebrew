require 'buildsystems/autotools'

class Libxcrypt < Autotools
  description 'Modern library for one-way hashing of passwords'
  homepage 'https://github.com/besser82/libxcrypt/'
  version '4.5.2'
  license 'LGPL-2.1+, public-domain, BSD and BSD-2'
  compatibility 'all'
  source_url "https://github.com/besser82/libxcrypt/releases/download/v#{version}/libxcrypt-#{version}.tar.xz"
  source_sha256 '71513a31c01a428bccd5367a32fd95f115d6dac50fb5b60c779d5c7942aec071'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ee04ec38fba081b7fed26007a922e45033313022406eda41edb3aa95bca435a',
     armv7l: '8ee04ec38fba081b7fed26007a922e45033313022406eda41edb3aa95bca435a',
       i686: 'b366ff7a08295510aa900738c384a208508bf4c44fda541475df899f22545412',
     x86_64: 'ebcef904c8434c450cdf5c9f9104f1f0003dc6d00f77e850472c0e389d0281a1'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build

  conflicts_ok

  # ENV['CREW_LINKER'] = 'lld'
  # run_tests
end
