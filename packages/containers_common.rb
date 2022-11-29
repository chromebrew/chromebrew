# Adapted from Arch Linux containers-common PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/containers-common/trunk/PKGBUILD

require 'package'

class Containers_common < Package
  description 'Configuration files and manpages for containers'
  homepage 'https://github.com/containers'
  version '0.47.4'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/containers/common.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containers_common/0.47.4_armv7l/containers_common-0.47.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containers_common/0.47.4_armv7l/containers_common-0.47.4-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containers_common/0.47.4_x86_64/containers_common-0.47.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '653d744a20a0d5be563586212b7813887b15b4e56b8c6344a078fa99e764e6f9',
     armv7l: '653d744a20a0d5be563586212b7813887b15b4e56b8c6344a078fa99e764e6f9',
     x86_64: '21dfc889cc2fcd41ff44ce30c7aa900d2ffa0a3d9a48f22b732ddbeae0c52afe'
  })

  depends_on 'netavark'
  depends_on 'go_md2man' => :build

  def self.build
    @image_version = 'v5.20.0'
    @podman_version = 'v4.0.2'
    @shortnames_version = 'v2022.02.08'
    @skopeo_version = 'v1.6.1'
    @storage_version = 'v1.38.2'

    Dir.glob('docs/*.md') do |_man_page|
      system "go-md2man -in #{_man_page} -out #{File.basename(_man_page, '.md')}"
    end

    FileUtils.mkdir_p 'git'
    Dir.chdir 'git' do
      system "git clone --depth 1 --branch #{@image_version} https://github.com/containers/image.git"
      Dir.chdir 'image/docs' do
        FileUtils.mkdir_p 'man5'
        FileUtils.mv Dir['*.5.md'], 'man5/'

        Dir.glob('*.md', 'man5/*.md') do |_man_page|
          system "go-md2man -in #{_man_page} -out #{File.basename(_man_page, '.md')}.1"
        end
      end

      system "git clone --depth 1 --branch #{@podman_version} https://github.com/containers/podman.git"
      system 'go-md2man -in pkg/hooks/docs/oci-hooks.5.md -out oci-hooks.5', chdir: 'podman'

      system "git clone --depth 1 --branch #{@shortnames_version} https://github.com/containers/shortnames.git"
      system "git clone --depth 1 --branch #{@skopeo_version} https://github.com/containers/skopeo.git"
      system "git clone --depth 1 --branch #{@storage_version} https://github.com/containers/storage.git"
      Dir.chdir 'storage' do
        FileUtils.mkdir_p 'tests/tools/build/'
        FileUtils.ln_s "#{CREW_PREFIX}/bin/go-md2man", 'tests/tools/build/'
        system 'make -C docs'
      end
    end
  end

  def self.install
    FileUtils.mkdir_p %W[
      #{CREW_DEST_PREFIX}/etc/containers/oci/hooks.d/
      #{CREW_DEST_PREFIX}/etc/containers/registries.conf.d/
      #{CREW_DEST_PREFIX}/share/containers/oci/hooks.d/
      #{CREW_DEST_PREFIX}/var/lib/containers/
      #{CREW_DEST_MAN_PREFIX}/man1/
      #{CREW_DEST_MAN_PREFIX}/man5/
    ]
    @mounts_conf = <<~'MOUNTS_CONF_EOF'
      # Configuration file for default mounts in containers (see man 5
      # containers-mounts.conf for further information)
    MOUNTS_CONF_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/containers/mounts.conf", @mounts_conf, perm: 0o644)
    FileUtils.install 'pkg/config/containers.conf', "#{CREW_DEST_PREFIX}/etc/containers/", mode: 0o644
    FileUtils.install 'pkg/config/containers.conf', "#{CREW_DEST_PREFIX}/share/containers/", mode: 0o644
    FileUtils.install 'pkg/seccomp/seccomp.json', "#{CREW_DEST_PREFIX}/etc/containers/", mode: 0o644
    FileUtils.install 'pkg/seccomp/seccomp.json', "#{CREW_DEST_PREFIX}/share/containers/", mode: 0o644
    FileUtils.install Dir['docs/*.5'], "#{CREW_DEST_MAN_PREFIX}/man5/", mode: 0o644

    Dir.chdir 'git' do
      Dir.chdir 'image' do
        FileUtils.install 'registries.conf', "#{CREW_DEST_PREFIX}/etc/containers/", mode: 0o644
        FileUtils.install Dir['docs/*.1'], "#{CREW_DEST_MAN_PREFIX}/man1/", mode: 0o644
        FileUtils.install Dir['docs/man5/*.5'], "#{CREW_DEST_MAN_PREFIX}/man5/", mode: 0o644
      end
      Dir.chdir 'podman' do
        FileUtils.install Dir['*.5'], "#{CREW_DEST_MAN_PREFIX}/man5/", mode: 0o644
      end

      Dir.chdir 'shortnames' do
        FileUtils.install 'shortnames.conf', "#{CREW_DEST_PREFIX}/etc/containers/registries.conf.d/00-shortnames.conf", mode: 0o644
      end
      Dir.chdir 'skopeo' do
        FileUtils.install 'default-policy.json', "#{CREW_DEST_PREFIX}/etc/containers/policy.json", mode: 0o644
        FileUtils.install 'default.yaml', "#{CREW_DEST_PREFIX}/etc/containers/registries.d/", mode: 0o644
      end
      Dir.chdir 'storage' do
        FileUtils.install 'storage.conf', "#{CREW_DEST_PREFIX}/etc/containers/", mode: 0o644
        FileUtils.install 'storage.conf', "#{CREW_DEST_PREFIX}/share/containers/", mode: 0o644
        FileUtils.install Dir['docs/*.1'], "#{CREW_DEST_MAN_PREFIX}/man1/", mode: 0o644
        FileUtils.install Dir['docs/*.5'], "#{CREW_DEST_MAN_PREFIX}/man5/", mode: 0o644
      end
    end
  end
end
