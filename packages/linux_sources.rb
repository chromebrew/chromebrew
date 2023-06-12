require 'package'

class Linux_sources < Package
  description 'Sources for the Linux kernel'
  homepage 'https://kernel.org/'
  version = CREW_KERNEL_VERSION == '4.14' ? "#{CREW_KERNEL_VERSION}-1" : CREW_KERNEL_VERSION
  version version
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/third_party/kernel.git'
  git_hashtag "chromeos-#{CREW_KERNEL_VERSION}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_sources/4.14-1_armv7l/linux_sources-4.14-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_sources/4.14-1_armv7l/linux_sources-4.14-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_sources/3.8_i686/linux_sources-3.8-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linux_sources/4.14-1_x86_64/linux_sources-4.14-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c9b3116f83033215bf7f925a433bcea906067006d8c4c3f9747a279d729d4db0',
     armv7l: 'c9b3116f83033215bf7f925a433bcea906067006d8c4c3f9747a279d729d4db0',
       i686: '2e8cf6b96bfb2f1f65809123696799244ac20b3a7a6b516d00d9f09a0b682266',
     x86_64: '5dc236576f40cbf6926b4b5f9241ed7e9e3e7db8f2b26643316a2ce1f08a4a02'
  })

  no_env_options
  no_fhs

  def self.install
    linux_src_dir = "#{CREW_DEST_PREFIX}/src/linux"
    FileUtils.mkdir_p(linux_src_dir)
    # make fails if it detects gold linker.
    FileUtils.mkdir_p("#{linux_src_dir}/crew_bin")
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/ld.bfd", "#{linux_src_dir}/crew_bin/ld"
    FileUtils.rm_rf('.git')
    FileUtils.cp_r('.', linux_src_dir)
    Dir.chdir(linux_src_dir) do
      system "PATH=#{linux_src_dir}/crew_bin:$PATH make defconfig"
    end
    FileUtils.rm_f "#{linux_src_dir}/crew_bin"
  end
end
