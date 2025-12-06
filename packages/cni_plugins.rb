# Adapted from Arch Linux cni-plugins PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cni-plugins/trunk/PKGBUILD

require 'package'

class Cni_plugins < Package
  description 'Some standard networking plugins, maintained by the CNI team'
  homepage 'https://github.com/containernetworking/plugins'
  version '1.6.2'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/containernetworking/plugins.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5e8bb6a459fe950f328dd1241aa76e684443240b2116edf4f73d98c5ab0ab69',
     armv7l: 'c5e8bb6a459fe950f328dd1241aa76e684443240b2116edf4f73d98c5ab0ab69',
       i686: 'b910ed5dd9fa300896f244df44bfa03cc2c81f56963b4f1612aa41707453e7be',
     x86_64: '97c4a904b8380f50a07a4154fb54bbe967b78629b627f11e540894643c6dc90b'
  })

  depends_on 'glibc'
  depends_on 'go' => :build

  def self.build
    system "GOFLAGS='-buildmode=pie -trimpath -mod=readonly -modcacherw' ./build_linux.sh"
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/libexec/cni #{CREW_DEST_PREFIX}/etc/cni/net.d]
    FileUtils.install Dir['bin/*'], "#{CREW_DEST_PREFIX}/libexec/cni/", mode: 0o755
  end
end
