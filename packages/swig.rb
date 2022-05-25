require 'buildsystems/autotools'

class Swig < Autotools
  description 'Simplified Wrapper and Interface Generator'
  homepage 'http://www.swig.org'
  version '4.1.1-1'
  license 'GPL-3, BSD and BSD-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/swig/swig/swig-4.1.1/swig-4.1.1.tar.gz'
  source_sha256 '2af08aced8fcd65cdb5cc62426768914bedc735b1c250325203716f78e39ac9b'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.1.1-1_armv7l/swig-4.1.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.1.1-1_armv7l/swig-4.1.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.1.1-1_i686/swig-4.1.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swig/4.1.1-1_x86_64/swig-4.1.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c6bcbd9582e70c4209eedbb931dd236c030a99cd4150c0ebfac1b250a7912a5b',
     armv7l: 'c6bcbd9582e70c4209eedbb931dd236c030a99cd4150c0ebfac1b250a7912a5b',
       i686: '5a1c1666474182c3f3f20a8dd5fc3ff659d603cb816210488c5abfee413c8934',
     x86_64: '99ebb3ed84b2a5cee79ce6fc228d64ed65249e9d96ac8d8d90c388075f3d6eda'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'pcre' => :build
  depends_on 'pcre2' # R
  depends_on 'zlibpkg' # R
end
