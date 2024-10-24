# Adapted from Arch Linux podman PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/podman/trunk/PKGBUILD

require 'package'

class Podman < Package
  description 'Tool and library for running OCI-based containers in pods'
  homepage 'https://github.com/containers/podman'
  version '4.3.1'
  license 'Apache'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/containers/podman.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podman/4.3.1_armv7l/podman-4.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podman/4.3.1_armv7l/podman-4.3.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podman/4.3.1_x86_64/podman-4.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b166c1c4338769091181209f5801f1b7325eac547297dc07da630263ac03b703',
     armv7l: 'b166c1c4338769091181209f5801f1b7325eac547297dc07da630263ac03b703',
     x86_64: '1ffe8267bbe498d594766cc7a6a229650c9b33c955194309651fccb20c56bafe'
  })

  depends_on 'btrfsprogs' => :build
  depends_on 'catatonit' # L
  depends_on 'cni_plugins' # L
  depends_on 'containers_common' # L
  depends_on 'fuse_overlayfs' # L
  depends_on 'glibc' # R
  depends_on 'go' => :build
  depends_on 'go_md2man' => :build
  depends_on 'gpgme' # R
  depends_on 'libseccomp' # R
  depends_on 'lvm2' # R
  depends_on 'runc' # L

  no_fhs

  def self.patch
    system "sed -i 's,/usr/libexec/podman/catatonit,#{CREW_PREFIX}/bin/catatonit,g' vendor/github.com/containers/common/pkg/config/default.go"
    system "sed -i 's,/etc/containers/policy.json,#{CREW_PREFIX}/etc/containers/policy.json,' vendor/github.com/containers/image/v5/signature/policy_paths_common.go"
    system "sed -i 's,/etc/containers/registries.conf,#{CREW_PREFIX}/etc/containers/registries.conf,' vendor/github.com/containers/image/v5/pkg/sysregistriesv2/paths_common.go"
    system "sed -i 's,/etc/containers/registries.conf.d,#{CREW_PREFIX}/etc/containers/registries.conf.d,' vendor/github.com/containers/image/v5/pkg/sysregistriesv2/paths_common.go"
    system "sed -i 's,/etc/containers/storage.conf,#{CREW_PREFIX}/etc/containers/storage.conf,' vendor/github.com/containers/storage/types/options_linux.go"
    system "sed -i 's,/etc/cni/net.d/,#{CREW_PREFIX}/etc/cni/net.d/,' vendor/github.com/containers/common/libnetwork/network/interface_linux.go"
    system "sed -i 's,/etc/containers/networks,#{CREW_PREFIX}/etc/containers/networks,' vendor/github.com/containers/common/libnetwork/network/interface_linux.go"
    system "sed -i 's,PREFIX ?= /usr/local,PREFIX = #{CREW_PREFIX},' Makefile"
  end

  def self.build
    system "GOFLAGS='-buildmode=pie -trimpath' BUILDTAGS='seccomp' make EXTRA_LDFLAGS='-s -w -linkmode=external -X github.com/containers/image/signature.systemDefaultPolicyPath=#{CREW_PREFIX}/etc/containers/policy.json'"
    system 'make docker-docs'
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/var/run/containers/storage #{CREW_DEST_PREFIX}/var/lib/containers/storage]
    system "make install install.completions install.docker-full DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} LIBEXECDIR=#{CREW_LIB_PREFIX}"
    # Remove conflicts with containers_common.
    FileUtils.remove_dir "#{CREW_DEST_MAN_PREFIX}/man5"
  end
end
