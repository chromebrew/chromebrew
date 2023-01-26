# Adapted from Arch Linux docker PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/docker/trunk/PKGBUILD

require 'package'

class Docker < Package
  description 'Pack, ship and run any application as a lightweight container'
  homepage 'https://www.docker.com/'
  version '23.0.0-rc.3'
  license 'Apache'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/docker/cli.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker/23.0.0-rc.1_armv7l/docker-23.0.0-rc.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker/23.0.0-rc.1_armv7l/docker-23.0.0-rc.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker/23.0.0-rc.1_x86_64/docker-23.0.0-rc.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7cd26fca47393832c15012ce0345f78c688b1062e1fb3eef985db625cd1be9cd',
     armv7l: '7cd26fca47393832c15012ce0345f78c688b1062e1fb3eef985db625cd1be9cd',
     x86_64: 'afc88b554da28cce205a42de3a7a9abc0d567fd08b5d0fd66c77f95d728368c4'
  })

  depends_on 'bridge_utils'
  depends_on 'btrfsprogs' => :build
  depends_on 'containerd'
  depends_on 'elogind' => :build
  depends_on 'eudev'
  depends_on 'glibc' # R
  depends_on 'go' => :build
  depends_on 'go_md2man' => :build
  depends_on 'iproute2'
  depends_on 'lvm2' # R
  depends_on 'sqlite'

  no_env_options
  no_fhs

  def self.build
    @cli_version = git_hashtag
    @moby_version = git_hashtag
    @libnetwork_version = '1f3b98be6833a93f254aa0f765ff55d407dfdd69'
    @tini_version = '378bbbc8909a960e89de220b1a4e50781233a740'
    @buildx_version = '8a7a221a7fd636bafd6bf05b964f8b87b65d8877'
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
        DOCKER_GITCOMMIT=$(git rev-parse --short HEAD) \
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
          -X #{@buildx_r}/version.Version=$(git describe --match 'v[0-9]*' --always --tags)-docker \
          -X #{@buildx_r}/version.Revision=$(git rev-parse HEAD) \
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
