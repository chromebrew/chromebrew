require 'buildsystems/autotools'

class Ragel < Autotools
  description 'Compiles finite state machines from regular languages into executable C, C++, Objective-C, or D code.'
  homepage 'https://www.colm.net/open-source/ragel/'
  version '6.10-1'
  license 'GPL-2.0-only'
  compatibility 'all'
  source_url 'https://www.colm.net/files/ragel/ragel-6.10.tar.gz'
  source_sha256 '5f156edb65d20b856d638dd9ee2dfb43285914d9aa2b6ec779dac0270cd56c3f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '505c0dd59b1cc6506218cf87d627245d6446053d06757dd219f594e99b465dd8',
     armv7l: '505c0dd59b1cc6506218cf87d627245d6446053d06757dd219f594e99b465dd8',
       i686: '555b423d1e7538943278f40d7675bd54b72eda2fc030fe8fb6f8a39a9c983542',
     x86_64: 'bb30efaddb9102e6acdbe547419fbe4dada8b3e7a508510ea68b828e718e8b55'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  autotools_pre_configure_options "CFLAGS+=' -std=gnu++98' CXXFLAGS+=' -std=gnu++98'"
end
