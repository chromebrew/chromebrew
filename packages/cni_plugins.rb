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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cni_plugins/1.1.1_armv7l/cni_plugins-1.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cni_plugins/1.1.1_armv7l/cni_plugins-1.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cni_plugins/1.1.1_i686/cni_plugins-1.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cni_plugins/1.1.1_x86_64/cni_plugins-1.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ed64d05531ed07aeceb7fd839979dc30b310d286cd8b78ab024df944bae992cb',
     armv7l: 'ed64d05531ed07aeceb7fd839979dc30b310d286cd8b78ab024df944bae992cb',
       i686: '3d4b4bdae5e1390d49f7ec16de46ba44094f3de3908807100bed64b325b12a68',
     x86_64: 'e69d81655b9138e6723b438a1b880de35035f9e8bb349fa98bf4846f4a3a0833'
  })

  depends_on 'glibc'
  depends_on 'go' => :build

  def self.build
    system "GOFLAGS='-buildmode=pie -trimpath -mod=readonly -modcacherw' ./build_linux.sh"
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/etc/cni/net.d]
    FileUtils.install Dir['bin/*'], "#{CREW_DEST_PREFIX}/bin/", mode: 0o755
  end
end
