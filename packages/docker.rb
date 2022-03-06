# Adapted from Arch Linux docker PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/docker/trunk/PKGBUILD

require 'package'

class Docker < Package
  description 'Pack, ship and run any application as a lightweight container'
  homepage 'https://www.docker.com/'
  version '20.10.12'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/docker/cli.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker/20.10.12_armv7l/docker-20.10.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker/20.10.12_armv7l/docker-20.10.12-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker/20.10.12_x86_64/docker-20.10.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9dd56bf70a05ba13eb636ec1755b0460e3676b843ccfbc4969446fbb8e2098d2',
     armv7l: '9dd56bf70a05ba13eb636ec1755b0460e3676b843ccfbc4969446fbb8e2098d2',
     x86_64: 'fe2a39d90ef0b37c33125cdcbdccf7a8b26255dff3ac46e790fa02126482ba69'
  })

  depends_on 'docker_systemctl_replacement'
  depends_on 'bridge_utils'
  depends_on 'containerd'
  depends_on 'eudev'
  depends_on 'iproute2'
  depends_on 'lvm2'
  depends_on 'sqlite'
  depends_on 'go' => ':build'
  depends_on 'btrfsprogs' => ':build'
  depends_on 'elogind' => ':build'
  depends_on 'go_md2man' => ':build'
  no_env_options
  no_fhs

  def self.build
    @cli_version = git_hashtag
    @moby_version = git_hashtag
    @libnetwork_version = '64b7a4574d1426139437d20e81c0b6d391130ec8'
    @tini_version = 'de40ad007797e0dcd8b7126f27bb87401d224240'
    @buildx_version = '05846896d149da05f3d6fd1e7770da187b52a247'
    @gopath = `pwd`.chomp
    FileUtils.mkdir_p 'src/github.com/docker'
    FileUtils.ln_s @gopath, 'src/github.com/docker/cli'
    Dir.chdir 'src/github.com/docker/cli' do
      system "GOPATH=#{@gopath} \
      CGO_CPPFLAGS='#{CREW_COMMON_FLAGS}' \
      CGO_CFLAGS='#{CREW_COMMON_FLAGS}' \
      CGO_CXXFLAGS='#{CREW_COMMON_FLAGS}' \
      CGO_LDFLAGS='#{CREW_LDFLAGS}' \
      LDFLAGS='' \
      GOFLAGS='-buildmode=pie -trimpath -mod=readonly -modcacherw -ldflags=-linkmode=external' \
      GO111MODULE=off \
      DISABLE_WARN_OUTSIDE_CONTAINER=1 \
      make VERSION=#{version} dynbinary"
      system "GOPATH=#{@gopath} \
      CGO_CPPFLAGS='#{CREW_COMMON_FLAGS}' \
      CGO_CFLAGS='#{CREW_COMMON_FLAGS}' \
      CGO_CXXFLAGS='#{CREW_COMMON_FLAGS}' \
      CGO_LDFLAGS='#{CREW_LDFLAGS}' \
      LDFLAGS='' \
      GOFLAGS='-buildmode=pie -trimpath -mod=readonly -modcacherw -ldflags=-linkmode=external' \
      GO111MODULE=off \
      DISABLE_WARN_OUTSIDE_CONTAINER=1 \
      make manpages"
    end
    Dir.chdir 'src/github.com/docker/' do
      system "git clone --depth 1 --branch #{@moby_version} https://github.com/moby/moby.git docker"
      Dir.chdir 'docker' do
        system "sed -i 's,/usr,#{CREW_PREFIX},g' contrib/init/systemd/docker.service"
        system "GOPATH=#{@gopath} \
        CGO_CPPFLAGS='#{CREW_COMMON_FLAGS.gsub('-flto', '')}' \
        CGO_CFLAGS='#{CREW_COMMON_FLAGS.gsub('-flto', '')}' \
        CGO_CXXFLAGS='#{CREW_COMMON_FLAGS.gsub('-flto', '')}' \
        CGO_LDFLAGS='' \
        LDFLAGS='' \
        GOFLAGS='-buildmode=pie -trimpath -mod=readonly -modcacherw -ldflags=-linkmode=external' \
        GO111MODULE=off \
        DISABLE_WARN_OUTSIDE_CONTAINER=1 \
        DOCKER_GITCOMMIT=\$(git rev-parse --short HEAD) \
        DOCKER_BUILDTAGS='seccomp apparmor' \
        VERSION=#{version} \
        hack/make.sh dynbinary"
      end
      system 'git clone https://github.com/docker/libnetwork.git'
      Dir.chdir 'libnetwork' do
        system "git checkout #{@libnetwork_version}"
        system "GOPATH=#{@gopath} \
        CGO_CPPFLAGS='#{CREW_COMMON_FLAGS}' \
        CGO_CFLAGS='#{CREW_COMMON_FLAGS}' \
        CGO_CXXFLAGS='#{CREW_COMMON_FLAGS}' \
        CGO_LDFLAGS='#{CREW_LDFLAGS}' \
        LDFLAGS='' \
        GOFLAGS='-buildmode=pie -trimpath -mod=readonly -modcacherw -ldflags=-linkmode=external' \
        GO111MODULE=off \
        DISABLE_WARN_OUTSIDE_CONTAINER=1 \
        go build github.com/docker/libnetwork/cmd/proxy"
      end
      system 'git clone https://github.com/krallin/tini.git'
      Dir.chdir 'tini' do
        system "git checkout #{@tini_version}"
        system "cmake #{CREW_CMAKE_OPTIONS} ."
        system 'make tini-static'
      end
      system 'git clone https://github.com/docker/buildx.git'
      Dir.chdir 'buildx' do
        system "git checkout #{@buildx_version}"
        @buildx_r = 'github.com/docker/buildx'
        system "GOPATH=#{@gopath} \
          GO111MODULE=on go build -mod=vendor -o docker-buildx -ldflags \"-linkmode=external \
          -X #{@buildx_r}/version.Version=\$(git describe --match 'v[0-9]*' --always --tags)-docker \
          -X #{@buildx_r}/version.Revision=\$(git rev-parse HEAD) \
          -X #{@buildx_r}/version.Package=#{@buildx_r}\" \
          ./cmd/buildx"
      end
    end
  end

  def self.install
    FileUtils.mkdir_p %W[
      #{CREW_DEST_LIB_PREFIX}/docker/cli-plugins
      #{CREW_DEST_MAN_PREFIX}/man1
      #{CREW_DEST_MAN_PREFIX}/man5
      #{CREW_DEST_MAN_PREFIX}/man8
      #{CREW_DEST_PREFIX}/bin
      #{CREW_DEST_PREFIX}/.config/systemd/user
      #{CREW_DEST_PREFIX}/etc/sysusers.d
      #{CREW_DEST_PREFIX}/etc/udev/rules.d
      #{CREW_DEST_PREFIX}/share/bash-completion/completions
      #{CREW_DEST_PREFIX}/share/fish/vendor_completions.d
      #{CREW_DEST_PREFIX}/share/zsh/site-functions
    ]
    FileUtils.install 'src/github.com/docker/libnetwork/proxy', "#{CREW_DEST_PREFIX}/bin/docker-proxy", mode: 0o755
    FileUtils.install 'src/github.com/docker/tini/tini-static', "#{CREW_DEST_PREFIX}/bin/docker-init", mode: 0o755
    FileUtils.install 'src/github.com/docker/docker/bundles/dynbinary-daemon/dockerd',
                      "#{CREW_DEST_PREFIX}/bin/dockerd", mode: 0o755
    FileUtils.install 'src/github.com/docker/docker/contrib/init/systemd/docker.service',
                      "#{CREW_DEST_PREFIX}/.config/systemd/user/docker.service", mode: 0o644
    FileUtils.install 'src/github.com/docker/docker/contrib/init/systemd/docker.socket',
                      "#{CREW_DEST_PREFIX}/.config/systemd/user/docker.socket", mode: 0o644
    FileUtils.install 'src/github.com/docker/docker/contrib/udev/80-docker.rules',
                      "#{CREW_DEST_PREFIX}/etc/udev/rules.d/80-docker.rules", mode: 0o644
    @docker_sysusers = 'g chronos - -'
    File.write("#{CREW_DEST_PREFIX}/etc/sysusers.d/docker.conf", @docker_sysusers, perm: 0o644)
    FileUtils.install 'build/docker', "#{CREW_DEST_PREFIX}/bin/docker", mode: 0o755
    FileUtils.install 'contrib/completion/bash/docker',
                      "#{CREW_DEST_PREFIX}/share/bash-completion/completions/dockeres", mode: 0o644
    FileUtils.install 'contrib/completion/zsh/_docker', "#{CREW_DEST_PREFIX}/share/zsh/site-functions/_docker",
                      mode: 0o644
    FileUtils.install 'contrib/completion/fish/docker.fish',
                      "#{CREW_DEST_PREFIX}/share/fish/vendor_completions.d/docker.fish", mode: 0o644
    FileUtils.cp_r Dir.glob('man/man*'), "#{CREW_DEST_MAN_PREFIX}/"
    FileUtils.install 'src/github.com/docker/buildx/docker-buildx',
                      "#{CREW_DEST_LIB_PREFIX}/docker/cli-plugins/docker-buildx", mode: 0o755
  end
end
