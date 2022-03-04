require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.03.15'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/lvm2.git'
  git_hashtag "v#{version.gsub('.','_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.15_armv7l/lvm2-2.03.15-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.15_armv7l/lvm2-2.03.15-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.15_i686/lvm2-2.03.15-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.15_x86_64/lvm2-2.03.15-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '022b9f92be300cd3e4e050c7e65753843fd300bade415e6bcc80985fb0391a03',
     armv7l: '022b9f92be300cd3e4e050c7e65753843fd300bade415e6bcc80985fb0391a03',
       i686: '705d64ffd954747b6af31a7f8c04752fa7b534806120088f242d761ba083bdb9',
     x86_64: '157b5d83f78ec358e1d4a06390528ea15f90bf5b323c7ef6fd33b6a5621b4387'
  })

  depends_on 'libaio'
  no_env_options

  def self.build
    # gold linker gives error: ltrans0.ltrans.o: multiple definition of 'dm_bitset_parse_list'
    FileUtils.mkdir_p 'bin'
    @pwd = `pwd`.chomp
    FileUtils.cp "#{CREW_PREFIX}/bin/ld.lld", 'bin/ld'
    system "#{CREW_ENV_OPTIONS.gsub('-fuse-ld=gold', '')} LD=ld.lld PATH=#{@pwd}/bin:\$PATH ./configure \
      #{CREW_OPTIONS} \
      --disable-selinux \
      --with-confdir=#{CREW_PREFIX}/etc"
    system "PATH=#{@pwd}/bin:\$PATH make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
