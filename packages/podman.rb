# Adapted from Arch Linux podman PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/podman/trunk/PKGBUILD

require 'package'

class Podman < Package
  description 'Tool and library for running OCI-based containers in pods'
  homepage 'https://github.com/containers/podman'
  version '4.3.1'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/containers/podman.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podman/4.3.1_armv7l/podman-4.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podman/4.3.1_armv7l/podman-4.3.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podman/4.3.1_x86_64/podman-4.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c79e7fb8fb5a07d63f0adae358673b6c3ee71d5061cf16678fff89f386b76887',
     armv7l: 'c79e7fb8fb5a07d63f0adae358673b6c3ee71d5061cf16678fff89f386b76887',
     x86_64: 'fc321157beacd2d9ee9f3699f2a0c33eb38418e3e36b8118f9525e83d8fab129'
  })

  depends_on 'btrfsprogs' => :build
  depends_on 'catatonit'
  depends_on 'containers_common' # L
  depends_on 'fuse_overlayfs' # L
  depends_on 'glibc' # R
  depends_on 'go' => :build
  depends_on 'go_md2man' => :build
  depends_on 'gpgme' # R
  depends_on 'libseccomp' # R
  depends_on 'lvm2' # R

  no_fhs

  def self.patch
    system "sed -i 's,/usr/libexec/podman/catatonit,#{CREW_PREFIX}/bin/catatonit,g' vendor/github.com/containers/common/pkg/config/default.go"
    system "sed -i 's,PREFIX ?= /usr/local,PREFIX = #{CREW_PREFIX},' Makefile"
  end

  def self.build
    system "GOFLAGS='-buildmode=pie -trimpath' BUILDTAGS="" make EXTRA_LDFLAGS='-s -w -linkmode=external -X github.com/containers/image/signature.systemDefaultPolicyPath=#{CREW_PREFIX}/etc/containers/policy.json'"
    system 'make docker-docs'
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/var/run/containers/storage #{CREW_DEST_PREFIX}/var/lib/containers/storage]
    system "make install install.completions install.docker-full DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} LIBEXECDIR=#{CREW_LIB_PREFIX}"
    # Remove conflicts with containers_common.
    FileUtils.remove_dir "#{CREW_DEST_MAN_PREFIX}/man5"
  end
end
