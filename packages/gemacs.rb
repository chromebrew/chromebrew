require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  @_ver = '28.0.50.1'
  version "#{@_ver}-7a7b"
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-28.0.50.1-7a7b-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-28.0.50.1-7a7b-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-28.0.50.1-7a7b-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-28.0.50.1-7a7b-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '74066f8609ca1403609962454feff1a85aedb24a3d56dbfcae4a3aad8d00f836',
     armv7l: '74066f8609ca1403609962454feff1a85aedb24a3d56dbfcae4a3aad8d00f836',
       i686: '401243600795df8a6c375a7e581b939e258d1697595e9a43573860fca34656c0',
     x86_64: '702ac1d56095b1032d387a2e4736e6f8ac49d4d16a165cbc1142cb5ffe394454'
  })

  depends_on 'alsa_lib'
  depends_on 'cairo'
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

  def self.prebuild
    @git_dir = 'emacs_git'
    @git_branch = 'feature/pgtk'
    @git_hash = '7a7bc15242896b20c7af49f77f0e22c3d78e4d88'
    @git_url = 'https://git.savannah.gnu.org/git/emacs.git'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git remote set-branches origin '#{@git_branch}'"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
    end
  end

  def self.build
    Dir.chdir 'emacs_git' do
      system 'NOCONFIGURE=1 ./autogen.sh'
      system "env CFLAGS='-pipe -fuse-ld=gold -flto=auto' CXXFLAGS='-pipe -fuse-ld=gold -flto=auto' \
        LDFLAGS='-flto=auto' \
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
  end

  def self.install
    Dir.chdir 'emacs_git' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      system "install -Dm755 src/emacs #{CREW_DEST_PREFIX}/bin/gemacs"
      system "install -Dm755 src/emacs-#{@_ver} #{CREW_DEST_PREFIX}/bin/gemacs-#{@_ver}"
    end
  end
end
