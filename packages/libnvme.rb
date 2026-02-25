require 'buildsystems/meson'

class Libnvme < Meson
  description 'C Library for NVM Express on Linux'
  homepage 'https://github.com/linux-nvme/libnvme'
  version '1.16.1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/linux-nvme/libnvme.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8cf621b544c287e861bda78085c56ed25e92ba0220d21c635049d567de21edea',
     armv7l: '8cf621b544c287e861bda78085c56ed25e92ba0220d21c635049d567de21edea',
       i686: 'b729bb41314826aaf5de0765a146039f018c9e442deae8d3e3601b52b6f7afa6',
     x86_64: '82cdb94f3c58c2961d9bd84cc5c9a038742febc24a734b28d0c924f6eaeb59e3'
  })

  depends_on 'glibc' # R
  depends_on 'json_c' # R
  depends_on 'keyutils' # R
  depends_on 'ninja' => :build
  depends_on 'openssl' # R
  depends_on 'swig' => :build
end
