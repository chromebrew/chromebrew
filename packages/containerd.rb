# Adapted from Arch Linux containerd PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/containerd/trunk/PKGBUILD

require 'package'

class Containerd < Package
  description 'An open and reliable container runtime'
  homepage 'https://containerd.io/'
  version '1.6.1'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/containerd/containerd.git'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containerd/1.6.1_armv7l/containerd-1.6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containerd/1.6.1_armv7l/containerd-1.6.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containerd/1.6.1_x86_64/containerd-1.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3560445ba0e85f47cede9836cdcbfd34879251f60abb9ddb71cf8ad8e0cf403a',
     armv7l: '3560445ba0e85f47cede9836cdcbfd34879251f60abb9ddb71cf8ad8e0cf403a',
     x86_64: '6924a4ebf2d3f50a2e9d7f18e3c23a1733d9ad1441a5115e0810a070bc5a16e6'
  })

  git_hashtag "v#{version}"

  depends_on 'runc'
  depends_on 'go' => ':build'
  depends_on 'btrfsprogs' => ':build'
  depends_on 'libseccomp' => ':build'
  depends_on 'containers_common' => ':build'
  depends_on 'go_md2man' => ':build'

  def self.patch
    system "sed -i 's,/sbin,#{CREW_PREFIX}/bin,g' containerd.service"
  end

  def self.build
    system 'export '
    system "GOFLAGS='-trimpath -mod=readonly -modcacherw' make VERSION=v1.6.1 GO_BUILD_FLAGS='-trimpath -mod=readonly -modcacherw' GO_GCFLAGS= EXTRA_LDFLAGS='-buildid='"
    system "GOFLAGS='-trimpath -mod=readonly -modcacherw' make VERSION=v1.6.1 man"
  end

  def self.install
    FileUtils.mkdir_p %W[
      #{CREW_DEST_PREFIX}/etc/elogind
      #{CREW_DEST_MAN_PREFIX}/man5
      #{CREW_DEST_MAN_PREFIX}/man8
    ]
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
    system "install -Dm644 containerd.service #{CREW_DEST_PREFIX}/etc/elogind/containerd.service"
    system "install -Dm644 man/*.8 -t #{CREW_DEST_MAN_PREFIX}/man8"
    system "install -Dm644 man/*.5 -t #{CREW_DEST_MAN_PREFIX}/man5"
  end
end
