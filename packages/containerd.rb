# Adapted from Arch Linux containerd PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/containerd/trunk/PKGBUILD

require 'package'

class Containerd < Package
  description 'An open and reliable container runtime'
  homepage 'https://containerd.io/'
  version '1.6.1'
  compatibility 'all'
  license 'Apache'
  source_url 'https://github.com/containerd/containerd.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containerd/1.6.1_armv7l/containerd-1.6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containerd/1.6.1_armv7l/containerd-1.6.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containerd/1.6.1_x86_64/containerd-1.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3dba84f318f5cf7afc5ae8e2180a1f0cc932c2f5be9421ae02b284068141fe49',
     armv7l: '3dba84f318f5cf7afc5ae8e2180a1f0cc932c2f5be9421ae02b284068141fe49',
     x86_64: '9c54047cf84e44409c7d15d301a3fd260863b9e6ac3295303eb0ece54e010c8f'
  })

  depends_on 'docker_systemctl_replacement'
  depends_on 'fuse_overlayfs'
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
    system "GOFLAGS='-trimpath -mod=readonly -modcacherw' make VERSION=v#{version} GO_BUILD_FLAGS='-trimpath -mod=readonly -modcacherw' GO_GCFLAGS= EXTRA_LDFLAGS='-buildid='"
    system "GOFLAGS='-trimpath -mod=readonly -modcacherw' make VERSION=v#{version} man"
    @config_toml = <<~CONFIG_TOML_EOF
      version = 2
      root = "#{CREW_PREFIX}/.local/share/containerd"
      state = "/var/run/chrome/containerd"

      [grpc]
        address = "/var/run/chrome/containerd/containerd.sock"

      [proxy_plugins]
        [proxy_plugins."fuse-overlayfs"]
          type = "snapshot"
          address = "/var/run/chrome/containerd/fuse-overlayfs.sock"
    CONFIG_TOML_EOF
    File.write('config.toml', @config_toml)
    # system "sed -i 's,/var,#{CREW_PREFIX}/var,g' config.toml"
    # system "sed -i 's,/run,/var/run/chrome,g' config.toml"
    # system "sed -i 's,/etc,#{CREW_PREFIX}/etc,g' config.toml"
    # system "sed -i 's,/opt,#{CREW_PREFIX}/opt,g' config.toml"
    # case ARCH
    # when 'armv7l', 'aarch64'
    # @docker_platform = 'linux/arm/v7'
    # when 'x86_64'
    # @docker_platform = 'linux/amd64'
    # end
    # system "sed -i 's,linux/amd64,#{@docker_platform},g' config.toml"
  end

  def self.install
    FileUtils.mkdir_p %W[
      #{CREW_DEST_PREFIX}/.config/systemd/user
      #{CREW_DEST_PREFIX}/etc/containerd/certs.d
      #{CREW_DEST_MAN_PREFIX}/man5
      #{CREW_DEST_MAN_PREFIX}/man8
    ]
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.install 'config.toml', "#{CREW_DEST_PREFIX}/etc/containerd/config.toml", mode: 0o644
    FileUtils.install 'config.toml', "#{CREW_DEST_PREFIX}/etc/containerd/debug.toml", mode: 0o644
    FileUtils.install 'containerd.service', "#{CREW_DEST_PREFIX}/.config/systemd/user/containerd.service", mode: 0o644
    FileUtils.install Dir['man/*.5'], "#{CREW_DEST_MAN_PREFIX}/man5", mode: 0o644
    FileUtils.install Dir['man/*.8'], "#{CREW_DEST_MAN_PREFIX}/man8", mode: 0o644
  end
end
