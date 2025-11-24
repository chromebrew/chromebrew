require 'buildsystems/autotools'

class Libxcrypt < Autotools
  description 'Modern library for one-way hashing of passwords'
  homepage 'https://github.com/besser82/libxcrypt/'
  version '4.5.2'
  license 'LGPL-2.1+, public-domain, BSD and BSD-2'
  compatibility 'all'
  source_url "https://github.com/besser82/libxcrypt/releases/download/v#{version.split('-').first}/libxcrypt-#{version.split('-').first}.tar.xz"
  source_sha256 '71513a31c01a428bccd5367a32fd95f115d6dac50fb5b60c779d5c7942aec071'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71a07dc54be7bbd21105ee89243e5b9e4687ac9f2f47fba61449005e00eca2c4',
     armv7l: '71a07dc54be7bbd21105ee89243e5b9e4687ac9f2f47fba61449005e00eca2c4',
       i686: '5bf079bf54015f8727cbdc44a2d73f5de914a6b94e3e1237030b355630d0d4ce',
     x86_64: '1553a96a54eb3480a4906eec597178d9cce561f2417d78315fead429a45c5fd8'
  })

  depends_on 'glibc' # R
  depends_on 'llvm_dev' => :build

  conflicts_ok

  # ENV['CREW_LINKER'] = 'lld'
  # run_tests
end
