# Adapted from Arch Linux cni-plugins PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cni-plugins/trunk/PKGBUILD

require 'package'

class Cni_plugins < Package
  description 'Some standard networking plugins, maintained by the CNI team'
  homepage 'https://github.com/containernetworking/plugins'
  version '1.1.1'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/containernetworking/plugins.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cni_plugins/1.1.1_armv7l/cni_plugins-1.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cni_plugins/1.1.1_armv7l/cni_plugins-1.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cni_plugins/1.1.1_i686/cni_plugins-1.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cni_plugins/1.1.1_x86_64/cni_plugins-1.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3b8fda3df8740b15ee87fe6d993525b8b8ef17371e18bfde042e4212646ac05f',
     armv7l: '3b8fda3df8740b15ee87fe6d993525b8b8ef17371e18bfde042e4212646ac05f',
       i686: 'a8d8248955525a82f0e5a4be964e001829fa9f904b3c9a996046a0fff97d1981',
     x86_64: 'fd612dffe632d8d6933a3a77e54276cdb755c103a75727008452a497c90f4736'
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
