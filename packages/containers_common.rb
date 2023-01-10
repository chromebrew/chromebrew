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
    aarch64: '06f20054310a55b9371336b4b5cd88b6a9f89d3f85702d1e99b21aec7fa13123',
     armv7l: '06f20054310a55b9371336b4b5cd88b6a9f89d3f85702d1e99b21aec7fa13123',
       i686: '80811ec2080d153dd4f470c7e92413dc8cc61526241749391237a2eec86e0405',
     x86_64: '1597d590420e90de5edbca768026642871c0849aeb7566b8ed55a22be7dc9d99'
  })

  depends_on 'netavark'
  depends_on 'go_md2man' => :build

  def self.build
    @image_version = 'v5.20.0'
    @podman_version = 'v4.0.2'
    @shortnames_version = 'v2022.02.08'
    @skopeo_version = 'v1.6.1'
    @storage_version = 'v1.38.2'
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
      Dir.chdir 'podman' do
        system 'go-md2man -in pkg/hooks/docs/oci-hooks.5.md -out oci-hooks.5'
      end
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
    system "install -vDm 644 pkg/config/containers.conf -t #{CREW_DEST_PREFIX}/etc/containers/"
    system "install -vDm 644 pkg/config/containers.conf -t #{CREW_DEST_PREFIX}/share/containers/"
    system "install -vDm 644 pkg/seccomp/seccomp.json -t #{CREW_DEST_PREFIX}/etc/containers/"
    system "install -vDm 644 pkg/seccomp/seccomp.json -t #{CREW_DEST_PREFIX}/share/containers/"
    system "install -vDm 644 docs/*.5 -t #{CREW_DEST_MAN_PREFIX}/man5/"

    Dir.chdir 'git' do
      Dir.chdir 'image' do
        system "install -vDm 644 registries.conf -t #{CREW_DEST_PREFIX}/etc/containers/"

        system "install -vDm 644 docs/*.1 -t #{CREW_DEST_MAN_PREFIX}/man1/"
        system "install -vDm 644 docs/man5/*.5 -t #{CREW_DEST_MAN_PREFIX}/man5/"
      end
      Dir.chdir 'podman' do
        system "install -vDm 644 *.5 -t #{CREW_DEST_MAN_PREFIX}/man5/"
      end

      Dir.chdir 'shortnames' do
        system "install -vDm 644 shortnames.conf #{CREW_DEST_PREFIX}/etc/containers/registries.conf.d/00-shortnames.conf"
      end
      Dir.chdir 'skopeo' do
        system "install -vDm 644 default-policy.json #{CREW_DEST_PREFIX}/etc/containers/policy.json"
        system "install -vDm 644 default.yaml -t #{CREW_DEST_PREFIX}/etc/containers/registries.d/"
      end
      Dir.chdir 'storage' do
        system "install -vDm 644 storage.conf -t #{CREW_DEST_PREFIX}/etc/containers/"
        system "install -vDm 644 storage.conf -t #{CREW_DEST_PREFIX}/share/containers/"
        system "install -vDm 644 docs/*.1 -t #{CREW_DEST_MAN_PREFIX}/man1/"
        system "install -vDm 644 docs/*.5 -t #{CREW_DEST_MAN_PREFIX}/man5/"
      end
    end
  end
end
