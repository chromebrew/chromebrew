require 'package'

class Musl_linuxheaders < Package
  description 'Linux headers for Chrome OS, installed into MUSL_PREFIX.'
  homepage 'https://kernel.org/'
  version = CREW_KERNEL_VERSION == '4.14' ? "#{CREW_KERNEL_VERSION}-1" : CREW_KERNEL_VERSION
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_linuxheaders/3.8_i686/musl_linuxheaders-3.8-chromeos-i686.tpxz',
 aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_linuxheaders/4.14_armv7l/musl_linuxheaders-4.14-chromeos-armv7l.tpxz',
  armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_linuxheaders/4.14_armv7l/musl_linuxheaders-4.14-chromeos-armv7l.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_linuxheaders/4.14_x86_64/musl_linuxheaders-4.14-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: '92c0794189e3631847293ae517b4e0a7bc41e9898433d514f46391b5807369cd',
 aarch64: '0673fa9ca73c10b60d4109dacc349247f98b5ea616110650a9f2917a281d780a',
  armv7l: '0673fa9ca73c10b60d4109dacc349247f98b5ea616110650a9f2917a281d780a',
  x86_64: '8cb5a33d005cae9be24d2491d20b855c9561853f89f974159094bb66ef41b02f'
  })

  depends_on 'linux_sources' => :build

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    reload_constants
    linux_src_dir = "#{CREW_PREFIX}/src/linux"
    Dir.chdir(linux_src_dir) do
      system 'make',
             'headers_install',
             "INSTALL_HDR_PATH=#{CREW_DEST_MUSL_PREFIX}"
    end
    Dir.chdir("#{CREW_DEST_MUSL_PREFIX}/include") do
      system "for file in \$(find . -not -type d -name '.*'); do
                rm \${file};
              done"
    end
  end
end
