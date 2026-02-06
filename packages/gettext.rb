require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://gnu.org/s/gettext/'
  version '1.0-1'
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  # source_url 'https://github.com/autotools-mirror/gettext.git'
  # git_hashtag "v#{version.split('-')[0]}"
  source_url "https://ftpmirror.gnu.org/gnu/gettext/gettext-#{version.split('-')[0]}.tar.lz"
  source_sha256 'd6342cbe1411a2fe7d139bfed80c2d63b1babc92acfedc72501cc105184f61ee'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c73672798c742340ed8f956c3c2b9af0c67782649bb82e4994f91ee2dee83c25',
     armv7l: 'c73672798c742340ed8f956c3c2b9af0c67782649bb82e4994f91ee2dee83c25',
       i686: 'ed254a8ada9a5f2efddbd38c8b04c7792a9d59bb45261117de2a00c14a2cb8e4',
     x86_64: 'fa19b714399cd145ca248497445ef6a46fabec1dcf2f41e7b9f8fe1d22885b86'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openjdk8' => :build
  depends_on 'wget2' => :build

  def self.patch
    # patches = [
    # # See https://savannah.gnu.org/bugs/?67999
    # ['https://github.com/autotools-mirror/gettext/commit/633b7fdef68b660802ce190f1cf0ab64eb8c3e5e.patch', '64b4d9506988c71c1a703cd731bfac204d1221e75ed794ee43109d47d9a19d7c']
    # ]
    # ConvenienceFunctions.patch(patches) if version.split('-')[0] == '1.0'
    # See https://savannah.gnu.org/bugs/?67999
    system "sed -i '/patch $@ < $(srcdir)\\/po-fetch.1.diff/d' gettext-tools/man/Makefile.am" if version.split('-')[0] == '1.0'
  end

  # --without-git is needed as per https://github.com/autotools-mirror/gettext/blob/master/PACKAGING
  # to make sure $prefix/share/gettext/archive.dir.tar.* is installed.
  autotools_configure_options '--disable-static \
    --enable-shared \
    --with-pic \
    --with-xz \
    --without-git \
    --without-included-gettext'
    
  autotools_install_extras do
    # This fixes a missing archive message from autopoint.
    # #{CREW_DEST_PREFIX}/share/gettext/archive.dir.tar.xz from our
    # build keeps getting corrupted for some reason.
    downloader "https://github.com/autotools-mirror/gettext/raw/refs/tags/v#{version.split('-')[0]}/gettext-tools/autotools/archive.dir.tar", 'e32c5de9b39a70092e9a82e83ebffb4c0a8c698cf3acbdcbb4902dfebdf767f8', "#{CREW_DEST_PREFIX}/share/gettext/archive.dir.tar"
    system "xz -v -f #{CREW_DEST_PREFIX}/share/gettext/archive.dir.tar", chdir: "#{CREW_DEST_PREFIX}/share/gettext"
  end
end
