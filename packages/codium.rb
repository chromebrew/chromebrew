require 'package'

class Codium < Package
  description 'Vscodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.36.1'
  source_url 'https://github.com/VSCodium/vscodium/archive/1.36.1.tar.gz'
  source_sha256 'a2858f76abc4da57a0db4f8127b42b12f065d96dad172bb9f4f2b04c2805f82b'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/codium-1.36.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: 'fcb7f36f5be299ece9473e082105cfa843bd011e595b1c7545d7b4acef572aa5',
  })

  depends_on 'nodebrew'
  depends_on 'yarn' => :build
  depends_on 'gtk2'
  depends_on 'jq'
  depends_on 'ld_default'
  depends_on 'libsecret'
  depends_on 'libgconf'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  case ARCH
  when 'x86_64'
    @arch = 'x64'
  when 'i686'
    @arch = 'ia32'
  when 'armv7l', 'aarch64'
    @arch = 'arm64'
  end

  ENV['PATH'] = "#{ENV['HOME']}/.yarn/bin:#{ENV['PATH']}"
  ENV['LIBRARY_PATH'] = CREW_LIB_PREFIX

  def self.build
    old_ld = `ld_default b`.chomp
    node_ver = 'v10.16.0'
    node_ver = 'v9.11.2' if ARCH == 'i686'
    node_old = `nodebrew ls | fgrep 'current: ' | cut -d' ' -f2`.chomp
    node_ver_installed = `nodebrew ls | grep -o #{node_ver} | head -1`.chomp
    system "bash ./get_repo.sh"
    system "cp -rp  src/* vscode/;rm -rf src;mv vscode/* ./;mv vscode/.yarnrc ./;rm -rf vscode"
    system "nodebrew install #{node_ver}" unless node_ver_installed == node_ver
    system "nodebrew use #{node_ver}" unless node_old == node_ver
    system 'npm install gulp'
    system 'bash ./update_settings.sh'
    system 'yarn install'
    system 'mv product.json product.json.bak'
    # set fields in product.json
    tipsAndTricksUrl='setpath(["tipsAndTricksUrl"]; "https://go.microsoft.com/fwlink/?linkid=852118")'
    twitterUrl='setpath(["twitterUrl"]; "https://go.microsoft.com/fwlink/?LinkID=533687")'
    requestFeatureUrl='setpath(["requestFeatureUrl"]; "https://go.microsoft.com/fwlink/?LinkID=533482")'
    documentationUrl='setpath(["documentationUrl"]; "https://go.microsoft.com/fwlink/?LinkID=533484#vscode")'
    introductoryVideosUrl='setpath(["introductoryVideosUrl"]; "https://go.microsoft.com/fwlink/?linkid=832146")'
    extensionAllowedBadgeProviders='setpath(["extensionAllowedBadgeProviders"]; ["api.bintray.com", "api.travis-ci.com", "api.travis-ci.org", "app.fossa.io", "badge.fury.io", "badge.waffle.io", "badgen.net", "badges.frapsoft.com", "badges.gitter.im", "badges.greenkeeper.io", "cdn.travis-ci.com", "cdn.travis-ci.org", "ci.appveyor.com", "circleci.com", "cla.opensource.microsoft.com", "codacy.com", "codeclimate.com", "codecov.io", "coveralls.io", "david-dm.org", "deepscan.io", "dev.azure.com", "flat.badgen.net", "gemnasium.com", "githost.io", "gitlab.com", "godoc.org", "goreportcard.com", "img.shields.io", "isitmaintained.com", "marketplace.visualstudio.com", "nodesecurity.io", "opencollective.com", "snyk.io", "travis-ci.com", "travis-ci.org", "visualstudio.com", "vsmarketplacebadge.apphb.com", "www.bithound.io", "www.versioneye.com"])'
    updateUrl='setpath(["updateUrl"]; "https://vscodium.now.sh")'
    releaseNotesUrl='setpath(["releaseNotesUrl"]; "https://go.microsoft.com/fwlink/?LinkID=533483#vscode")'
    keyboardShortcutsUrlMac='setpath(["keyboardShortcutsUrlMac"]; "https://go.microsoft.com/fwlink/?linkid=832143")'
    keyboardShortcutsUrlLinux='setpath(["keyboardShortcutsUrlLinux"]; "https://go.microsoft.com/fwlink/?linkid=832144")'
    keyboardShortcutsUrlWin='setpath(["keyboardShortcutsUrlWin"]; "https://go.microsoft.com/fwlink/?linkid=832145")'
    quality='setpath(["quality"]; "stable")'
    extensionsGallery='setpath(["extensionsGallery"]; {"serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery", "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index", "itemUrl": "https://marketplace.visualstudio.com/items"})'
    nameShort='setpath(["nameShort"]; "VSCodium")'
    nameLong='setpath(["nameLong"]; "VSCodium")'
    linuxIconName='setpath(["linuxIconName"]; "vscodium")'
    applicationName='setpath(["applicationName"]; "codium")'
    win32MutexName='setpath(["win32MutexName"]; "vscodium")'
    win32DirName='setpath(["win32DirName"]; "VSCodium")'
    win32NameVersion='setpath(["win32NameVersion"]; "VSCodium")'
    win32RegValueName='setpath(["win32RegValueName"]; "VSCodium")'
    win32AppUserModelId='setpath(["win32AppUserModelId"]; "Microsoft.VSCodium")'
    win32ShellNameShort='setpath(["win32ShellNameShort"]; "V&SCodium")'
    win32x64UserAppId='setpath (["win32x64UserAppId"]; "{{2E1F05D1-C245-4562-81EE-28188DB6FD17}")'
    urlProtocol='setpath(["urlProtocol"]; "vscodium")'
    extensionAllowedProposedApi='setpath(["extensionAllowedProposedApi"]; getpath(["extensionAllowedProposedApi"]) + ["ms-vsliveshare.vsliveshare"])'
    product_json_changes="#{tipsAndTricksUrl} | #{twitterUrl} | #{requestFeatureUrl} | #{documentationUrl} | #{introductoryVideosUrl} | #{extensionAllowedBadgeProviders} | #{updateUrl} | #{releaseNotesUrl} | #{keyboardShortcutsUrlMac} | #{keyboardShortcutsUrlLinux} | #{keyboardShortcutsUrlWin} | #{quality} | #{extensionsGallery} | #{nameShort} | #{nameLong} | #{linuxIconName} | #{applicationName} | #{win32MutexName} | #{win32DirName} | #{win32NameVersion} | #{win32RegValueName} | #{win32AppUserModelId} | #{win32ShellNameShort} | #{win32x64UserAppId} | #{urlProtocol} | #{extensionAllowedProposedApi}"
    system "cat product.json.bak | jq '#{product_json_changes}' > product.json"
    system "bash ./undo_telemetry.sh"
    ENV['NODE_ENV'] = 'production'

    # Fix for segfault while running 'yarn'.  See https://github.com/Microsoft/vscode/issues/53634.
    system "sed -i 's,--max_old_space_size=4095,--max_old_space_size=2048,g' package.json" unless ARCH == 'x86_64'

    system "yarn run gulp vscode-linux-#{@arch}"
    system "nodebrew uninstall #{node_ver}" unless node_ver_installed == node_ver
    system "nodebrew use #{node_old}" unless node_old == "none"
    system 'ld_default', "#{old_ld}"
    # Add the Marketplace for extensions.
    system "cat << 'EOF' >> product.json
\"extensionsGallery\": {
    \"serviceUrl\": \"https://marketplace.visualstudio.com/_apis/public/gallery\",
    \"cacheUrl\": \"https://vscode.blob.core.windows.net/gallery/index\",
    \"itemUrl\": \"https://marketplace.visualstudio.com/items\"
}
EOF"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system 'mv', "../VSCode-linux-#{@arch}", "#{CREW_DEST_PREFIX}/share/codium"
    system "sed -i -e '/CLI=/d' -e 's,\"\\$CLI\" ,,g' -e 's,ELECTRON_RUN_AS_NODE=1 ,,g' #{CREW_DEST_PREFIX}/share/codium/bin/codium"
    system "sed -i '42iGDK_BACKEND=x11' #{CREW_DEST_PREFIX}/share/codium/bin/codium"
    system 'ln', '-s', '../share/codium/bin/codium', "#{CREW_DEST_PREFIX}/bin/codium"
  end

  def self.postinstall
    puts
    puts 'Congratulations! You have installed Visual Studio Codium on Chrome OS!'.lightgreen
    puts 'Now, please run \'codium\' to start VS Codium.'.lightgreen
    puts 'Happy coding!'.lightgreen
    puts
  end
end
