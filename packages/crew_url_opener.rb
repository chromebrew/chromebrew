require 'package'

class Crew_url_handler < Package
  description 'Script for opening an URL in Chrome OS browser'
  homepage 'https://github.com/skycocker/chromebrew'
  version '1.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'

  @_www_browser_symlinks = ["#{CREW_PREFIX}/bin/x-www-browser", "#{CREW_PREFIX}/bin/gnome-www-browser"]

  def self.preflight
    # check if `UrlHandlerService` service exist
    @_service = Kernel.system <<~CMD
      dbus-send --system \
        --dest=org.chromium.UrlHandlerService \
        --type=method_call \
        --print-reply \
        /org/chromium/UrlHandlerService \
        org.freedesktop.DBus.Peer.Ping
    CMD

    unless @_service
      abort "This package is not compatible with your device :/".lightred
    end
  end

  def self.build
    @_script = <<~SCRIPT
      #!/bin/bash
      case "${1}" in
      ''|-h|--help)
        cat <<EOF
      ${0##*/}: Open an URL in Chrome OS browser.

      Usage:
        ${0##*/} <option> [URL]
          -h --help      Show this message

      Note: only support URL start with 'http://', 'https://', 'mailto://', 'ftp://'
      EOF

      ;;
      *)
        exec dbus-send \
          --system \
          --type=method_call \
          --print-reply \
          --dest=org.chromium.UrlHandlerService \
          /org/chromium/UrlHandlerService \
          org.chromium.UrlHandlerServiceInterface.OpenUrl \
          "string:${1}"
      ;;
      esac
    SCRIPT

    # reference:
    # https://chromium.googlesource.com/chromiumos/containers/cros-container-guest-tools/+log/refs/heads/main/cros-garcon/garcon_host_browser.desktop

    @_desktop = <<~EOF
      [Desktop Entry]
      Name=Chrome OS Host Browser
      Exec=crew-url-handler %U
      MimeType=x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/mailto;
      Type=Application
      NoDisplay=true
      OnlyShowIn=Never
    EOF
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/bin/", "#{CREW_DEST_PREFIX}/share/application/"]
    File.write "#{CREW_DEST_PREFIX}/share/application/cros_host_browser.desktop", @_desktop
    File.open "#{CREW_DEST_PREFIX}/bin/crew-url-handler", 'w' do |file|
      file.write(@_script)
      file.chmod(0755)
    end
  end

  def self.postinstall
    print 'Set Chrome OS browser as default? [Y/n]: '

    case STDIN.getc
    when "\n", 'Y', 'y'
      @_www_browser_symlinks.each do |symlink|
        FileUtils.ln_sf 'crew-url-handler', symlink
      end
      puts 'Chrome OS browser is now default.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end

    puts "Type 'crew-url-handler' for usage"
  end

  def self.remove
    @_www_browser_symlinks.each do |symlink|
      if File.exist?(symlink) and File.realpath(symlink) == "#{CREW_PREFIX}/bin/crew-url-handler"
        FileUtils.rm_f(symlink)
      end
    end
  end
end
