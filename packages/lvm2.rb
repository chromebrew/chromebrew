require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.03.15'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/lvm2.git'
  git_hashtag "v#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.15_armv7l/lvm2-2.03.15-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.15_armv7l/lvm2-2.03.15-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.15_i686/lvm2-2.03.15-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.15_x86_64/lvm2-2.03.15-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8cfc43361bba3afa4985b060648be0d72adcb7a2e0f27a7fdf771e26adef7219',
     armv7l: '8cfc43361bba3afa4985b060648be0d72adcb7a2e0f27a7fdf771e26adef7219',
       i686: 'fcc82c8f6189cd3e7050db3b6a2d4b2e18f920888e438c94bbe1620331aa2932',
     x86_64: 'c0cd04e473acf8aec4ca3030fce901c793b0b40947f1aa44b2be8b7fea863f24'
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
      --enable-cmdlib \
      --enable-dmeventd \
      --enable-pkgconfig \
      --with-symvers=no \
      --with-confdir=#{CREW_PREFIX}/etc"
    system "PATH=#{@pwd}/bin:\$PATH make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
