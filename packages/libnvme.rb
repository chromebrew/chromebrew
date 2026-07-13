require 'buildsystems/meson'

class Libnvme < Meson
  description 'C Library for NVM Express on Linux'
  homepage 'https://github.com/linux-nvme/libnvme'
  version '1.16.2'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/linux-nvme/libnvme.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7cb55bea629bbdd33aa3d8b92f7e81fce275449713df7ddca6e01db09e4a953',
     armv7l: 'd7cb55bea629bbdd33aa3d8b92f7e81fce275449713df7ddca6e01db09e4a953',
       i686: '772af78edf394fbc1b751a9957fff0f6bf2a1ed9b1a28b345b747393d7641c63',
     x86_64: 'c166c03c89208b9fd78bce15bc0ddeb35284640909ee4ed6f9f6baa9e96dc8d6'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'json_c' => :library
  depends_on 'keyutils' => :library
  depends_on 'ninja' => :build
  depends_on 'openssl' => :library
  depends_on 'swig' => :build
end
