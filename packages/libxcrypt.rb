require 'buildsystems/autotools'

class Libxcrypt < Autotools
  description 'Modern library for one-way hashing of passwords'
  homepage 'https://github.com/besser82/libxcrypt/'
  version '4.5.1-1'
  license 'LGPL-2.1+, public-domain, BSD and BSD-2'
  compatibility 'all'
  source_url "https://github.com/besser82/libxcrypt/releases/download/v#{version.split('-').first}/libxcrypt-#{version.split('-').first}.tar.xz"
  source_sha256 'e9b46a62397c15372935f6a75dc3929c62161f2620be7b7f57f03d69102c1a86'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c918ceb9e8fcf139ad62088e0544362b4719f8b7e78073e7c2954b668d25e1c',
     armv7l: '0c918ceb9e8fcf139ad62088e0544362b4719f8b7e78073e7c2954b668d25e1c',
       i686: 'b26af1777dfb19b7ca6bf71f1d41c7fa8da9b16e0224b01c16fdf0f0c6edbce2',
     x86_64: '07a0f00b62f322e9dedea378b300933163ecf067e9f334c33399428b084d6a4c'
  })

  depends_on 'glibc' # R
  depends_on 'llvm_dev' => :build

  conflicts_ok

  # Handle https://github.com/besser82/libxcrypt/issues/181
  # ENV['CREW_LINKER_FLAGS'] = '-Wl,--undefined-version'
  ENV['CREW_LINKER'] = 'lld'
  # run_tests
end
