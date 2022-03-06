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
    aarch64: '8cff65fb4f5cae37d3c5a02adaca91828acd2278cd28ecc69ecec0c0ce3b8ef1',
     armv7l: '8cff65fb4f5cae37d3c5a02adaca91828acd2278cd28ecc69ecec0c0ce3b8ef1',
     x86_64: 'e0416b16cc9cad8052ce5f139d339ec766f26ef1a630e4cf44a37a160cbc45ec'
  })
  git_hashtag "v#{version}"

  depends_on 'docker_systemctl_replacement'
  depends_on 'runc'
  depends_on 'go' => ':build'
  depends_on 'btrfsprogs' => ':build'
  depends_on 'libseccomp' => ':build'
  depends_on 'containers_common' => ':build'
  depends_on 'go_md2man' => ':build'
  no_fhs

  def self.patch
    system "sed -i 's,/sbin,#{CREW_PREFIX}/bin,g' containerd.service"
    system "sed -i 's,TasksMax=,#TasksMax=,g' containerd.service"
    system "sed -i '/modprobe/d' containerd.service"
    system "sed -i 's,/run,/var/run/chrome,g' defaults/defaults_unix.go"
    system "sed -i 's,/var,#{CREW_PREFIX}/var,g' defaults/defaults_unix.go"
    system "sed -i 's,/etc,#{CREW_PREFIX}/etc,g' defaults/defaults_unix.go"
  end

  def self.build
    system "GOFLAGS='-trimpath -mod=readonly -modcacherw' make VERSION=v1.6.1 GO_BUILD_FLAGS='-trimpath -mod=readonly -modcacherw' GO_GCFLAGS= EXTRA_LDFLAGS='-buildid='"
    system "GOFLAGS='-trimpath -mod=readonly -modcacherw' make VERSION=v1.6.1 man"
  end

  def self.install
    FileUtils.mkdir_p %W[
      #{CREW_DEST_PREFIX}/.config/systemd/user
      #{CREW_DEST_MAN_PREFIX}/man5
      #{CREW_DEST_MAN_PREFIX}/man8
    ]
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.install 'containerd.service', "#{CREW_DEST_PREFIX}/.config/systemd/user/containerd.service", mode: 0o644
    FileUtils.install Dir['man/*.5'], "#{CREW_DEST_MAN_PREFIX}/man5", mode: 0o644
    FileUtils.install Dir['man/*.8'], "#{CREW_DEST_MAN_PREFIX}/man8", mode: 0o644
  end
end
