require 'package'

class Qt < Package
  description 'Qt is a comprehensive cross-platform framework and toolkit that helps you create and build native applications and user interfaces for all the screens of your end user.'
  homepage 'https://info.qt.io/download-qt-for-application-development'
  version '5.9.1'
  source_url 'http://download.qt.io/official_releases/qt/5.9/5.9.1/Qt-591-qtbase-patch-for-IOS-QTBUG-61690.zip'
  source_sha256 'a4cfa103b480e67ebc0c91d02845f94bf443c60f847980fa5b38a1303bd6e985'

  depends_on 'unzip'

  def self.install
    if ( ARCH == 'i686' || ARCH == 'x86_64' )
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
      system 'chmod +x qt-unified-linux-x86-online.run'
      system 'cp qt-unified-linux-x86-online.run /usr/local/bin'
      system 'qt-unified-linux-x86-online.run --script qt-installer-script.qs'
      system 'rm -f /usr/local/bin/qt-unified-linux-x86-online.run'
    when 'x86_64'
      system 'wget http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('qt-unified-linux-x64-online.run') ) == 'dc11d9fb331af9751d80259bbb9d632d6ea4cb945dfa3aea3a79c3e3b50a5b39'
      system 'chmod +x qt-unified-linux-x64-online.run'
      system 'cp qt-unified-linux-x64-online.run /usr/local/bin'
      system 'qt-unified-linux-x64-online.run --script qt-installer-script.qs'
      system 'rm -f /usr/local/bin/qt-unified-linux-x64-online.run'
    end
    if ( ARCH == 'i686' || ARCH == 'x86_64' )
      system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
      system "mkdir -p #{CREW_DEST_DIR}/usr/local/share"
      system "cp -r /usr/local/share/qt #{CREW_DEST_DIR}/usr/local/share"
      FileUtils.cd("#{CREW_DEST_DIR}/usr/local/bin") do
        system "ln -s /usr/local/share/qt/Tools/QtCreator/bin/qtcreator qtcreator"
      end
    end
  end
end
