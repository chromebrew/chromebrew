require 'buildsystems/autotools'

class Mawk < Autotools
  description 'mawk is a POSIX compatible interpreter of the awk language faster than gawk.'
  homepage 'https://invisible-island.net/mawk/'
  version '1.3.4-20260302'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://invisible-island.net/archives/mawk/mawk-#{version}.tgz"
  source_sha256 'e2c08a77d0a84a01f9be454d1ca3872d4f103f9ada683d075198b0c6e965633d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c08a37d54a0db0f2f5b0f2997f09d34fd63b14a505137aacac783017ee378f6',
     armv7l: '3c08a37d54a0db0f2f5b0f2997f09d34fd63b14a505137aacac783017ee378f6',
       i686: '097efdb81cf8dff83ca40a48b767b91dc55ac564607c7636d5683667d382f957',
     x86_64: '6c0e9e3da1bcaab5aac246df98355ad4ba02ba5dbfeb7bfc394c0ab4a4e03bab'
  })

  depends_on 'glibc' => :executable_only

  autotools_install_extras do
    FileUtils.ln_s "#{CREW_PREFIX}/bin/mawk", "#{CREW_DEST_PREFIX}/bin/awk"
  end
end
