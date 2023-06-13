# Adapted from Arch Linux containers-common PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/containers-common/trunk/PKGBUILD

require 'package'

class Containers_common < Package
  description 'Configuration files and manpages for containers'
  homepage 'https://github.com/containers'
  version '0.53.0'
  license 'Apache'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/containers/common.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containers_common/0.53.0_armv7l/containers_common-0.53.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containers_common/0.53.0_armv7l/containers_common-0.53.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/containers_common/0.53.0_x86_64/containers_common-0.53.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4e3a13f8d5d879cb36470988461b37c84f56e648a37a76da63463cb83adf1491',
     armv7l: '4e3a13f8d5d879cb36470988461b37c84f56e648a37a76da63463cb83adf1491',
     x86_64: '1f1902ccdd3944deaff5380ddb4af2378a4b337409e3a45882086fef6d0ef159'
  })

  depends_on 'catatonit'

  depends_on 'netavark'
  depends_on 'go_md2man' => :build

  no_fhs

  def self.build
    @image_version = 'v5.25.0'
    @podman_version = 'v4.5.0'
    @shortnames_version = 'v2023.02.20'
    @skopeo_version = 'v1.12.0'
    @storage_version = 'v1.46.1'
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
      #{CREW_DEST_PREFIX}/etc/containers/networks
      #{CREW_DEST_PREFIX}/etc/containers/oci/hooks.d/
      #{CREW_DEST_PREFIX}/etc/containers/registries.conf.d/
      #{CREW_DEST_PREFIX}/etc/containers/registries.d/
      #{CREW_DEST_PREFIX}/share/containers/oci/hooks.d/
      #{CREW_DEST_PREFIX}/var/lib/containers/
      #{CREW_DEST_PREFIX}/.config/containers/
    ]
    @mounts_conf = <<~MOUNTS_CONF_EOF
      # Configuration file for default mounts in containers (see man 5
      # containers-mounts.conf for further information)
    MOUNTS_CONF_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/containers/mounts.conf", @mounts_conf, perm: 0o644)
    Dir.chdir "#{CREW_DEST_PREFIX}/.config/containers/" do
      FileUtils.ln_s "#{CREW_PREFIX}/etc/containers/mounts.conf", 'mounts.conf'
    end
    system "sed -i 's,#init_path = \"/usr/libexec/podman/catatonit\",init_path = \"#{CREW_PREFIX}/bin/catatonit\",' pkg/config/containers.conf"
    system "sed -i 's,#seccomp_profile = \"/usr/share/containers/seccomp.json\",seccomp_profile = \"#{CREW_PREFIX}/etc/containers/seccomp.json\",' pkg/config/containers.conf"
    system "sed -i 's,#volume_path = \"/var/lib/containers/storage/volumes\",volume_path = \"#{CREW_PREFIX}/var/lib/containers/storage/volumes\",' pkg/config/containers.conf"
    system "sed -i 's,#init = false,init = true,' pkg/config/containers.conf"
    system "sed -i 's,#tz = \"\",tz = \"local\",' pkg/config/containers.conf"
    FileUtils.install 'pkg/config/containers.conf', "#{CREW_DEST_PREFIX}/etc/containers/", mode: 0o644
    FileUtils.install 'pkg/config/containers.conf', "#{CREW_DEST_PREFIX}/share/containers/", mode: 0o644
    Dir.chdir "#{CREW_DEST_PREFIX}/.config/containers/" do
      FileUtils.ln_s "#{CREW_PREFIX}/etc/containers/containers.conf", 'containers.conf'
    end
    FileUtils.install 'pkg/seccomp/seccomp.json', "#{CREW_DEST_PREFIX}/etc/containers/", mode: 0o644
    FileUtils.install 'pkg/seccomp/seccomp.json', "#{CREW_DEST_PREFIX}/share/containers/", mode: 0o644
    Dir.chdir "#{CREW_DEST_PREFIX}/.config/containers/" do
      FileUtils.ln_s "#{CREW_PREFIX}/etc/containers/seccomp.json", 'seccomp.json'
    end
    FileUtils.install 'docs/*.5', "#{CREW_DEST_MAN_PREFIX}/man5/", mode: 0o644

    Dir.chdir 'git' do
      Dir.chdir 'image' do
        @registry_add = <<~REGISTRY_ADD_EOF
          # Note that changing the order here may break tests.
          unqualified-search-registries = ['docker.io', 'quay.io', 'registry.fedoraproject.org']

          [[registry]]
          # In Nov. 2020, Docker rate-limits image pulling.  To avoid hitting these
          # limits while testing, always use the google mirror for qualified and
          # unqualified `docker.io` images.
          # Ref: https://cloud.google.com/container-registry/docs/pulling-cached-images
          prefix="docker.io"
          location="mirror.gcr.io"

          # 2020-10-27 a number of images are not present in gcr.io, and podman
          # barfs spectacularly when trying to fetch them. We've hand-copied
          # those to quay, using skopeo copy --all ...
          [[registry]]
          prefix="docker.io/library"
          location="quay.io/libpod"
        REGISTRY_ADD_EOF
        File.write('registries.conf', @registry_add, mode: 'a+')
        FileUtils.install 'registries.conf', "#{CREW_DEST_PREFIX}/etc/containers/", mode: 0o644
        Dir.chdir "#{CREW_DEST_PREFIX}/.config/containers/" do
          FileUtils.ln_s "#{CREW_PREFIX}/etc/containers/registries.conf", 'registries.conf'
        end
        FileUtils.install 'docs/*.1', "#{CREW_DEST_MAN_PREFIX}/man1/", mode: 0o644
        FileUtils.install 'docs/man5/*.5', "#{CREW_DEST_MAN_PREFIX}/man5/", mode: 0o644
      end
      Dir.chdir 'podman' do
        FileUtils.install '*.5', "#{CREW_DEST_MAN_PREFIX}/man5/", mode: 0o644
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
        FileUtils.install 'storage.conf', "#{CREW_DEST_PREFIX}/share/containers/", mode: 0o644
        Dir.chdir "#{CREW_DEST_PREFIX}/.config/containers/" do
          FileUtils.ln_s "#{CREW_PREFIX}/etc/containers/storage.conf", 'storage.conf'
        end
        FileUtils.install 'docs/*.1', "#{CREW_DEST_MAN_PREFIX}/man1/", mode: 0o644
        FileUtils.install 'docs/*.5', "#{CREW_DEST_MAN_PREFIX}/man5/", mode: 0o644
      end
    end
  end

  def self.postinstall
    # Podman will not work unless a user policy.json file at
    # #{HOME}/.config/containers/policy.json is populated.
    @user_container_policy = File.file?("#{HOME}/.config/containers/policy.json")
    @create_user_container_policy = true unless @user_container_policy
    @create_user_container_ask = true if @user_container_policy
    if @create_user_container_ask
      return if FileUtils.compare_file("#{CREW_PREFIX}/etc/containers/policy.json",
                                       "#{HOME}/.config/containers/policy.json")

      print "\nWould you like to overwrite the user container policy file with the package default? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        @create_user_container_policy = true
      else
        @create_user_container_policy = false
        puts 'User container policy file left unchanged.'.lightgreen
      end
    end
    return unless @create_user_container_policy

    FileUtils.cp "#{CREW_PREFIX}/etc/containers/policy.json", "#{HOME}/.config/containers/policy.json"
    puts "Default container policy written to: #{HOME}/.config/containers/policy.json".lightgreen
  end

  def self.remove
    return if CREW_IN_CONTAINER

    @config_file = "#{HOME}/.config/containers/policy.json"
    print "\nWould you like to remove the user container policy file #{@config_file} ? [y/N] "
    case $stdin.gets.chomp.downcase
    when 'y', 'yes'
      FileUtils.rm_rf @config_file
      puts "#{@config_file} removed.".lightred
    else
      puts "#{@config_file} saved.".lightgreen
    end
  end
end
