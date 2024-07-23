require 'package'

class Qtcreator < Package
  description 'Qt is a comprehensive cross-platform framework and toolkit that helps you create and build native applications and user interfaces for all the screens of your end user.'
  homepage 'https://info.qt.io/download-qt-for-application-development'
  version '11.0.3'
  license 'unknown' # Can't find license
  compatibility 'x86_64'
  source_url 'SKIP'

  depends_on 'sommelier' # L
  depends_on 'xcb_util_image' # R
  depends_on 'xcb_util_keysyms' # R
  depends_on 'xcb_util_renderutil' # R
  depends_on 'xcb_util_wm' # R
  depends_on 'xdg_base' # L

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
    downloader 'https://download.qt.io/archive/online_installers/4.6/qt-unified-linux-x64-4.6.1-online.run', '11f8e9307a31d283b7ad80050e9d43c1e94dbc2ea283eb6fa9d051549f2bbccb'
    FileUtils.install 'qt-unified-linux-x64-4.6.1-online.run', "#{CREW_PREFIX}/tmp/qt-unified-linux-x64-4.6.1-online.run", mode: 0o755
    system "#{CREW_PREFIX}/tmp/qt-unified-linux-x64-4.6.1-online.run --script qt-installer-script.qs"
    FileUtils.rm_f "#{CREW_PREFIX}/tmp/qt-unified-linux-x64-4.6.1-online.run"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.cp_r "#{CREW_PREFIX}/share/qt", "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_s "#{CREW_PREFIX}/share/qt/Tools/QtCreator/bin/qtcreator", "#{CREW_DEST_PREFIX}/bin/qtcreator"
  end
end
