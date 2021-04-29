require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  @_ver = '28.0.50.1'
  version "#{@_ver}-7a7b"
  license 'GPL-3+, FDL-1.3+, BSD, HPND, MIT, W3C, unicode, PSF-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/emacs.git'
  git_branch 'feature/pgtk'
  git_hashtag '7a7bc15242896b20c7af49f77f0e22c3d78e4d88'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gemacs/28.0.50.1-7a7b_armv7l/gemacs-28.0.50.1-7a7b-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gemacs/28.0.50.1-7a7b_armv7l/gemacs-28.0.50.1-7a7b-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gemacs/28.0.50.1-7a7b_i686/gemacs-28.0.50.1-7a7b-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gemacs/28.0.50.1-7a7b_x86_64/gemacs-28.0.50.1-7a7b-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '74066f8609ca1403609962454feff1a85aedb24a3d56dbfcae4a3aad8d00f836',
     armv7l: '74066f8609ca1403609962454feff1a85aedb24a3d56dbfcae4a3aad8d00f836',
       i686: '401243600795df8a6c375a7e581b939e258d1697595e9a43573860fca34656c0',
     x86_64: '702ac1d56095b1032d387a2e4736e6f8ac49d4d16a165cbc1142cb5ffe394454'
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
