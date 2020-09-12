require 'package'

class Qtcreator < Package
  description 'Qt is a comprehensive cross-platform framework and toolkit that helps you create and build native applications and user interfaces for all the screens of your end user.'
  homepage 'https://info.qt.io/download-qt-for-application-development'
  version '4.9.1'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'http://download.qt.io/official_releases/qt/5.15/5.15.1/md5sums.txt'
    source_sha256 '50ea8bf9728b8ceb3a92044745edd55fd02783b8733da7fd57e044bc21980bf6'
    depends_on 'xdg_base'
    depends_on 'sommelier'
  end

  def self.install
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
    system "echo '    gui.currentPageWidget().TargetDirectoryLineEdit.setText(\"#{CREW_PREFIX}/share/qt\");' >> qt-installer-script.qs"
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
    case ARCH
    when 'i686'
      system 'wget http://qtmirror.ics.com/pub/qtproject/archive/online_installers/2.0/qt-unified-linux-x86-2.0.5-2-online.run'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('qt-unified-linux-x86-2.0.5-2-online.run') ) == 'b9dfef211d3122ab2f1b1e96aa7e2357ebdeb068c750eeb423b9396a3f55d619'
      system "install -Dm755 qt-unified-linux-x86-2.0.5-2-online.run #{CREW_PREFIX}/tmp/qt-unified-linux-x86-2.0.5-2-online.run"
      system "#{CREW_PREFIX}/tmp/qt-unified-linux-x86-2.0.5-2-online.run --script qt-installer-script.qs"
      system "rm -f #{CREW_PREFIX}/tmp/qt-unified-linux-x86-2.0.5-2-online.run"
    when 'x86_64'
      system 'wget http://qt.mirror.constant.com/archive/online_installers/3.2/qt-unified-linux-x64-3.2.3-online.run'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('qt-unified-linux-x64-3.2.3-online.run') ) == 'b724dabc0e7bfde1e078de3edcdd87c94b60031f9896d7119099a66191d75eec'
      system "install -Dm755 qt-unified-linux-x64-3.2.3-online.run #{CREW_PREFIX}/tmp/qt-unified-linux-x64-3.2.3-online.run"
      system "#{CREW_PREFIX}/tmp/qt-unified-linux-x64-3.2.3-online.run --script qt-installer-script.qs"
      system "rm -f #{CREW_PREFIX}/tmp/qt-unified-linux-x64-3.2.3-online.run"
    end
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share"
    system "cp -r #{CREW_PREFIX}/share/qt #{CREW_DEST_PREFIX}/share"
    system "ln -s #{CREW_PREFIX}/share/qt/Tools/QtCreator/bin/qtcreator #{CREW_DEST_PREFIX}/bin/qtcreator"
  end
end
