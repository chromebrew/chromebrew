require 'json'
require_relative 'color'

class Pip
  def self.get_info(pkgName)
    pkgInfo = JSON.parse(`curl -LSs https://pypi.org/pypi/#{pkgName}/json`, symbolize_names: true)

    {
      description: pkgInfo[:info][:description],
      homepage: pkgInfo[:info][:home_page],
      license: pkgInfo[:info][:license],
      version: pkgInfo[:info][:version]
    }.transform_values(&:chomp)
  end

  def self.update_installed_list
    @installed = `pip list`.lines(chomp: true)[2..].map(&:split).to_h
  end

  def self.installed_list
    @installed || update_installed_list

    return @installed
  end

  def self.install(pkgName)
    @installed || update_installed_list

    if @installed.key?(pkgName)
      warn "Package py3_#{pkgName} already installed, skipping...".lightgreen
      return false
    else
      system 'pip', 'install', pkgName, exception: true
      update_installed_list
    end
  end

  def self.remove(pkgName)
    @installed || update_installed_list

    if @installed.key?(pkgName)
      system 'pip', 'uninstall', '--yes', pkgName, exception: true
      update_installed_list
    else
      warn "Package py3_#{pkgName} isn't installed.".lightred
      return false
    end
  end

  def self.reinstall(pkgName)
    remove pkgName
    install pkgName
  end
end