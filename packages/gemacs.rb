require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  @_ver = '28.0.50.1'
  version "#{@_ver}-01b0"
  license 'GPL-3+, FDL-1.3+, BSD, HPND, MIT, W3C, unicode, PSF-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/emacs.git'
  git_branch 'feature/pgtk'
  git_hashtag '01b0a909b5ca858a09484821cc866127652f4153'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gemacs/28.0.50.1-01b0_armv7l/gemacs-28.0.50.1-01b0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gemacs/28.0.50.1-01b0_armv7l/gemacs-28.0.50.1-01b0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gemacs/28.0.50.1-01b0_i686/gemacs-28.0.50.1-01b0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gemacs/28.0.50.1-01b0_x86_64/gemacs-28.0.50.1-01b0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8ba0433113a23361cf961d372c8e7db79206c5baf3046255bebec0acd1d73452',
     armv7l: '8ba0433113a23361cf961d372c8e7db79206c5baf3046255bebec0acd1d73452',
       i686: 'e1a0efa63cf40683ddfd90ca181f43e50d87bbf6179774f976e6cc8f917f0205',
     x86_64: '8f462f3de1a19f67a36e6752124da213add709a075cd8bc52815452d9bf68b16'
  })

  depends_on 'alsa_lib'
  depends_on 'cairo'
  depends_on 'freetype' => :build
  depends_on 'giflib'
  depends_on 'gpm'
  depends_on 'gtk3'
  depends_on 'harfbuzz'
  depends_on 'jansson'
  depends_on 'libjpeg'
  depends_on 'libotf'
  depends_on 'libpng'
  depends_on 'librsvg'
  depends_on 'libtiff'
  depends_on 'texinfo'
  depends_on 'webkit2gtk'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure \
      --enable-link-time-optimization \
      --localstatedir=#{CREW_PREFIX}/share \
      --prefix=#{CREW_PREFIX} \
      --with-cairo \
      --with-gif=ifavailable \
      --with-jpeg=yes \
      --with-modules \
      --with-native-compilation \
      --without-gconf \
      --without-gsettings \
      --without-selinux \
      --without-x \
      --with-pgtk \
      --with-png=yes \
      --with-rsvg=yes \
      --with-sound=alsa \
      --with-tiff=ifavailable \
      --with-x-toolkit=gtk3 \
      --with-xwidgets"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install 'src/emacs', "#{CREW_DEST_PREFIX}/bin/gemacs", mode: 0o755
    FileUtils.install "src/emacs-#{@_ver}", "#{CREW_DEST_PREFIX}/bin/gemacs-#{@_ver}", mode: 0o755
  end
end
