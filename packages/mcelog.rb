require 'buildsystems/autotools'

class Mcelog < Autotools
  description 'logs and accounts machine checks (in particular memory, IO, and CPU hardware errors) on modern x86 Linux systems.'
  homepage 'https://www.mcelog.org/'
  version '213'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://git.kernel.org/pub/scm/utils/cpu/mce/mcelog.git/snapshot/mcelog-#{version}.tar.gz"
  source_sha256 'd93a14eb2abb26c740ec630c00e0e774fad67df4a07229399c6f977afd1ccd6a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a560af00af9e3d1aa99443c3cb565550eb948314039828034a0ae5c087a8349d',
     armv7l: 'a560af00af9e3d1aa99443c3cb565550eb948314039828034a0ae5c087a8349d',
       i686: '04a5aeba5a46e3b8a0b6eb570e43b4e83fa338ee140cb66c23c142654ea28622',
     x86_64: '3218ddade6b36775b7e19bad534ae0f94dce3c0f74856cf8a6587606a8c0f2d7'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.patch
    system "sed -i 's,prefix := /usr,prefix := #{CREW_PREFIX},' Makefile"
    system "sed -i 's,etcprefix :=,etcprefix := #{CREW_PREFIX},' Makefile"
  end

  autotools_skip_configure
end
