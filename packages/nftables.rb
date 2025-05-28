# Adapted from Arch Linux nftables PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nftables/trunk/PKGBUILD

require 'buildsystems/autotools'

class Nftables < Autotools
  description 'Netfilter tables userspace tools'
  homepage 'https://netfilter.org/projects/nftables/'
  version '1.1.3'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://netfilter.org/projects/nftables/files/nftables-#{version}.tar.xz"
  source_sha256 '9c8a64b59c90b0825e540a9b8fcb9d2d942c636f81ba50199f068fde44f34ed8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8606a5a73a8705fe5ae9e58589b8046adef8a36bd00fa07dbe7eb404f7718cf0',
     armv7l: '8606a5a73a8705fe5ae9e58589b8046adef8a36bd00fa07dbe7eb404f7718cf0',
     x86_64: 'dd8fa408d9ecf3557c7125cc73eab5211f080e6602e3dc34d23aef2aaf9fb89f'
  })

  depends_on 'py3_asciidoc' => :build
  depends_on 'glibc' # R
  depends_on 'jansson' # R
  depends_on 'libmnl' # R
  depends_on 'libnftnl' # R
  depends_on 'readline' # R

  autotools_configure_options "--sysconfdir=#{CREW_PREFIX}/etc \
    --with-json \
    --with-cli=readline \
    --with-mini-gmp \
    --disable-debug"

  run_tests
end
