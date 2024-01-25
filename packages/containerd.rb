# Adapted from Arch Linux containerd PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/containerd/trunk/PKGBUILD

require 'package'

class Containerd < Package
  description 'An open and reliable container runtime'
  homepage 'https://containerd.io/'
  version '1.7.1'
  license 'Apache'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/containerd/containerd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb5b1e4666a313f248520bd2c4dcb66afaebb17b48d51ca322f474613ada3c8a',
     armv7l: 'bb5b1e4666a313f248520bd2c4dcb66afaebb17b48d51ca322f474613ada3c8a',
     x86_64: '4a8b7f5420959e53972165503401fb9a69d87fcfd29d361ce4e589150d8674fe'
  })

  depends_on 'docker_systemctl_replacement'
  depends_on 'fuse_overlayfs'
  depends_on 'glibc' # R
  depends_on 'runc'
  depends_on 'go' => :build
  depends_on 'btrfsprogs' => :build
  depends_on 'libseccomp' => :build
  depends_on 'containers_common' => :build
  depends_on 'go_md2man' => :build

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

      # 'plugins."io.containerd.grpc.v1.cri".cni' contains config related to cni
          [plugins."io.containerd.grpc.v1.cri".cni]
            # bin_dir is the directory in which the binaries for the plugin is kept.
            bin_dir = "#{CREW_PREFIX}/cni/bin"

            # conf_dir is the directory in which the admin places a CNI conf.
            conf_dir = "#{CREW_PREFIX}/etc/cni/net.d"

            # max_conf_num specifies the maximum number of CNI plugin config files to
            # load from the CNI config directory. By default, only 1 CNI plugin config
            # file will be loaded. If you want to load multiple CNI plugin config files
            # set max_conf_num to the number desired. Setting max_config_num to 0 is
            # interpreted as no limit is desired and will result in all CNI plugin
            # config files being loaded from the CNI config directory.
            max_conf_num = 1

            # conf_template is the file path of golang template used to generate
            # cni config.
            # If this is set, containerd will generate a cni config file from the
            # template. Otherwise, containerd will wait for the system admin or cni
            # daemon to drop the config file into the conf_dir.
            # This is a temporary backward-compatible solution for kubenet users
            # who don't have a cni daemonset in production yet.
            # This will be deprecated when kubenet is deprecated.
            # See the "CNI Config Template" section for more details.
            conf_template = ""
            # ip_pref specifies the strategy to use when selecting the main IP address for a pod.
            # options include:
            # * ipv4, "" - (default) select the first ipv4 address
            # * ipv6 - select the first ipv6 address
            # * cni - use the order returned by the CNI plugins, returning the first IP address from the results
            ip_pref = "ipv4"

          # 'plugins."io.containerd.grpc.v1.cri".image_decryption' contains config related
          # to handling decryption of encrypted container images.
          [plugins."io.containerd.grpc.v1.cri".image_decryption]
            # key_model defines the name of the key model used for how the cri obtains
            # keys used for decryption of encrypted container images.
            # The [decryption document](https://github.com/containerd/containerd/blob/main/docs/cri/decryption.md)
            # contains additional information about the key models available.
            #
            # Set of available string options: {"", "node"}
            # Omission of this field defaults to the empty string "", which indicates no key model,
            # disabling image decryption.
            #
            # In order to use the decryption feature, additional configurations must be made.
            # The [decryption document](https://github.com/containerd/containerd/blob/main/docs/cri/decryption.md)
            # provides information of how to set up stream processors and the containerd imgcrypt decoder
            # with the appropriate key models.
            #
            # Additional information:
            # * Stream processors: https://github.com/containerd/containerd/blob/main/docs/stream_processors.md
            # * Containerd imgcrypt: https://github.com/containerd/imgcrypt
            key_model = "node"

          # 'plugins."io.containerd.grpc.v1.cri".registry' contains config related to
          # the registry
          [plugins."io.containerd.grpc.v1.cri".registry]
            # config_path specifies a directory to look for the registry hosts configuration.
            #
            # The cri plugin will look for and use config_path/host-namespace/hosts.toml
            #   configs if present OR load certificate files as laid out in the Docker/Moby
            #   specific layout https://docs.docker.com/engine/security/certificates/
            #
            # If config_path is not provided defaults are used.
            #
            # *** registry.configs and registry.mirrors that were a part of containerd 1.4
            # are now DEPRECATED and will only be used if the config_path is not specified.
            config_path = ""
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
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.install 'config.toml', "#{CREW_DEST_PREFIX}/etc/containerd/config.toml", mode: 0o644
    FileUtils.install 'config.toml', "#{CREW_DEST_PREFIX}/etc/containerd/debug.toml", mode: 0o644
    FileUtils.install 'containerd.service', "#{CREW_DEST_PREFIX}/.config/systemd/user/containerd.service", mode: 0o644
    FileUtils.install Dir['man/*.5'], "#{CREW_DEST_MAN_PREFIX}/man5/", mode: 0o644
    FileUtils.install Dir['man/*.8'], "#{CREW_DEST_MAN_PREFIX}/man8/", mode: 0o644
  end
end
