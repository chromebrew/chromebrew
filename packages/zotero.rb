# Thanks to @agkphysics of AUR repository for his zotero pkgbuild, which heavily based this package.

require 'package'

class Zotero < Package                 # The first character of the class name must be upper case
  description 'A free, easy-to-use tool to help you collect, organize, cite, and share your research sources..'
  homepage 'https://www.zotero.org/'
  version '6.0.26'
  license 'AGPL3' # license of source
  compatibility 'x86_64'
  source_url 'https://aur.archlinux.org/cgit/aur.git/plain/zotero.desktop?h=zotero'
  source_sha256 'eab76db7a56a4d9aaa17baaf240b82fcf57944a4ddf8ef1b58cc64182426cedc'   # Use the command "sha256sum"

  depends_on 'dbus_glib'            # packages required by this package
  depends_on 'gtk3'
  depends_on 'desktop_file_utils'
  depends_on 'nss'
  depends_on 'libxt'
  depends_on 'perl'
  depends_on 'node' => :build      # packages with "=> :build" are only required if you're building from source 
  depends_on 'git' => :build
  depends_on 'zip' => :build
  depends_on 'unzip' => :build
  depends_on 'python3' => :build
  depends_on 'curl' => :build
  depends_on 'wget' => :build
  depends_on 'rsync' => :build
  depends_on 'nodebrew' => :build

  def self.build                   # the steps required to build the package
    $srcdir = `realpath . | tr -d '\n'`

    system "git clone -b 6.0.26 https://github.com/zotero/zotero.git"
    system "git clone https://github.com/zotero/zotero-build.git"
    system "git clone -b 6.0.26 https://github.com/zotero/zotero-standalone-build.git"
    system "git clone https://github.com/zotero/translators.git"
    system "git clone https://github.com/zotero/bundled-styles.git"
    system "git clone https://github.com/zotero/pdf-worker.git"
    system "git clone https://github.com/zotero/note-editor.git"
    system "git clone https://github.com/zotero/pdf-reader.git"
    system "git clone https://github.com/zotero/zotero-schema.git"
    system "git clone https://github.com/gildas-lormeau/SingleFile.git"
    system "git clone https://github.com/zotero/utilities.git"
    system "git clone https://github.com/zotero/translate.git"
    system "git clone https://github.com/citation-style-language/locales.git"
    system "git clone https://github.com/egh/zotero-transfw.git"
    system "git clone https://github.com/zotero/zotero-libreoffice-integration.git"
    system "git clone https://github.com/zotero/pdf.js.git"

    system "echo downloaded resources"

    system "ls -l -a"
    Dir.chdir("zotero-build") {
      system "git submodule init"
      system "echo \"#{$srcdir}/zotero-transfw\""
      system "git config submodule.xpi/zotero-transfw.url \"#{$srcdir}/zotero-transfw\""
      system "git -c protocol.file.allow=always submodule update"
      system "echo 'Step 1: PASSED'"
    }
    
    Dir.chdir("zotero") {
      system "git submodule init"
      system "git config submodule.translators.url '#{$srcdir}/translators'"
      system "git config submodule.styles.url '#{$srcdir}/bundled-styles'"
      system "git config submodule.pdf-worker.url '#{$srcdir}/pdf-worker'"
      system "git config submodule.note-editor.url '#{$srcdir}/note-editor'"
      system "git config submodule.pdf-reader.url '#{$srcdir}/pdf-reader'"
      system "git config submodule.resource/schema/global.url '#{$srcdir}/zotero-schema'"
      system "git config submodule.resource/SingleFile.url '#{$srcdir}/SingleFile'"
      system "git config submodule.chrome/content/zotero/xpcom/utilities.url '#{$srcdir}/utilities'"
      system "git config submodule.chrome/content/zotero/xpcom/translate.url '#{$srcdir}/translate'"
      system "git config submodule.chrome/content/zotero/locale/csl.url '#{$srcdir}/locales'"
      system "git -c protocol.file.allow=always submodule update"
      system "echo 'Step 2: PASSED'"

      Dir.chdir("pdf-reader") {
        system "git submodule init"
        system "git config submodule.pdf.js.url '#{$srcdir}/pdf.js'"
        system "git -c protocol.file.allow=always submodule update"
      }

      Dir.chdir("pdf-worker") {
        system "git submodule init"
        system "git config submodule.pdf.js.url '#{$srcdir}/pdf.js'"
      }

      system "echo 'Installing LTS node.js...'"

      system "nodebrew install v18.16.1 || true" # if node version is already present or locale is not correct somehow it'd throw an error and exit the script
      system "nodebrew exec v18.16.1 npm i --legacy-peer-deps"
    }

    system "ls -l -a"

    Dir.chdir("zotero-standalone-build") {
      system "git submodule init"
      system "git config submodule.modules/zotero-libreoffice-integration.url '#{$srcdir}/zotero-libreoffice-integration'"
      system "git -c protocol.file.allow=always submodule update"
      system "echo Fetching for standalone building..."
      system "./fetch_xulrunner.sh -p l"
      system "./fetch_pdftools"
    }

    system "mv zotero zotero-client"

    Dir.chdir("zotero-client") {
      system "Actually building..."
      system "NODE_OPTIONS=--openssl-legacy-provider nodebrew exec v18.16.1 npm run build"
    }

    Dir.chdir("zotero-standalone-build") {
      system "scripts/dir_build -p l"
    }
  end

  def self.install                 # the steps required to install the package
    system "install -dDm755 #{CREW_DEST_PREFIX}/{bin,lib/zotero}"
    system "mv '#{$srcdir}/zotero-standalone-build/staging/Zotero_linux-x86_64'/* '#{CREW_DEST_PREFIX}/lib/zotero'"
    system "ln -s '#{CREW_DEST_PREFIX}/lib/zotero/zotero' '#{CREW_DEST_PREFIX}/bin/zotero'"
    system "install -Dm644 '#{$srcdir}/zotero.desktop' '#{CREW_DEST_PREFIX}/share/applications/zotero.desktop'"
    system "install -Dm644 '#{CREW_DEST_PREFIX}/lib/zotero/chrome/icons/default/default16.png' '#{CREW_DEST_PREFIX}/share/icons/hicolor/16x16/apps/zotero.png'"
    system "install -Dm644 '#{CREW_DEST_PREFIX}/lib/zotero/chrome/icons/default/default32.png' '#{CREW_DEST_PREFIX}/share/icons/hicolor/32x32/apps/zotero.png'"
    system "install -Dm644 '#{CREW_DEST_PREFIX}/lib/zotero/chrome/icons/default/default48.png' '#{CREW_DEST_PREFIX}/share/icons/hicolor/48x48/apps/zotero.png'"
    system "install -Dm644 '#{CREW_DEST_PREFIX}/lib/zotero/chrome/icons/default/default256.png' '#{CREW_DEST_PREFIX}/share/icons/hicolor/256x256/apps/zotero.png'"
    system "desktop-file-edit --set-icon=#{CREW_PREFIX}/share/icons/hicolor/256x256/apps/zotero.png #{CREW_DEST_PREFIX}/share/applications/zotero.desktop"
  end
end
