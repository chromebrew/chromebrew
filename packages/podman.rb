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
     aarch64: 'file:///usr/local/tmp/packages/podman-4.3.1-chromeos-armv7l.tar.zst',
      armv7l: 'file:///usr/local/tmp/packages/podman-4.3.1-chromeos-armv7l.tar.zst',
      x86_64: 'file:///usr/local/tmp/packages/podman-4.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
     aarch64: '4822a910ceafb2f407c8074e6a80fe0cf49898956691608685dd14d4261c4832',
      armv7l: '4822a910ceafb2f407c8074e6a80fe0cf49898956691608685dd14d4261c4832',
      x86_64: 'ae4c383f25fb63d92f505c830cd1788660b2d351433454e4352ffdd47413270a'
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
    system "sed -i 's,/run/containers/storage,#{CREW_PREFIX}/var/run/containers/storage,g' vendor/github.com/containers/storage/storage.conf"
    system "sed -i 's,/var/lib/containers/storage,#{CREW_PREFIX}/var/lib/containers/storage,g' vendor/github.com/containers/storage/storage.conf"
    system "sed -i 's,\\$HOME/.local/share/containers/storage,#{CREW_PREFIX}/var/lib/containers/storage,g' vendor/github.com/containers/storage/storage.conf"
    system "sed -i 's,# rootless_storage_path,rootless_storage_path,g' vendor/github.com/containers/storage/storage.conf"
    system "sed -i 's,PREFIX ?= /usr/local,PREFIX = #{CREW_PREFIX},' Makefile"
  end

  def self.build
    system "GOFLAGS='-buildmode=pie -trimpath' BUILDTAGS="" make EXTRA_LDFLAGS='-s -w -linkmode=external'"
    system 'make docker-docs'
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_PREFIX}/etc/containers #{CREW_DEST_PREFIX}/var/run/containers/storage
                         #{CREW_DEST_PREFIX}/var/lib/containers/storage]
    FileUtils.install 'vendor/github.com/containers/storage/storage.conf', "#{CREW_PREFIX}/etc/containers/",
                      mode: 0o644
    system "make install install.completions install.docker-full DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} LIBEXECDIR=#{CREW_LIB_PREFIX}"
    # Remove conflicts with containers_common.
    FileUtils.remove_dir "#{CREW_DEST_MAN_PREFIX}/man5"
  end
end
