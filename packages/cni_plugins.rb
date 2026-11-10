# Adapted from Arch Linux cni-plugins PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cni-plugins/trunk/PKGBUILD

require 'package'

class Cni_plugins < Package
  description 'Some standard networking plugins, maintained by the CNI team'
  homepage 'https://github.com/containernetworking/plugins'
  version '1.10.0'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/containernetworking/plugins.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a8cfc02a1a1f96065661ee071cf02daecf82ee222fb43c0d3578b5b390ab7f2',
     armv7l: '6a8cfc02a1a1f96065661ee071cf02daecf82ee222fb43c0d3578b5b390ab7f2',
       i686: '7b8d78f611e92c7fee60d6d6e0903dad164f411768f24797b3718df830d97a19',
     x86_64: 'f48ad22f65cc4819bf28f854803a86787fa8799d9b58b91f83290a7218644333'
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
