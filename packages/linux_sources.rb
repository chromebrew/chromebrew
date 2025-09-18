require 'package'

class Linux_sources < Package
  description 'Sources for the Linux kernel'
  homepage 'https://kernel.org/'
  version case ARCH
          when 'i686'
            '3.8'
          when 'armv7l'
            '4.14-1'
          else
            '6.12'
          end
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/third_party/kernel.git'
  git_hashtag "chromeos-#{CREW_KERNEL_VERSION}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9b3116f83033215bf7f925a433bcea906067006d8c4c3f9747a279d729d4db0',
     armv7l: 'c9b3116f83033215bf7f925a433bcea906067006d8c4c3f9747a279d729d4db0',
       i686: '373f8d251a78c8e8ceba8a1a9d85b0fbfe106f75a5127cfb7e3274363dc211f7',
     x86_64: '4915d7e6b21e7467fc4bb7211f89ab216d86b3403127ab3af684f8d561aeeea9'
  })

  depends_on 'binutils' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

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
