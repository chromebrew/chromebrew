require 'package'

class Musl_linuxheaders < Package
  description 'Linux headers for Chrome OS, installed into MUSL_PREFIX.'
  homepage 'https://kernel.org/'
  version CREW_KERNEL_VERSION
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/third_party/kernel.git'
  git_hashtag "chromeos-#{CREW_KERNEL_VERSION}"
  binary_compression 'tar.zst'

  case CREW_KERNEL_VERSION
  when '3.8'
    binary_url({
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_linuxheaders/3.8_i686/musl_linuxheaders-3.8-chromeos-i686.tpxz'
    })
    binary_sha256({
      i686: '92c0794189e3631847293ae517b4e0a7bc41e9898433d514f46391b5807369cd'
    })
  when '4.14'
    binary_url({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_linuxheaders/4.14_armv7l/musl_linuxheaders-4.14-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_linuxheaders/4.14_armv7l/musl_linuxheaders-4.14-chromeos-armv7l.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_linuxheaders/4.14_x86_64/musl_linuxheaders-4.14-chromeos-x86_64.tpxz'
    })
    binary_sha256({
     aarch64: '0673fa9ca73c10b60d4109dacc349247f98b5ea616110650a9f2917a281d780a',
      armv7l: '0673fa9ca73c10b60d4109dacc349247f98b5ea616110650a9f2917a281d780a',
      x86_64: '8cb5a33d005cae9be24d2491d20b855c9561853f89f974159094bb66ef41b02f'
    })
  when '5.10'
    binary_url({
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_linuxheaders/5.10_x86_64/musl_linuxheaders-5.10-chromeos-x86_64.tar.zst'
    })
    binary_sha256({
      x86_64: '4492e6a1a52b9ca39f11c9d68869761a3698c8d65bea501f57ad514298b9d182'
    })
  end

  no_env_options
  no_fhs

  def self.install
    # make fails if it detects gold linker.
    FileUtils.mkdir_p('crew_bin')
    @workdir = Dir.pwd
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/ld.bfd", "#{@workdir}/crew_bin/ld"
    system "PATH=#{@workdir}/crew_bin:$PATH make defconfig"
    system "PATH=#{@workdir}/crew_bin:$PATH make headers_install INSTALL_HDR_PATH=#{CREW_DEST_MUSL_PREFIX}"
    Dir.chdir("#{CREW_DEST_MUSL_PREFIX}/include") do
      system "for file in \$(find . -not -type d -name '.*'); do
                rm \${file};
              done"
    end
  end
end
