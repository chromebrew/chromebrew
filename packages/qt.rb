require 'package'

class Qt < Package
  description 'Qt is a comprehensive cross-platform framework and toolkit that helps you create and build native applications and user interfaces for all the screens of your end user.'
  homepage 'https://info.qt.io/download-qt-for-application-development'
  version '5.11.1'
  source_url 'http://download.qt.io/official_releases/qt/5.11/5.11.1/single/qt-everywhere-src-5.11.1.tar.xz'
  source_sha256 '39602cb08f9c96867910c375d783eed00fc4a244bffaa93b801225d17950fb2b'

  depends_on 'sommelier'

  def self.install
    case ARCH
    when 'i686', 'x86_64'
      system "echo 'function Controller() {' > qt-installer-script.qs"
      system "echo '    installer.autoRejectMessageBoxes();' >> qt-installer-script.qs"
      system "echo '    installer.installationFinished.connect(function() {' >> qt-installer-script.qs"
      system "echo '        gui.clickButton(buttons.NextButton);' >> qt-installer-script.qs"
      system "echo '    })' >> qt-installer-script.qs"
      system "echo '}' >> qt-installer-script.qs"
      system "echo 'Controller.prototype.WelcomePageCallback = function() {' >> qt-installer-script.qs"
      system "echo '    gui.clickButton(buttons.NextButton);' >> qt-installer-script.qs"
      system "echo '}' >> qt-installer-script.qs"
      system "echo 'Controller.prototype.CredentialsPageCallback = function() {' >> qt-installer-script.qs"
      system "echo '    gui.clickButton(buttons.NextButton);' >> qt-installer-script.qs"
      system "echo '}' >> qt-installer-script.qs"
      system "echo 'Controller.prototype.IntroductionPageCallback = function() {' >> qt-installer-script.qs"
      system "echo '    gui.clickButton(buttons.NextButton);' >> qt-installer-script.qs"
      system "echo '}' >> qt-installer-script.qs"
      system "echo 'Controller.prototype.TargetDirectoryPageCallback = function() {' >> qt-installer-script.qs"
      system "echo '    gui.currentPageWidget().TargetDirectoryLineEdit.setText(\"/usr/local/share/qt\");' >> qt-installer-script.qs"
      system "echo '    gui.clickButton(buttons.NextButton);' >> qt-installer-script.qs"
      system "echo '}' >> qt-installer-script.qs"
      system "echo 'Controller.prototype.ComponentSelectionPageCallback = function() {' >> qt-installer-script.qs"
      system "echo '    var widget = gui.currentPageWidget();' >> qt-installer-script.qs"
      system "echo '    widget.deselectAll();' >> qt-installer-script.qs"
      system "echo '    widget.selectComponent(\"qt.tools.qtcreator\");' >> qt-installer-script.qs"
      system "echo '    widget.selectComponent(\"qt.extras\");' >> qt-installer-script.qs"
      system "echo '    gui.clickButton(buttons.NextButton);' >> qt-installer-script.qs"
      system "echo '}' >> qt-installer-script.qs"
      system "echo 'Controller.prototype.LicenseAgreementPageCallback = function() {' >> qt-installer-script.qs"
      system "echo '    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);' >> qt-installer-script.qs"
      system "echo '    gui.clickButton(buttons.NextButton);' >> qt-installer-script.qs"
      system "echo '}' >> qt-installer-script.qs"
      system "echo 'Controller.prototype.StartMenuDirectoryPageCallback = function() {' >> qt-installer-script.qs"
      system "echo '    gui.clickButton(buttons.NextButton);' >> qt-installer-script.qs"
      system "echo '}' >> qt-installer-script.qs"
      system "echo 'Controller.prototype.ReadyForInstallationPageCallback = function() {' >> qt-installer-script.qs"
      system "echo '    gui.clickButton(buttons.NextButton);' >> qt-installer-script.qs"
      system "echo '}' >> qt-installer-script.qs"
      system "echo 'Controller.prototype.FinishedPageCallback = function() {' >> qt-installer-script.qs"
      system "echo '    var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm' >> qt-installer-script.qs"
      system "echo '    if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {' >> qt-installer-script.qs"
      system "echo '        checkBoxForm.launchQtCreatorCheckBox.checked = false;' >> qt-installer-script.qs"
      system "echo '    }' >> qt-installer-script.qs"
      system "echo '    gui.clickButton(buttons.FinishButton);' >> qt-installer-script.qs"
      system "echo '}' >> qt-installer-script.qs"
    end
    case ARCH
    when 'i686'
      system 'wget http://download.qt.io/official_releases/online_installers/qt-unified-linux-x86-online.run'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('qt-unified-linux-x86-online.run') ) == 'b9dfef211d3122ab2f1b1e96aa7e2357ebdeb068c750eeb423b9396a3f55d619'
      system "install -Dm755 qt-unified-linux-x86-online.run #{CREW_PREFIX}/tmp/qt-unified-linux-x86-online.run"
      system "#{CREW_PREFIX}/tmp/qt-unified-linux-x86-online.run --script qt-installer-script.qs"
      system "rm -f #{CREW_PREFIX}/tmp/qt-unified-linux-x86-online.run"
    when 'x86_64'
      system 'wget http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('qt-unified-linux-x64-online.run') ) == 'dc11d9fb331af9751d80259bbb9d632d6ea4cb945dfa3aea3a79c3e3b50a5b39'
      system "install -Dm755 qt-unified-linux-x64-online.run #{CREW_PREFIX}/tmp/qt-unified-linux-x64-online.run"
      system "#{CREW_PREFIX}/tmp/qt-unified-linux-x64-online.run --script qt-installer-script.qs"
      system "rm -f #{CREW_PREFIX}/tmp/qt-unified-linux-x64-online.run"
    end
    case ARCH
    when 'i686', 'x86_64'
      system "mkdir -p #{CREW_DEST_PREFIX}/bin"
      system "mkdir -p #{CREW_DEST_PREFIX}/share"
      system "cp -r #{CREW_PREFIX}/share/qt #{CREW_DEST_PREFIX}/share"
      system "ln -s #{CREW_PREFIX}/share/qt/Tools/QtCreator/bin/qtcreator #{CREW_DEST_PREFIX}/bin/qtcreator"
    end
  end
end
