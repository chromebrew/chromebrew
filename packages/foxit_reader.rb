require 'package'

class Foxit_reader < Package
  description "Industry's most powerful PDF reader. View, annotate, form fill, and sign PDFs."
  homepage 'https://www.foxit.com/pdf-reader/'
  version '2.4.5.0727'
  license 'Foxit'
  compatibility 'x86_64'
  source_url 'SKIP'

  depends_on 'cups' # R
  depends_on 'e2fsprogs' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'krb5' # R
  depends_on 'libglvnd' # R
  depends_on 'libgpg_error' # R
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxi' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxrender' # R
  depends_on 'libxslt' # R
  depends_on 'pango' # R
  depends_on 'pkg_7_zip' => :build
  depends_on 'qt5_declarative' # R
  depends_on 'qt5_location' # R
  depends_on 'sommelier' => :logical
  depends_on 'zlib' # R

  ignore_updater # Linux version appears abandoned.
  no_compile_needed

  def self.install
    # Adapted from https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=foxitreader
    major = version.split('.')[0]
    minor = version.split('.').slice(0..1).join('.')
    downloader "https://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/#{major}.x/#{minor}/en_us/FoxitReader.enu.setup.#{version}.x64.run.tar.gz", '633279b6c9fcfa3c45e055df321a87d633ecfea11f668a06e838bb91b5bf6247', 'foxit.x64.run.tar.gz'
    system 'tar fx foxit.x64.run.tar.gz'
    system 'mv *.run foxit.x64.run'
    positions = `LANG=C grep --only-matching --byte-offset --binary \
              --text $'7z\\xBC\\xAF\\x27\\x1C' foxit.x64.run | cut -f1 -d:`.chomp.split
    FileUtils.mkdir 'build'
    positions.each do |position|
      system "dd if=foxit.x64.run \
              bs=1M iflag=skip_bytes status=none skip=#{position} \
              of=foxit-installer-bin-#{position}.7z && 7z -bd -bb0 -y x -obuild foxit-installer-bin-#{position}.7z || true"
    end
    # Define directories.
    bin_path = "#{CREW_DEST_PREFIX}/bin"
    root_path = "#{CREW_PREFIX}/share/foxitreader"
    dest_path = "#{CREW_DEST_PREFIX}/share/foxitreader"
    app_path = "#{CREW_DEST_PREFIX}/share/applications"
    icon_path = "#{CREW_DEST_PREFIX}/share/icons/hicolor/64x64/apps"

    # Create directories.
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mkdir_p bin_path.to_s
    FileUtils.mkdir_p app_path.to_s
    FileUtils.mkdir_p icon_path.to_s

    unneeded_files = %w[
      Activation Activation.desktop Activation.sh
      countinstalltion countinstalltion.sh
      installUpdate ldlibrarypath.sh
      maintenancetool.sh Uninstall.desktop
      Update.desktop updater updater.sh
    ]
    unneeded_files.each { |f| FileUtils.rm "build/#{f}" }
    FileUtils.mv 'build', dest_path

    # Add symlinks.
    FileUtils.ln_s "#{root_path}/FoxitReader", "#{bin_path}/foxit"
    FileUtils.ln_s "#{root_path}/FoxitReader", "#{bin_path}/foxitreader"
    FileUtils.ln_s "#{root_path}/FoxitReader", "#{bin_path}/FoxitReader"

    # Prepare FoxitReader.desktop and FoxitReader.ico for use with crew-launcher.
    system "sed -i 's,#{dest_path}/FoxitReader.sh,#{root_path}/FoxitReader,' #{dest_path}/FoxitReader.desktop"
    FileUtils.mv "#{dest_path}/FoxitReader.desktop", app_path.to_s
    FileUtils.mv "#{dest_path}/images/FoxitReader-64x64.ico", "#{icon_path}/FoxitReader.ico"
  end

  def self.postinstall
    ExitMessage.add "\nType 'foxit' to get started.\n"
  end
end
