require 'package'

class Pkg_7_zip < Package
  description 'Official implantation of 7za.exe in Linux. File archiver with a high compression ratio.'
  homepage 'https://www.7-zip.org'
  license 'LGPL-2.1+'
  version '26.06'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/ip7z/7zip/releases/download/#{version}/7z#{version.delete('.')}-linux-arm.tar.xz",
     armv7l: "https://github.com/ip7z/7zip/releases/download/#{version}/7z#{version.delete('.')}-linux-arm.tar.xz",
       i686: "https://github.com/ip7z/7zip/releases/download/#{version}/7z#{version.delete('.')}-linux-x86.tar.xz",
     x86_64: "https://github.com/ip7z/7zip/releases/download/#{version}/7z#{version.delete('.')}-linux-x64.tar.xz"
  })
  source_sha256({
    aarch64: 'aeac17d8740c10419fb15759d2831a5221e7b8c0fd3f665cb0564fcec5832c59',
     armv7l: 'aeac17d8740c10419fb15759d2831a5221e7b8c0fd3f665cb0564fcec5832c59',
       i686: '53b527b3e5e1e7107abdbfce78bf16ca325b42e78e0b94c17dea1880cbef2e74',
     x86_64: '2b539cf067b2ad48e1baa5093dbaa8818b73542d1222a0ffde9dc5f2922ea62e'
  })

  no_compile_needed

  def self.install
    FileUtils.install '7zz', "#{CREW_DEST_PREFIX}/bin/7zz", mode: 0o755
    FileUtils.install '7zzs', "#{CREW_DEST_PREFIX}/bin/7zzs", mode: 0o755
    FileUtils.ln_s "#{CREW_PREFIX}/bin/7zz", "#{CREW_DEST_PREFIX}/bin/7z"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/7zz", "#{CREW_DEST_PREFIX}/bin/7za"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/7zz", "#{CREW_DEST_PREFIX}/bin/7zr"
  end
end
