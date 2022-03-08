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
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containerd/1.6.1_armv7l/containerd-1.6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containerd/1.6.1_armv7l/containerd-1.6.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containerd/1.6.1_x86_64/containerd-1.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd19580d750ecb5826eb5cacc1c623ecd2671d9d4cb1f75316c36e3c2a9336244',
     armv7l: 'd19580d750ecb5826eb5cacc1c623ecd2671d9d4cb1f75316c36e3c2a9336244',
     x86_64: '2afe2483029684e22b3090529a0b345c52b0d98605df7811656529b9fffcf81d'
  })

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
    @config_toml = <<~'CONFIG_TOML_EOF'
      root = "/var/lib/containerd"
      state = "/run/containerd"
      oom_score = 0
      imports = ["/etc/containerd/runtime_*.toml", "./debug.toml"]

      [grpc]
        address = "/run/containerd/containerd.sock"
        uid = 0
        gid = 0

      [debug]
        address = "/run/containerd/debug.sock"
        uid = 0
        gid = 0
        level = "info"

      [metrics]
        address = ""
        grpc_histogram = false

      [cgroup]
        path = ""

      [plugins]
        [plugins.cgroups]
          no_prometheus = false
        [plugins.diff]
          default = ["walking"]
        [plugins.linux]
          shim = "containerd-shim"
          runtime = "runc"
          runtime_root = ""
          no_shim = false
          shim_debug = false
        [plugins.scheduler]
          pause_threshold = 0.02
          deletion_threshold = 0
          mutation_threshold = 100
          schedule_delay = 0
          startup_delay = "100ms"
        [plugins."io.containerd.runtime-shim.v2.shim"]
          platforms = ["linux/amd64"]
          sched_core = true
        [plugins."io.containerd.service.v1.tasks-service"]
          rdt_config_file = "/etc/rdt-config.yaml"
      # Use config version 2 to enable new configuration fields.
      # Config file is parsed as version 1 by default.
      # Version 2 uses long plugin names, i.e. "io.containerd.grpc.v1.cri" vs "cri".
      version = 2

      # The 'plugins."io.containerd.grpc.v1.cri"' table contains all of the server options.
      [plugins."io.containerd.grpc.v1.cri"]

        # disable_tcp_service disables serving CRI on the TCP server.
        # Note that a TCP server is enabled for containerd if TCPAddress is set in section [grpc].
        disable_tcp_service = true

        # stream_server_address is the ip address streaming server is listening on.
        stream_server_address = "127.0.0.1"

        # stream_server_port is the port streaming server is listening on.
        stream_server_port = "0"

        # stream_idle_timeout is the maximum time a streaming connection can be
        # idle before the connection is automatically closed.
        # The string is in the golang duration format, see:
        #   https://golang.org/pkg/time/#ParseDuration
        stream_idle_timeout = "4h"

        # enable_selinux indicates to enable the selinux support.
        enable_selinux = false

        # selinux_category_range allows the upper bound on the category range to be set.
        # if not specified or set to 0, defaults to 1024 from the selinux package.
        selinux_category_range = 1024

        # sandbox_image is the image used by sandbox container.
        sandbox_image = "k8s.gcr.io/pause:3.6"

        # stats_collect_period is the period (in seconds) of snapshots stats collection.
        stats_collect_period = 10

        # enable_tls_streaming enables the TLS streaming support.
        # It generates a self-sign certificate unless the following x509_key_pair_streaming are both set.
        enable_tls_streaming = false

        # tolerate_missing_hugetlb_controller if set to false will error out on create/update
        # container requests with huge page limits if the cgroup controller for hugepages is not present.
        # This helps with supporting Kubernetes <=1.18 out of the box. (default is `true`)
        tolerate_missing_hugetlb_controller = true

        # ignore_image_defined_volumes ignores volumes defined by the image. Useful for better resource
      	# isolation, security and early detection of issues in the mount configuration when using
      	# ReadOnlyRootFilesystem since containers won't silently mount a temporary volume.
        ignore_image_defined_volumes = false

        # netns_mounts_under_state_dir places all mounts for network namespaces under StateDir/netns
        # instead of being placed under the hardcoded directory /var/run/netns. Changing this setting
        # requires that all containers are deleted.
        netns_mounts_under_state_dir = false

        # 'plugins."io.containerd.grpc.v1.cri".x509_key_pair_streaming' contains a x509 valid key pair to stream with tls.
        [plugins."io.containerd.grpc.v1.cri".x509_key_pair_streaming]
          # tls_cert_file is the filepath to the certificate paired with the "tls_key_file"
          tls_cert_file = ""

          # tls_key_file is the filepath to the private key paired with the "tls_cert_file"
          tls_key_file = ""

        # max_container_log_line_size is the maximum log line size in bytes for a container.
        # Log line longer than the limit will be split into multiple lines. -1 means no
        # limit.
        max_container_log_line_size = 16384

        # disable_cgroup indicates to disable the cgroup support.
        # This is useful when the daemon does not have permission to access cgroup.
        disable_cgroup = false

        # disable_apparmor indicates to disable the apparmor support.
        # This is useful when the daemon does not have permission to access apparmor.
        disable_apparmor = false

        # restrict_oom_score_adj indicates to limit the lower bound of OOMScoreAdj to
        # the containerd's current OOMScoreAdj.
        # This is useful when the containerd does not have permission to decrease OOMScoreAdj.
        restrict_oom_score_adj = false

        # max_concurrent_downloads restricts the number of concurrent downloads for each image.
        max_concurrent_downloads = 3

        # disable_proc_mount disables Kubernetes ProcMount support. This MUST be set to `true`
        # when using containerd with Kubernetes <=1.11.
        disable_proc_mount = false

        # unset_seccomp_profile is the seccomp profile containerd/cri will use if the seccomp
        # profile requested over CRI is unset (or nil) for a pod/container (otherwise if this field is not set the
        # default unset profile will map to `unconfined`)
          # Note: The default unset seccomp profile should not be confused with the seccomp profile
          # used in CRI when the runtime default seccomp profile is requested. In the later case, the
          # default is set by the following code (https://github.com/containerd/containerd/blob/main/contrib/seccomp/seccomp_default.go).
          # To summarize, there are two different seccomp defaults, the unset default used when the CRI request is
          # set to nil or `unconfined`, and the default used when the runtime default seccomp profile is requested.
        unset_seccomp_profile = ""

        # enable_unprivileged_ports configures net.ipv4.ip_unprivileged_port_start=0
        # for all containers which are not using host network
        # and if it is not overwritten by PodSandboxConfig
        # Note that currently default is set to disabled but target change it in future, see:
        #   [k8s discussion](https://github.com/kubernetes/kubernetes/issues/102612)
        enable_unprivileged_ports = false

        # enable_unprivileged_icmp configures net.ipv4.ping_group_range="0 2147483647"
        # for all containers which are not using host network, are not running in user namespace
        # and if it is not overwritten by PodSandboxConfig
        # Note that currently default is set to disabled but target change it in future together with enable_unprivileged_ports
        enable_unprivileged_icmp = false

        # 'plugins."io.containerd.grpc.v1.cri".containerd' contains config related to containerd
        [plugins."io.containerd.grpc.v1.cri".containerd]

          # snapshotter is the snapshotter used by containerd.
          snapshotter = "overlayfs"

          # no_pivot disables pivot-root (linux only), required when running a container in a RamDisk with runc.
          # This only works for runtime type "io.containerd.runtime.v1.linux".
          no_pivot = false

          # disable_snapshot_annotations disables to pass additional annotations (image
          # related information) to snapshotters. These annotations are required by
          # stargz snapshotter (https://github.com/containerd/stargz-snapshotter)
          # changed to default true with https://github.com/containerd/containerd/pull/4665 and subsequent service refreshes.
          disable_snapshot_annotations = true

          # discard_unpacked_layers allows GC to remove layers from the content store after
          # successfully unpacking these layers to the snapshotter.
          discard_unpacked_layers = false

          # default_runtime_name is the default runtime name to use.
          default_runtime_name = "runc"

          # ignore_rdt_not_enabled_errors disables RDT related errors when RDT
          # support has not been enabled. Intel RDT is a technology for cache and
          # memory bandwidth management. By default, trying to set the RDT class of
          # a container via annotations produces an error if RDT hasn't been enabled.
          # This config option practically enables a "soft" mode for RDT where these
          # errors are ignored and the container gets no RDT class.
          ignore_rdt_not_enabled_errors = false

          # 'plugins."io.containerd.grpc.v1.cri".containerd.default_runtime' is the runtime to use in containerd.
          # DEPRECATED: use `default_runtime_name` and `plugins."io.containerd.grpc.v1.cri".containerd.runtimes` instead.
          [plugins."io.containerd.grpc.v1.cri".containerd.default_runtime]

          # 'plugins."io.containerd.grpc.v1.cri".containerd.untrusted_workload_runtime' is a runtime to run untrusted workloads on it.
          # DEPRECATED: use `untrusted` runtime in `plugins."io.containerd.grpc.v1.cri".containerd.runtimes` instead.
          [plugins."io.containerd.grpc.v1.cri".containerd.untrusted_workload_runtime]

          # 'plugins."io.containerd.grpc.v1.cri".containerd.runtimes' is a map from CRI RuntimeHandler strings, which specify types
          # of runtime configurations, to the matching configurations.
          # In this example, 'runc' is the RuntimeHandler string to match.
          [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
            # runtime_type is the runtime type to use in containerd.
            # The default value is "io.containerd.runc.v2" since containerd 1.4.
            # The default value was "io.containerd.runc.v1" in containerd 1.3, "io.containerd.runtime.v1.linux" in prior releases.
            runtime_type = "io.containerd.runc.v2"

            # pod_annotations is a list of pod annotations passed to both pod
            # sandbox as well as container OCI annotations. Pod_annotations also
            # supports golang path match pattern - https://golang.org/pkg/path/#Match.
            # e.g. ["runc.com.*"], ["*.runc.com"], ["runc.com/*"].
            #
            # For the naming convention of annotation keys, please reference:
            # * Kubernetes: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/#syntax-and-character-set
            # * OCI: https://github.com/opencontainers/image-spec/blob/master/annotations.md
            pod_annotations = []

            # container_annotations is a list of container annotations passed through to the OCI config of the containers.
            # Container annotations in CRI are usually generated by other Kubernetes node components (i.e., not users).
            # Currently, only device plugins populate the annotations.
            container_annotations = []

            # privileged_without_host_devices allows overloading the default behaviour of passing host
            # devices through to privileged containers. This is useful when using a runtime where it does
            # not make sense to pass host devices to the container when privileged. Defaults to false -
            # i.e pass host devices through to privileged containers.
            privileged_without_host_devices = false

            # base_runtime_spec is a file path to a JSON file with the OCI spec that will be used as the base spec that all
            # container's are created from.
            # Use containerd's `ctr oci spec > /etc/containerd/cri-base.json` to output initial spec file.
            # Spec files are loaded at launch, so containerd daemon must be restarted on any changes to refresh default specs.
            # Still running containers and restarted containers will still be using the original spec from which that container was created.
            base_runtime_spec = ""

            # conf_dir is the directory in which the admin places a CNI conf.
            # this allows a different CNI conf for the network stack when a different runtime is being used.
            cni_conf_dir = "/etc/cni/net.d"

            # cni_max_conf_num specifies the maximum number of CNI plugin config files to
            # load from the CNI config directory. By default, only 1 CNI plugin config
            # file will be loaded. If you want to load multiple CNI plugin config files
            # set max_conf_num to the number desired. Setting cni_max_config_num to 0 is
            # interpreted as no limit is desired and will result in all CNI plugin
            # config files being loaded from the CNI config directory.
            cni_max_conf_num = 1

            # 'plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options' is options specific to
            # "io.containerd.runc.v1" and "io.containerd.runc.v2". Its corresponding options type is:
            #   https://github.com/containerd/containerd/blob/v1.3.2/runtime/v2/runc/options/oci.pb.go#L26 .
            [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
              # NoPivotRoot disables pivot root when creating a container.
              NoPivotRoot = false

              # NoNewKeyring disables new keyring for the container.
              NoNewKeyring = false

              # ShimCgroup places the shim in a cgroup.
              ShimCgroup = ""

              # IoUid sets the I/O's pipes uid.
              IoUid = 0

              # IoGid sets the I/O's pipes gid.
              IoGid = 0

              # BinaryName is the binary name of the runc binary.
              BinaryName = ""

              # Root is the runc root directory.
              Root = ""

              # CriuPath is the criu binary path.
              CriuPath = ""

              # SystemdCgroup enables systemd cgroups.
              SystemdCgroup = false

              # CriuImagePath is the criu image path
              CriuImagePath = ""

              # CriuWorkPath is the criu work path.
              CriuWorkPath = ""

        # 'plugins."io.containerd.grpc.v1.cri".cni' contains config related to cni
        [plugins."io.containerd.grpc.v1.cri".cni]
          # bin_dir is the directory in which the binaries for the plugin is kept.
          bin_dir = "/opt/cni/bin"

          # conf_dir is the directory in which the admin places a CNI conf.
          conf_dir = "/etc/cni/net.d"

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
    system "sed -i 's,/var,#{CREW_PREFIX}/var,g' config.toml"
    system "sed -i 's,/run,/var/run/chrome,g' config.toml"
    system "sed -i 's,/etc,#{CREW_PREFIX}/etc,g' config.toml"
    system "sed -i 's,/opt,#{CREW_PREFIX}/opt,g' config.toml"
    case ARCH
    when 'armv7l', 'aarch64'
      @docker_platform = 'linux/arm/v7'
    when 'x86_64'
      @docker_platform = 'linux/amd64'
    end
    system "sed -i 's,linux/amd64,#{@docker_platform},g' config.toml"
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
    FileUtils.install 'containerd.service', "#{CREW_DEST_PREFIX}/.config/systemd/user/containerd.service", mode: 0o644
    FileUtils.install Dir['man/*.5'], "#{CREW_DEST_MAN_PREFIX}/man5", mode: 0o644
    FileUtils.install Dir['man/*.8'], "#{CREW_DEST_MAN_PREFIX}/man8", mode: 0o644
  end
end
