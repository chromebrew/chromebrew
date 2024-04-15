#!/usr/bin/env ruby

if ARGV.include?('-h') || ARGV.include?('--help')
  abort "Usage: ./version.rb [<package>] [-h, --help, -v, --verbose]
Example: ./version.rb abcde -v
The <package> can contain '*': ./version.rb xorg_*
If <package> is omitted, all packages will be checked."
end

require 'json'
require 'net/http'

# Add >LOCAL< lib to LOAD_PATH
$LOAD_PATH.unshift '../lib'

require_relative '../lib/color'
require_relative '../lib/package'

def get_version(name, homepage)
  anitya_id = get_anitya_id(name, homepage)
  # If we weren't able to get an Anitya ID, return early here to save time and headaches
  return '' if anitya_id.nil?
  # Get the latest version of the package
  json = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/versions/?project_id=#{anitya_id}")))
  return '' if json['latest_version'].nil?
  return json['latest_version'].chomp
end

def get_anitya_id(name, homepage)
  # Find out how many packages Anitya has with the provided name.
  json = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/projects/?name=#{name}")))
  number_of_packages = json['total_items']

  if number_of_packages == 1 # We assume we have the right package, take the ID and move on.
    return json['items'][0]['id']
  elsif number_of_packages.zero? # Anitya either doesn't have this package, or has it under a different name.
    # If it has it under a different name, check if it has the name used by Chromebrew.
    json2 = JSON.parse(Net::HTTP.get(URI("https://release-monitoring.org/api/v2/packages/?name=#{name}")))
    return if (json2['total_items']).zero?

    (0..json2['total_items'] - 1).each do |i|
      next unless json2['items'][i]['distribution'] == 'Chromebrew'
      return get_anitya_id(json2['items'][i]['project'], homepage) if json2['items'][i]['name'] == name
    end
  else # Anitya has more than one package with this exact name.
    candidates = []
    # First, we remove any candidates which are provided by language package managers, such as pip.
    # This is because Chromebrew does not repackage them (#7713), so they won't be what we're looking for.
    (0..number_of_packages - 1).each do |i|
      # If a package is not provided by a language package manager, the ecosystem will be set to the homepage.
      # https://release-monitoring.org/static/docs/api.html#get--api-v2-projects-
      candidates.append(i) if json['items'][i]['ecosystem'] == json['items'][i]['homepage']
    end

    if candidates.length == 1 # If there's only one candidate left, we're done.
      return json['items'][candidates[0]]['id']
    elsif candidates.empty? # The package we're looking for is provided by a language package manager.
      # We probably shouldn't be providing this package.
      return
    else # There are still multiple candidates left.
      # This is where things get a little uncertain.
      # We check if the homepage Anitya has matches ours, but this really only works for Github projects.
      # For other projects, there's a lot more opinion involved in choosing the exact homepage.
      # Nevertheless, its our best shot at this point.
      candidates.each do |candidate|
        # We assume there is only one candidate with the same name and homepage as their crew counterpart.
        # Even if there are multiple candidates with the same name and homepage, its probably fine to treat them as identical.
        # If it isn't fine to treat them as identical, something has gone horribly wrong.
        return json['items'][candidate]['id'] if homepage == json['items'][candidate]['homepage']
      end

      # If we're still here, that means none of the candidates had the same homepage as their crew counterpart.
      # Not much we can do at this point to find the version, and its better to be cautious to avoid getting the wrong candidate.
      return
    end
  end
end

# Check for valid semantic version.
def valid_semantic_version?(version)
  valid = (version =~ /^[0-9a-zA-Z\.\-]*$/)
  return valid
end

filelist = []
verbose = ARGV.include?('-v') || ARGV.include?('--verbose')
if ARGV.length.positive? && !(ARGV.length == 1 && verbose)
  ARGV.each do |arg|
    next unless arg =~ /^[0-9a-zA-Z\_\*]+$/
    if arg.include?('*')
      Dir["../packages/#{arg}.rb"].each do |filename|
        filelist.push filename
      end
    else
      filename = "../packages/#{arg}.rb"
      filelist.push filename if File.exist?(filename)
    end
  end
else
  Dir['../packages/*.rb'].each do |filename|
    filelist.push filename
  end
end

if filelist.length.positive?
  puts "#{'Package'.ljust(35)}#{'Status'.ljust(20)}#{'Current'.ljust(20)}Upstream"
  puts "#{'-------'.ljust(35)}#{'------'.ljust(20)}#{'-------'.ljust(20)}--------"
  filelist.each do |filename|
    pkg = Package.load_package(filename)
    # Instead of typing out the name of every python package, we just use a regex here
    if pkg.name.match?(/py3\S+/)
      puts pkg.name.ljust(35) + 'noupdate'.lightred if verbose
      next
    end
    # Package is fake
    if pkg.is_fake?
      puts pkg.name.ljust(35) + 'fake'.lightred if verbose
      next
    end
    # No upstream update available
    if pkg.no_upstream_update?
      puts pkg.name.ljust(35) + 'noupdate'.lightred if verbose
      next
    end
    # Some packages don't work with this yet, so gracefully exit now rather than throwing false positives
    upstream_version = get_version(pkg.name.tr('_', '-'), pkg.homepage)
    if upstream_version.nil?
      puts pkg.name.ljust(35) + 'notfound'.lightred if verbose
      next
    end

    status = if upstream_version == pkg.version
               'uptodate'.ljust(20).lightgreen
             elsif upstream_version.empty? || pkg.version.empty?
               'notfound'.ljust(20).lightred
             elsif valid_semantic_version?(upstream_version) && valid_semantic_version?(pkg.version)
               if Gem::Version.correct?(upstream_version) && Gem::Version.correct?(pkg.version)
                 if Gem::Version.new(upstream_version) > Gem::Version.new(pkg.version)
                   'outdated'.ljust(20).yellow
                 else
                   'mismatch'.ljust(20).orange
                 end
               else
                 'notvalid'.ljust(20).lightred
               end
             else
               'notvalid'.ljust(20).lightred
             end
    puts pkg.name.ljust(35) + status + pkg.version.ljust(20) + upstream_version unless !verbose && status == 'uptodate'.ljust(20).lightgreen
  end
end
