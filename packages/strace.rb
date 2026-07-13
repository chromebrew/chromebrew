require 'buildsystems/autotools'

class Strace < Autotools
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '7.1'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://strace.io/files/#{version}/strace-#{version}.tar.xz"
  source_sha256 '81743ecf2a5b44186b2f5038afdc8beda7e5c70aed15b4fbfbcc6e9ece24490f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '935e8d41515687a095c606465e2ab1bd2d5f1c2f3c0c18bb33f2c33673d98294',
     armv7l: '935e8d41515687a095c606465e2ab1bd2d5f1c2f3c0c18bb33f2c33673d98294',
     x86_64: '36a65c0b4e9ff25200f7704b643de3e697ba6181afc03ca69f32d27926b5d945'
  })

  depends_on 'elfutils' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_configure_options '--disable-mpers --with-libdw --disable-gcc-Werror'
end
