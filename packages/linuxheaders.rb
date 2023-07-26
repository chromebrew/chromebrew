require 'package'

class Linuxheaders < Package
  description 'Linux headers for Chrome OS.'
  homepage 'https://kernel.org/'
  revision 1
  version CREW_KERNEL_VERSION == '4.14' ? "#{CREW_KERNEL_VERSION}-#{revision}" : CREW_KERNEL_VERSION
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/third_party/kernel.git'
  git_hashtag "chromeos-#{CREW_KERNEL_VERSION}"

  if CREW_KERNEL_VERSION == '3.8'
    binary_url({
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/3.8_i686/linuxheaders-3.8-chromeos-i686.tpxz'
    })
    binary_sha256({
      i686: 'c16afcd95ebcffac67a026b724da19f498003ea80c13c87aeb613f09d412bb91'
    })
  elsif CREW_KERNEL_VERSION == '4.14'
    binary_url({
      aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.14-1_armv7l/linuxheaders-4.14-1-chromeos-armv7l.tpxz',
       armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.14-1_armv7l/linuxheaders-4.14-1-chromeos-armv7l.tpxz',
       x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.14-1_x86_64/linuxheaders-4.14-1-chromeos-x86_64.tpxz'
    })
    binary_sha256({
      aarch64: '75f253ac2cf0dd785ea8d9cdf9430d23d601ccc372e9f7afa95523a28273a340',
       armv7l: '75f253ac2cf0dd785ea8d9cdf9430d23d601ccc372e9f7afa95523a28273a340',
       x86_64: '5d58b327ca9bab5630f0df387a3036125e1f367e6c43cd551f4734ee3e634073'
    })
  elsif CREW_KERNEL_VERSION == '4.19'
    binary_url({
      aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.19_armv7l/linuxheaders-4.19-chromeos-armv7l.tar.zst',
       armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.19_armv7l/linuxheaders-4.19-chromeos-armv7l.tar.zst',
       x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.19_x86_64/linuxheaders-4.19-chromeos-x86_64.tar.zst'
    })
    binary_sha256({
      aarch64: 'cc9227b5b3af3abdaba4c1eb6b5df066af6c5f20629cee3a4e351b3e40521760',
       armv7l: 'cc9227b5b3af3abdaba4c1eb6b5df066af6c5f20629cee3a4e351b3e40521760',
       x86_64: 'ea112d55cb33823a473791d146d124ae5d2cce7fb72ebe0b047d5937957ee994'
    })
  elsif CREW_KERNEL_VERSION == '5.4'
    binary_url({
      aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/5.4_armv7l/linuxheaders-5.4-chromeos-armv7l.tar.zst',
       armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/5.4_armv7l/linuxheaders-5.4-chromeos-armv7l.tar.zst',
       x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/5.4_x86_64/linuxheaders-5.4-chromeos-x86_64.tar.zst'
    })
    binary_sha256({
      aarch64: 'b790edcfe5bcad8fc7e7b873a6ba8f9ad147b00849db2afead5f51e19f699df7',
       armv7l: 'b790edcfe5bcad8fc7e7b873a6ba8f9ad147b00849db2afead5f51e19f699df7',
       x86_64: 'e6ea539149f4333518787eb1e0fa436d0914990fd2899011c277ab418a9b78ba'
    })
  elsif CREW_KERNEL_VERSION == '5.15' && ARCH == 'x86_64'
    binary_url({
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/5.15_x86_64/linuxheaders-5.15-chromeos-x86_64.tar.zst'
    })
    binary_sha256({
      x86_64: '5b0fa3daf6ac8f2cd1028bd326a6c64f0cac052ba225845ba314e06d12a3de76'
    })
  else
    binary_url({
      aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/5.10_armv7l/linuxheaders-5.10-chromeos-armv7l.tar.zst',
       armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/5.10_armv7l/linuxheaders-5.10-chromeos-armv7l.tar.zst',
       x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/5.10_x86_64/linuxheaders-5.10-chromeos-x86_64.tar.zst'
    })
    binary_sha256({
      aarch64: '23b6f70dad19663d42a1bb8707e66eb1b35c4934ef051577701397b4708e8cff',
       armv7l: '23b6f70dad19663d42a1bb8707e66eb1b35c4934ef051577701397b4708e8cff',
       x86_64: '797e7a8369f613b50b049b2352f82d5842a2c9ae766d6d5b1165b90a528ac139'
    })
  end

  no_env_options
  no_fhs

  def self.install
    # make fails if it detects gold linker.
    FileUtils.mkdir_p('crew_bin')
    @workdir = Dir.pwd
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/ld.bfd", "#{@workdir}/crew_bin/ld"
    @kbuild_arch = case ARCH
                   when 'armv7l', 'aarch64'
                     'arm'
                   else
                     'x86'
                   end
    system "ARCH=#{@kbuild_arch} PATH=#{@workdir}/crew_bin:$PATH make defconfig"
    system "ARCH=#{@kbuild_arch} PATH=#{@workdir}/crew_bin:$PATH make headers_install INSTALL_HDR_PATH=#{CREW_DEST_PREFIX}"
    Dir.chdir("#{CREW_DEST_PREFIX}/include") do
      system "for file in $(find . -not -type d -name '.*'); do
                rm ${file};
              done"
    end
  end

  def self.postinstall
    return unless %w[3.8 4.14 5.4 5.10 5.15].include? CREW_KERNEL_VERSION

    puts 'The installed kernel headers do NOT match the current kernel version.'.orange
    puts 'Please build and install the appropriate kernel headers with:'.orange
    puts 'crew reinstall -s linuxheaders'.lightblue
  end
end
