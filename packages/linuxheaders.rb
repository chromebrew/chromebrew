require 'package'

class Linuxheaders < Package
  description 'Linux headers for Chrome OS.'
  homepage 'https://kernel.org/'
  version CREW_KERNEL_VERSION
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/third_party/kernel.git'
  git_hashtag "chromeos-#{CREW_KERNEL_VERSION}"
  binary_compression 'tar.zst'

  case CREW_KERNEL_VERSION
  when '3.8'
    binary_sha256({
      i686: '362ab05c4f6903793560fffd33abf79e5194fb72d3d38ec1648a93c56ebf91e8'
    })
  when '4.14'
    binary_sha256({
      aarch64: 'b45bd05d2bfcdd2c0c18c02af9fdddd4008256cfd76a70681d4ae426cd2126f3',
       armv7l: 'b45bd05d2bfcdd2c0c18c02af9fdddd4008256cfd76a70681d4ae426cd2126f3',
       x86_64: 'faaa0bbe68f8052906537a2bc22d9ba957d2c51e39ce94ea50f1e37cae89a252'
    })
  when '4.19'
    binary_sha256({
      aarch64: 'cc9227b5b3af3abdaba4c1eb6b5df066af6c5f20629cee3a4e351b3e40521760',
       armv7l: 'cc9227b5b3af3abdaba4c1eb6b5df066af6c5f20629cee3a4e351b3e40521760',
       x86_64: 'ea112d55cb33823a473791d146d124ae5d2cce7fb72ebe0b047d5937957ee994'
    })
  when '5.4'
    binary_sha256({
      aarch64: 'b790edcfe5bcad8fc7e7b873a6ba8f9ad147b00849db2afead5f51e19f699df7',
       armv7l: 'b790edcfe5bcad8fc7e7b873a6ba8f9ad147b00849db2afead5f51e19f699df7',
       x86_64: 'e6ea539149f4333518787eb1e0fa436d0914990fd2899011c277ab418a9b78ba'
    })
  when '5.15'
    binary_sha256({
      aarch64: 'f777a2fa6f124a808f32dc3dea4d71d939bd6b1237d6eff6bd61e53a21d60707',
       armv7l: 'f777a2fa6f124a808f32dc3dea4d71d939bd6b1237d6eff6bd61e53a21d60707',
       x86_64: '5b0fa3daf6ac8f2cd1028bd326a6c64f0cac052ba225845ba314e06d12a3de76'
    })
  else
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
