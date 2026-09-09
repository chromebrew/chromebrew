# Adapted from Arch Linux cni-plugins PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cni-plugins/trunk/PKGBUILD

require 'package'

class Cni_plugins < Package
  description 'Some standard networking plugins, maintained by the CNI team'
  homepage 'https://github.com/containernetworking/plugins'
  version '1.9.1'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/containernetworking/plugins.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b25924449171e9153f631a401a2ae5ff74ea64dced8c943b21fb6a9ea7c058b1',
     armv7l: 'b25924449171e9153f631a401a2ae5ff74ea64dced8c943b21fb6a9ea7c058b1',
       i686: 'c637884b6397e6f2351a9db7503df3c0600be039bb06939bd0c769ca90b06992',
     x86_64: 'ca587f79133f70df7808ebce625437c8444c99f5e850bfc7fd17d73683ae34f2'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.build
    system "GOFLAGS='-buildmode=pie -trimpath -mod=readonly -modcacherw' ./build_linux.sh"
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/libexec/cni #{CREW_DEST_PREFIX}/etc/cni/net.d]
    FileUtils.install Dir['bin/*'], "#{CREW_DEST_PREFIX}/libexec/cni/", mode: 0o755
  end
end
