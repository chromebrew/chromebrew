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
    aarch64: 'a3463bf6ec42a9e8aadc258813e2ea0c7dd7653f731cff0013e49e14e654a61d',
     armv7l: 'a3463bf6ec42a9e8aadc258813e2ea0c7dd7653f731cff0013e49e14e654a61d',
     x86_64: '71cf3e1d3403473d6b2fc120ea7b4cfbad753023c33010457816e3f5632bfd50'
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

  no_fhs

  def self.patch
    system "sed -i 's,/usr/libexec/podman/catatonit,#{CREW_PREFIX}/bin/catatonit,g' vendor/github.com/containers/common/pkg/config/default.go"
    system "sed -i 's,/run/containers/storage,#{CREW_PREFIX}/var/run/containers/storage,g' vendor/github.com/containers/storage/storage.conf"
    system "sed -i 's,/var/lib/containers/storage,#{CREW_PREFIX}/var/lib/containers/storage,g' vendor/github.com/containers/storage/storage.conf"
    system "sed -i 's,\\$HOME/.local/share/containers/storage,#{CREW_PREFIX}/var/lib/containers/storage,g' vendor/github.com/containers/storage/storage.conf"
    system "sed -i 's,# rootless_storage_path,rootless_storage_path,g' vendor/github.com/containers/storage/storage.conf"
  end

  def self.build
    system "GOFLAGS='-buildmode=pie -trimpath' make EXTRA_LDFLAGS='-s -w -linkmode=external'"
    system 'make docker-docs'
  end

  def self.install
    @xdg_config_home = "#{CREW_DEST_PREFIX}/.config"
    FileUtils.mkdir_p %W[#{@xdg_config_home}/containers #{CREW_DEST_PREFIX}/var/run/containers/storage
                         #{CREW_DEST_PREFIX}/var/lib/containers/storage]
    FileUtils.install 'vendor/github.com/containers/storage/storage.conf', "#{@xdg_config_home}/containers/",
                      mode: 0o644
    system "make install install.completions install.docker-full DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} LIBEXECDIR=#{CREW_LIB_PREFIX}"
    # Remove conflicts with containers_common.
    FileUtils.remove_dir "#{CREW_DEST_MAN_PREFIX}/man5"
  end
end
