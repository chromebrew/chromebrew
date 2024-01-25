# Adapted from Arch Linux docker PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/docker/trunk/PKGBUILD

require 'package'

class Docker < Package
  description 'Pack, ship and run any application as a lightweight container'
  homepage 'https://www.docker.com/'
  version '24.0.1'
  license 'Apache'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/docker/cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '923b0eb95c947dde422e196abd0f1ddbc0958792db2807e2c55c3048b700702a',
     armv7l: '923b0eb95c947dde422e196abd0f1ddbc0958792db2807e2c55c3048b700702a',
     x86_64: '21f9db6ec0086ab6452be9cd50a6bc980eb00caafb439a3387802c5363085ec1'
  })

  depends_on 'bridge_utils' # L
  depends_on 'btrfsprogs' => :build
  depends_on 'containerd' # L
  depends_on 'elogind' => :build
  depends_on 'eudev' => :build
  depends_on 'glibc' # R
  depends_on 'go' => :build
  depends_on 'go_md2man' => :build
  depends_on 'iproute2' # L
  depends_on 'lvm2' # R
  depends_on 'sqlite' => :build

  no_env_options
  no_fhs

  def self.preflight
    return if File.exist?('/dev/kvm') || CREW_IN_CONTAINER

    abort 'This device does not have virtualization enabled :/'.lightred
  end

  def self.build
    @cli_version = git_hashtag

    binary_sha256({
      aarch64: '923b0eb95c947dde422e196abd0f1ddbc0958792db2807e2c55c3048b700702a',
       armv7l: '923b0eb95c947dde422e196abd0f1ddbc0958792db2807e2c55c3048b700702a',
       x86_64: '21f9db6ec0086ab6452be9cd50a6bc980eb00caafb439a3387802c5363085ec1'
    })

    @moby_version = git_hashtag

    binary_sha256({
      aarch64: '923b0eb95c947dde422e196abd0f1ddbc0958792db2807e2c55c3048b700702a',
       armv7l: '923b0eb95c947dde422e196abd0f1ddbc0958792db2807e2c55c3048b700702a',
       x86_64: '21f9db6ec0086ab6452be9cd50a6bc980eb00caafb439a3387802c5363085ec1'
    })

    @libnetwork_version = '3f0048413d95802b9c6c836eba06bfc54f9dbd03'
    @tini_version = '0b44d3665869e46ccbac7414241b8256d6234dc4'
    @buildx_version = 'v0.10.5'
    @gopath = Dir.pwd
    FileUtils.mkdir_p 'src/github.com/docker'
    FileUtils.ln_s @gopath, 'src/github.com/docker/cli'
    Dir.chdir 'src/github.com/docker/cli' do
      system "GOPATH=#{@gopath} \
      CGO_CPPFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '')}' \
      CGO_CFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '')}' \
      CGO_CXXFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '')}' \
      CGO_LDFLAGS='#{CREW_LDFLAGS.gsub('=auto', '')}' \
      LDFLAGS='' \
      GOFLAGS='-buildmode=pie -trimpath -mod=readonly -modcacherw -ldflags=-linkmode=external' \
      GO111MODULE=off \
      DISABLE_WARN_OUTSIDE_CONTAINER=1 \
      make VERSION=#{version} dynbinary"
      system "GOPATH=#{@gopath} \
      CGO_CPPFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '')}' \
      CGO_CFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '')}' \
      CGO_CXXFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '')}' \
      CGO_LDFLAGS='#{CREW_LDFLAGS.gsub('=auto', '')}' \
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
        CGO_CPPFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '').gsub('-flto', '')}' \
        CGO_CFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '').gsub('-flto', '')}' \
        CGO_CXXFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '').gsub('-flto', '')}' \
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
        CGO_CPPFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '')}' \
        CGO_CFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '')}' \
        CGO_CXXFLAGS='#{CREW_COMMON_FLAGS.gsub('=auto', '')}' \
        CGO_LDFLAGS='#{CREW_LDFLAGS.gsub('=auto', '')}' \
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
      #{CREW_DEST_PREFIX}/etc/sysusers.d
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
    FileUtils.install Dir.glob('man/man1/*'), "#{CREW_DEST_MAN_PREFIX}/man1/", mode: 0o644
    FileUtils.install Dir.glob('man/man5/*'), "#{CREW_DEST_MAN_PREFIX}/man5/", mode: 0o644
    FileUtils.install Dir.glob('man/man8/*'), "#{CREW_DEST_MAN_PREFIX}/man8/", mode: 0o644
    FileUtils.install 'src/github.com/docker/buildx/docker-buildx',
                      "#{CREW_DEST_LIB_PREFIX}/docker/cli-plugins/docker-buildx", mode: 0o755
  end
end
