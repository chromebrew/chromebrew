require 'buildsystems/autotools'

class Lvm2 < Autotools
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.03.23'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://mirrors.kernel.org/sourceware/lvm2/LVM2.2.03.23.tgz'
  source_sha256 '74e794a9e9dee1bcf8a2065f65b9196c44fdf321e22d63b98ed7de8c9aa17a5d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9354ed80514c7cbedea66c76806d8de49b0b5e55960ac1e44a7f97446844344c',
     armv7l: '9354ed80514c7cbedea66c76806d8de49b0b5e55960ac1e44a7f97446844344c',
       i686: '8ca10b4b08ac1e7a541653c11ac747a5525cabb97da90651f123afd80ad32b3a',
     x86_64: '6dc2b5060e3747e6d19e87433a7033a385a5973caa7fe476b4da3e033096d587'
  })

  depends_on 'glibc' # R
  depends_on 'libaio' # R
  depends_on 'readline' # R
  depends_on 'util_linux' # R

  configure_options "--localstatedir=#{CREW_PREFIX}/var \
    --disable-selinux \
    --enable-cmdlib \
    --enable-dmeventd \
    --enable-pkgconfig \
    --enable-readline \
    --with-cache=internal \
    --with-thin=internal \
    --with-confdir=#{CREW_PREFIX}/etc"
end
