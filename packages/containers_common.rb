# Adapted from Arch Linux containers-common PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/containers-common/trunk/PKGBUILD

require 'package'

class Containers_common < Package
  description 'Configuration files and manpages for containers'
  homepage 'https://github.com/containers'
  version '0.49.3'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/containers/common.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containers_common/0.49.3_armv7l/containers_common-0.49.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containers_common/0.49.3_armv7l/containers_common-0.49.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containers_common/0.49.3_i686/containers_common-0.49.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containers_common/0.49.3_x86_64/containers_common-0.49.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '104de5c0cbcfade5b20e008a9bf28d1a76b1fd6f52f96659c32a4b6cf1cbca1c',
     armv7l: '104de5c0cbcfade5b20e008a9bf28d1a76b1fd6f52f96659c32a4b6cf1cbca1c',
       i686: '2468701207070cac0cccb9e6db4a9d4289af4e955863b0fc3dcb61749c7ad1e4',
     x86_64: '2b8c9ebb6812da9e9725bc2c2a27e5fce0290a547b16e3a25ed672f101482cfd'
  })

  depends_on 'netavark'
  depends_on 'go_md2man' => :build

  no_fhs

  def self.build
    @image_version = 'v5.23.1'
    @podman_version = 'v4.3.1'
    @shortnames_version = 'v2022.02.08'
    @skopeo_version = 'v1.9.3'
    @storage_version = 'v1.43.1'
    Dir.chdir 'docs' do
      system 'for _man_page in *.md
      do
        go-md2man -in $_man_page -out ${_man_page//.md}
      done'
    end
    FileUtils.mkdir_p 'git'
    Dir.chdir 'git' do
      system "git clone --depth 1 --branch #{@image_version} https://github.com/containers/image.git"
      Dir.chdir 'image/docs' do
        FileUtils.mkdir_p 'man5'
        FileUtils.mv Dir.glob('*.5.md'), 'man5/'
        system 'for _man_page in *.md
        do
          go-md2man -in $_man_page -out ${_man_page//.md}.1
        done'
        system 'for _man_page in man5/*.md
        do
          go-md2man -in $_man_page -out ${_man_page//.md}
        done'
      end
      system "git clone --depth 1 --branch #{@podman_version} https://github.com/containers/podman.git"
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
      #{CREW_DEST_PREFIX}/etc/containers/registries.d/
      #{CREW_DEST_PREFIX}/share/containers/oci/hooks.d/
      #{CREW_DEST_PREFIX}/var/lib/containers/
      #{CREW_DEST_PREFIX}/.config/containers/
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
        FileUtils.install 'shortnames.conf', "#{CREW_DEST_PREFIX}/etc/containers/registries.conf.d/00-shortnames.conf",
                          mode: 0o644
      end
      Dir.chdir 'skopeo' do
        FileUtils.install 'default-policy.json', "#{CREW_DEST_PREFIX}/etc/containers/policy.json", mode: 0o644
        Dir.chdir "#{CREW_DEST_PREFIX}/.config/containers/" do
          FileUtils.ln_s "#{CREW_PREFIX}/etc/containers/policy.json", 'policy.json'
        end
        FileUtils.install 'default.yaml', "#{CREW_DEST_PREFIX}/etc/containers/registries.d/", mode: 0o644
      end
      Dir.chdir 'storage' do
        system "sed -i 's,/run/containers/storage,#{CREW_PREFIX}/var/run/containers/storage,g' storage.conf"
        system "sed -i 's,/var/lib/containers/storage,#{CREW_PREFIX}/var/lib/containers/storage,g' storage.conf"
        system "sed -i 's,\\$HOME/.local/share/containers/storage,#{CREW_PREFIX}/var/lib/containers/storage,g' storage.conf"
        system "sed -i 's,# rootless_storage_path,rootless_storage_path,g' storage.conf"
        FileUtils.install 'storage.conf', "#{CREW_DEST_PREFIX}/etc/containers/", mode: 0o644
        Dir.chdir "#{CREW_DEST_PREFIX}/.config/containers/" do
          FileUtils.ln_s "#{CREW_PREFIX}/etc/containers/storage.conf", 'storage.conf'
        end
        FileUtils.install 'storage.conf', "#{CREW_DEST_PREFIX}/share/containers/", mode: 0o644
        FileUtils.install Dir['docs/*.1'], "#{CREW_DEST_MAN_PREFIX}/man1/", mode: 0o644
        FileUtils.install Dir['docs/*.5'], "#{CREW_DEST_MAN_PREFIX}/man5/", mode: 0o644
      end
    end
  end
end
